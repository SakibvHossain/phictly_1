import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phictly/core/helper/sheared_prefarences_helper.dart';
import 'package:phictly/core/network_caller/service/service.dart';
import 'package:web_socket_channel/io.dart';
import '../../../../core/network_caller/utils/utils.dart';
import '../model/chat_model.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  RxBool isLoading = false.obs;
  ScrollController scrollController = ScrollController();
  RxString roomId = "".obs;
  RxString userId = "".obs;
  late String currentUserId;
  late String friendId;

  ChatUser get user => ChatUser(id: currentUserId);

  final RxList<Message> allMessages = <Message>[].obs;

  IOWebSocketChannel? _channel;

  RxBool isConnected = false.obs;
  @override
  void onInit() {
    super.onInit();

    Future.wait([
      connect(),
    ]);
    joinApp();
  }

  Future<void> connect() async {
    await preferencesHelper.init();
    String? token = preferencesHelper.getString("userToken");
    debugPrint("======---===>>>>>>token while connecting: $token");

    if (token != null) {
      try {
        _channel = IOWebSocketChannel.connect(
          Uri.parse('ws://10.0.20.15:5006'),
          headers: {"x-token": token},
        );
        isConnected.value = true;

        _channel!.stream.listen(
          (message) {
            debugPrint("message========>>>>>>: $message");
            _handleMessage(message);
          },
          onError: (error) {
            debugPrint('WebSocket Error: $error');
            isConnected.value = false;
            reconnect();
          },
          onDone: () {
            debugPrint('WebSocket connection closed');
            isConnected.value = false;
          },
        );
      } catch (e) {
        debugPrint('WebSocket connection failed: $e');
        isConnected.value = false;
        reconnect();
      }
    } else {
      debugPrint("=========<><-----><>$token null value token");
    }
  }

  void _handleMessage(String message) {
    final decodedMessage = jsonDecode(message);
    final type = decodedMessage['type'];

    switch (type) {
      case 'receivePrivateMessage':
        break;

      case 'joinApp':
        debugPrint("==================${decodedMessage['message']}");
        break;
      case 'joinSuccess':
        roomId.value = decodedMessage['chatroomId'];
        debugPrint("+++++======$roomId");
        break;

      case 'sendPrivateMessage':
        break;
      case 'conversationList':
        break;
      case 'authSuccess':
        String user = decodedMessage['userId'];
        debugPrint("======userid===========$user");
        userId.value = user;
        break;
      default:
        debugPrint("======Unhandled message type: $type");
    }
  }

  void joinApp() {
    debugPrint("=================api called");
    final data = {"type":"joinApp"};
    final join = jsonEncode(data);
    _channel!.sink.add(join);

    debugPrint("=========sdf========api called");
  }

  void joinPrivateChat(String userId2) {
    debugPrint("Joining private chat with room: $userId2");
    final joinPrivate =
        jsonEncode({"type": "joinPrivateChat", "user2Id": userId2});
    _channel!.sink.add(joinPrivate);
  }

  void sendPrivateMessage(String senderId, String receiverId, String content) {
    debugPrint("Sending private message: $content");
    final message = jsonEncode({
      "type": "sendPrivateMessage",
      "senderId": senderId,
      "receiverId": receiverId,
      "content": content,
    });
    _channel!.sink.add(message);
  }

  void close() {
    if (_channel != null) {
      _channel?.sink.close();
      isConnected.value = false;
    }
  }

  void reconnect() {
    if (_channel == null ||
        _channel!.closeCode == null ||
        _channel!.closeCode != 1000) {
      debugPrint("Reconnecting...");

      connect();
    }
  }

  Future<void> getMesseages(String id) async {
    await preferencesHelper.init();
    String? token = preferencesHelper.getString('userToken');

    if (token != null) {
      try {
        isLoading.value = true;

        final response = await NetworkCaller().getRequest(
          "${Utils.baseUrl}/chat/get-single-message/$id",
          token: token,
        );

        if (response.isSuccess) {
          final List<dynamic> resultList = response.responseData;
          allMessages.clear();
          allMessages
              .addAll(resultList.map((e) => Message.fromJson(e)).toList());
          debugPrint("=====data=========${allMessages.length}");
        } else {
          debugPrint("=============Request failed: ${response.responseData}");
        }
      } catch (e) {
        debugPrint("================Error fetching messages: $e");
      } finally {
        isLoading.value = false;
      }
    } else {
      debugPrint("Token is null");
    }
  }
}
