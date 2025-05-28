import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../helper/sheared_prefarences_helper.dart';
import '../model/model.dart';

class NetworkCaller {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final int timeoutDuration = 60;

  Uri _parseUrl(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'http://$url';
    }
    return Uri.parse(url);
  }

  Future<ResponseData> _makeRequest(
      String method,
      String url, {
        Map<String, dynamic>? body,
        Map<String, String>? headers,
        String? token,
      }) async {
    final parsedUrl = _parseUrl(url);
    headers ??= {};
    if (token != null) {
      headers['Authorization'] = token;
    }
    headers['Content-Type'] = 'application/json';
    log('Request Header: $headers');
    log('Request Method: $method');
    log('Request URL: $parsedUrl');
    if (body != null) log('Request Body: ${jsonEncode(body)}');

    try {
      late http.Response response;

      switch (method) {
        case 'GET':
          response = await http
              .get(parsedUrl, headers: headers)
              .timeout(Duration(seconds: timeoutDuration));
          break;
        case 'POST':
          response = await http
              .post(parsedUrl, headers: headers, body: jsonEncode(body))
              .timeout(Duration(seconds: timeoutDuration));
          break;
        case 'PUT':
          response = await http
              .put(parsedUrl, headers: headers, body: jsonEncode(body))
              .timeout(Duration(seconds: timeoutDuration));
          break;
        case 'DELETE':
          response = await http
              .delete(parsedUrl, headers: headers, body: jsonEncode(body))
              .timeout(Duration(seconds: timeoutDuration));
          break;
        case 'PATCH':
          response = await http
              .patch(parsedUrl, headers: headers, body: jsonEncode(body))
              .timeout(Duration(seconds: timeoutDuration));
          break;
        default:
          throw UnsupportedError('HTTP method $method not supported');
      }

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> getRequest(String url, {String? token}) {
    return _makeRequest('GET', url, token: token);
  }

  Future<ResponseData> postRequest(String url,
      {Map<String, dynamic>? body, String? token}) {
    return _makeRequest('POST', url, body: body, token: token);
  }

  Future<ResponseData> putRequest(String url,
      {Map<String, dynamic>? body, String? token}) {
    return _makeRequest('PUT', url, body: body, token: token);
  }

  Future<ResponseData> deleteRequest(String url,
      {Map<String, dynamic>? body, String? token}) {
    return _makeRequest('DELETE', url, body: body, token: token);
  }

  Future<ResponseData> patchRequest(String url,
      {Map<String, dynamic>? body, String? token}) {
    return _makeRequest('PATCH', url, body: body, token: token);
  }

  ResponseData _handleResponse(http.Response response) {
    log('Response Status: ${response.statusCode}');
    log('Response Body: ${response.body}');

    try {
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse['result'] ?? decodedResponse,
          errorMessage: '',
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['message'] ?? 'An error occurred',
        );
      }
    } catch (e) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
        errorMessage: 'Failed to parse response: $e',
      );
    }
  }

  ResponseData _handleError(dynamic error) {
    log('Request Error: $error');

    if (error is TimeoutException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 408,
        responseData: '',
        errorMessage: 'Request timeout. Please try again later.',
      );
    } else if (error is http.ClientException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Network error. Please check your connection.',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Unexpected error occurred: $error',
      );
    }
  }

  Future<String> uploadImage(File imageFile, String imagUrl,String fileName ) async {
    await preferencesHelper.init();
    String? token = preferencesHelper.getString("userToken");

    if(token!= null){
      try {
        var url = Uri.parse(imagUrl);


        var request = http.MultipartRequest('POST', url);

        String? mimeType = lookupMimeType(imageFile.path);

        request.files.add(
          await http.MultipartFile.fromPath(
            fileName,
            imageFile.path,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          ),
        );

        request.headers.addAll({

          "Content-Type": "multipart/form-data",
        });

        var response = await request.send();

        var responseBody = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          debugPrint("=========done===>>>>${response.stream}");
          debugPrint("========>>>File uploaded successfully");
          return responseBody;
        } else {
          debugPrint("============>>>>${response.stream}");
          debugPrint("============>>Failed to upload file: ${response.statusCode}");
        }
      } catch (e) {
        debugPrint("==============>>Error uploading file: $e");
      }
    }else{
      debugPrint("==================>>>>Token Null");
    }

    return '';
  }
}