import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_text.dart';

import '../../data/controller/chat_controller.dart';
import '../../data/model/chat_model.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String? userName;
  final String? image;

  const ChatScreen(
      {super.key, required this.receiverId, this.userName, this.image});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final chatController = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();

    chatController.joinPrivateChat(widget.receiverId);
    // chatController.getMesseages();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    // Make sure the observer is used correctly
    ever<List<Message>>(chatController.allMessages, (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    });
  }

  @override
  void dispose() {
    chatController.allMessages.clear();
    super.dispose();
  }

  void _scrollToBottom() {
    if (chatController.scrollController.hasClients) {
      chatController.scrollController.animateTo(
        chatController.scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    debugPrint(
        "========>>>>${widget.image},=======>>${widget.receiverId}========>>${widget.userName},");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
             backgroundColor: Colors.grey,
              backgroundImage: (widget.image?.isNotEmpty ?? false)
                  ? CachedNetworkImageProvider(widget.image ?? "https://i.ibb.co/HTZSdvpG/Male-Avatar.jpg")
                  : null,

            ),
            SizedBox(width: 10.w),
            CustomText(
              text: widget.userName ?? "Unknown",
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: Colors.black,
            )
          ],
        ),
        centerTitle: false,
        leading: IconButton(
          padding: EdgeInsets.only(left: 5),
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                try {
                  return chatController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        )
                      : chatController.allMessages.isEmpty
                          ? Center(
                              child: CustomText(
                                  text: "No Conversation Found ",
                                  fontSize: 20.spMin,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 12.w),
                              itemCount: chatController.allMessages.length,
                              controller: chatController.scrollController,
                              reverse: false,
                              itemBuilder: (context, index) {
                                final message =
                                    chatController.allMessages[index];
                                final senderId = message.senderId;
                                final text = message.content;
                                final fileUrl = "";

                                final isSentByMe = senderId != widget.receiverId;

                                return Align(
                                  alignment: isSentByMe
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: isSentByMe
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: 4.h),
                                        child: Row(
                                          mainAxisAlignment: isSentByMe
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                          children: [
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.all(12.w),
                                                decoration: BoxDecoration(
                                                  color: isSentByMe
                                                      ? Color(0xff007CFC)
                                                      : Colors.grey[300],
                                                  borderRadius: isSentByMe
                                                      ? BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  16.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  16.r),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  16.r),
                                                        )
                                                      : BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  16.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  16.r),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  16.r),
                                                        ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (fileUrl.isNotEmpty)
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: fileUrl,
                                                            width:
                                                                double.infinity,
                                                            progressIndicatorBuilder:
                                                                (context, url,
                                                                        progress) =>
                                                                    Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    if (text.isNotEmpty)
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: fileUrl
                                                                    .isNotEmpty
                                                                ? 8.h
                                                                : 0),
                                                        child: Text(
                                                          text,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              GoogleFonts.inter(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: isSentByMe
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                } catch (e) {
                  debugPrint("================>>>ListView error: $e");
                  return Center(
                      child: Text("Failed to load messages",
                          style: TextStyle(color: Colors.red)));
                }
              }),
            ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: "Write your message.....",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                      onTap: () {
                        final receiverId = widget.receiverId;
                        final text = messageController.text.trim();
                        if (text.isNotEmpty && receiverId.isNotEmpty) {
                          chatController.sendPrivateMessage(
                              widget.receiverId, text);
                          messageController.clear();
                        }
                      },
                      child: Icon(Icons.send)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
