import 'package:get/get.dart';
import '../service/web_socket_service.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatController extends GetxController {
  final WebSocketService _webSocket = WebSocketService();

  RxList<ChatMessage> messages = <ChatMessage>[].obs;

  late String currentUserId;
  late String friendId;

  ChatUser get user => ChatUser(id: currentUserId);

  Future<void> init(String myId, String otherUserId) async {
    currentUserId = myId;
    friendId = otherUserId;

    final roomId = getRoomId(currentUserId, friendId);
    print("Initializing ChatController for room: $roomId");

    await _webSocket.connect();
    _webSocket.joinPrivateChat(friendId);

    _webSocket.onMessage = (data) {
      print("Received data in controller: $data");

      if (data['type'] == 'receivePrivateMessage') {
        final msg = data['message'];

        // ✅ Only show if not sent by current user
        if (msg['senderId'] != currentUserId) {
          messages.insert(
            0,
            ChatMessage(
              text: msg['content'],
              user: ChatUser(id: msg['senderId']),
              createdAt: DateTime.now(),
            ),
          );
        }
      }
    };
  }

  void sendMessage(String content) {
    print("Sending message from $currentUserId to $friendId: $content");

    // ✅ Show message instantly on sender side
    final message = ChatMessage(
      text: content,
      user: ChatUser(id: currentUserId),
      createdAt: DateTime.now(),
    );

    messages.insert(0, message);
    _webSocket.sendPrivateMessage(currentUserId, friendId, content);
  }

  @override
  void onClose() {
    print("ChatController for $currentUserId closed");
    _webSocket.close();
    super.onClose();
  }

  String getRoomId(String user1, String user2) {
    final sorted = [user1, user2]..sort();
    return sorted.join("_");
  }
}
