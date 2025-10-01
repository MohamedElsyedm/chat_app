import 'package:chat_app/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/model/message.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMyMessage;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMyMessage,
  });

  @override
  Widget build(BuildContext context) {
    // to check the sender if the sender id is equal to the current user id
    // final isCurrentUser = message.senderId == FirebaseAuth.instance.currentUser?.uid;

    final textTheme = Theme.of(context).textTheme;
    final List<Widget> firstContent = message.isImage
        ? [
            Image.network(
              message.imageUrl!,
              fit: BoxFit.scaleDown,
              width: MediaQuery.sizeOf(context).width * 0.6,
              height: MediaQuery.sizeOf(context).height * 0.25,
            ),
            Text(message.content, style: textTheme.titleSmall),
          ]
        : [Text(message.content, style: textTheme.titleSmall)];

    return Align(
      alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMyMessage
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          isMyMessage
              ? Text(
                  'You',
                  style: textTheme.bodySmall!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : Text(
                  message.senderName,
                  style: textTheme.bodySmall!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            padding: const EdgeInsets.all(12.0).copyWith(top: 0),
            decoration: BoxDecoration(
              color: isMyMessage
                  ? AppTheme.primary.withValues(alpha: 0.3)
                  : AppTheme.grey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(16.0),
                bottomRight: const Radius.circular(16.0),
                topLeft: Radius.circular(isMyMessage ? 16.0 : 0),
                topRight: Radius.circular(isMyMessage ? 0 : 16.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: isMyMessage
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,

              children: [
                ...firstContent,
                Text(
                  DateFormat.jm().format(message.dateTime),
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
