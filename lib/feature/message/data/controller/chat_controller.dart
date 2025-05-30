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
  String id = "";
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
    connect();
    connectAndJoin();
  }

  Future<void> connect() async {
    await preferencesHelper.init();
    String? token = preferencesHelper.getString("userToken");
    debugPrint("======---===>>>>>>token while connecting: $token");

    if (token != null) {
      try {
        _channel = IOWebSocketChannel.connect(
          Uri.parse('ws://69.62.71.168:5006'),
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
        final msgData = decodedMessage['message'];

        if (msgData != null && msgData is Map<String, dynamic>) {
          try {
            final msg = Message.fromJson(msgData);
            allMessages.add(msg); // Add without removing previous messages
            debugPrint(
                "✅ New message added. Total messages: ${allMessages.length}");
          } catch (e) {
            debugPrint("❌ Error parsing message: $e");
          }
        } else {
          debugPrint("❌ Invalid or null message field in response: $msgData");
        }

        break;

      case 'joinApp':
        debugPrint("==================${decodedMessage['message']}");
        break;
      case 'joinSuccess':
        roomId.value = decodedMessage['chatroomId'];
        id = decodedMessage['chatroomId'];
        getMesseages();
        debugPrint("Room=========ID=======${roomId.value} $id");
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

  Future<void> connectAndJoin() async {
    await connect(); // wait for WebSocket connection
    if (_channel != null) {
      joinApp(); // now it's safe
    } else {
      debugPrint("WebSocket connection failed. joinApp() not called.");
    }
  }

  void joinApp() {
    debugPrint("=================api called");

    if (_channel == null) {
      debugPrint("WebSocket channel is null! Cannot send joinApp message.");
      return;
    }

    final data = {"type": "joinApp"};
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

  void sendPrivateMessage(String receiverId, String content) {
    debugPrint("Sending private message: $content");
    final message = jsonEncode({
      "type": "sendPrivateMessage",
      "senderId": userId.value,
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

  Future<void> getMesseages() async {
    await preferencesHelper.init();
    String? token = preferencesHelper.getString('userToken');

    final data = {"conversationId": id};

    if (token != null) {
      try {
        isLoading.value = true;

        final response = await NetworkCaller().postRequest(
          '${Utils.baseUrl}/chat/get-single-message',
          token: token,
          body: data,
        );
        debugPrint("Room=========ID2=======${roomId.value}");
        if (response.isSuccess) {
          final List<dynamic> resultList = response.responseData;
          allMessages.clear();
          allMessages
              .addAll(resultList.map((e) => Message.fromJson(e)).toList());
          debugPrint("=====data=========${allMessages.length}");
        } else {
          debugPrint(
              "======urtl===========${"${Utils.baseUrl}/chat/get-single-message/$roomId"}");
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
