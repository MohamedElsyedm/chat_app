import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id;
  final String content;
  final String senderId;
  final String senderName;
  DateTime dateTime;
  final bool isImage;
  final String? imageUrl;
  final String roomId;
  MessageModel({
    this.id = '',
    required this.isImage,
    required this.content,
    required this.senderId,
    required this.senderName,
    this.imageUrl,
    required this.roomId,
  }) : dateTime = DateTime.now();

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      content: json['content'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      isImage: json['isImage'],
      imageUrl: json['imageUrl'] ?? '',
      roomId: json['roomId'],
    )..dateTime = (json['dateTime'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'dateTime': FieldValue.serverTimestamp(),
      'senderId': senderId,
      'senderName': senderName,
      'isImage': isImage,
      'imageUrl': imageUrl,
      'roomId': roomId,
    };
  }
}
