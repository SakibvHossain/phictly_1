import 'dart:convert';
import 'dart:io';
import '../../../../core/helper/sheared_prefarences_helper.dart';

typedef OnWebSocketMessage = void Function(Map<String, dynamic> data);

class WebSocketService {
  late WebSocket _socket;
  final String serverUrl = 'ws://10.0.20.15:5006'; // Replace with your server IP
  final SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  OnWebSocketMessage? onMessage;

  Future<void> connect() async {
    print("Connecting to WebSocket...");

    _socket = await WebSocket.connect(
      serverUrl,
      headers: {
        'x-token': preferencesHelper.getString('userToken'),
      },
    );

    print("WebSocket connected!");

    _send({"type": "joinApp"});
    print("Sent: joinApp");

    _socket.listen((event) {
      print("Message received from WebSocket: $event");
      final data = jsonDecode(event);
      onMessage?.call(data);
    }, onError: (e) {
      print("WebSocket error: $e");
    }, onDone: () {
      print("WebSocket connection closed");
    });
  }

  void joinPrivateChat(String userId2) {
    print("Joining private chat with room: $userId2");
    _send({"type": "joinPrivateChat", "user2Id": userId2});
  }

  void sendPrivateMessage(String senderId, String receiverId, String content) {
    print("Sending private message: $content");
    _send({
      "type": "sendPrivateMessage",
      "senderId": senderId,
      "receiverId": receiverId,
      "content": content,
    });
  }

  void _send(Map<String, dynamic> data) {
    final jsonData = jsonEncode(data);
    print("Sending to WebSocket: $jsonData");
    _socket.add(jsonData);
  }

  void close() {
    print("Closing WebSocket connection");
    _socket.close();
  }
}

//68346306135f632ff37830c8
