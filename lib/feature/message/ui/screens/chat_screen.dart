import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import '../../data/controller/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final String friendId;

  const ChatScreen({
    super.key,
    required this.currentUserId,
    required this.friendId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatController(), tag: widget.currentUserId);
    controller.init(widget.currentUserId, widget.friendId);
  }

  @override
  void dispose() {
    Get.delete<ChatController>(tag: widget.currentUserId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Private Chat")),
      body: Obx(() => DashChat(
        currentUser: controller.user,
        onSend: (msg) => controller.sendMessage(msg.text),
        messages: controller.messages.toList(),
      )),
    );
  }
}

//68346330135f632ff37830c9
//68346306135f632ff37830c8