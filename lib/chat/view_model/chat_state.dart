import 'package:chat_app/chat/data/model/message.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class SendMessageLoading extends ChatState {}

class SendMessageSuccess extends ChatState {}

class SendMessageError extends ChatState {
  final String message;
  SendMessageError(this.message);
}

class GetMessagesStreamLoading extends ChatState {}

class GetMessagesStreamSuccess extends ChatState {
  final Stream<List<MessageModel>> stream;
  GetMessagesStreamSuccess(this.stream);
}

class GetMessagesStreamError extends ChatState {
  final String message;
  GetMessagesStreamError(this.message);
}
