import 'package:chat_app/auth/data/models/user_model.dart';
import 'package:chat_app/chat/data/model/message.dart';
import 'package:chat_app/chat/view_model/chat_state.dart';
import 'package:chat_app/core/database_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatViewModel extends Cubit<ChatState> {
  ChatViewModel() : super(ChatInitial());

  final messageController = TextEditingController();
  late final UserModel currentUser;
  late final String roomId;

  Future<void> sendMessage() async {
    if (messageController.text.isEmpty) return;
    emit(SendMessageLoading());
    try {
      await DatabaseUtils.insertMessageToRooms(
        MessageModel(
          isImage: false,
          content: messageController.text,

          senderId: currentUser.id,
          senderName: currentUser.name,
          roomId: roomId,
        ),
      );
      messageController.clear();
      emit(SendMessageSuccess());
    } catch (error) {
      emit(SendMessageError(error.toString()));
    }
  }

  Future<void> getMessageStream() async {
    emit(GetMessagesStreamLoading());
    try {
      final messages = DatabaseUtils.getRoomMessages(roomId);
      emit(GetMessagesStreamSuccess(messages));
    } catch (error) {
      emit(GetMessagesStreamError(error.toString()));
    }
  }

  bool isMyMessage(String messageId) => messageId == currentUser.id;

  @override
  Future<void> close() {
    messageController.dispose();
    return super.close();
  }
}
