// class MessageModel {
//   final String senderId;
//   final String receiverId;
//   final String message;
//   final DateTime createdAt;

//   MessageModel({
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//     required this.createdAt,
//   });

//   factory MessageModel.fromJson(Map<String, dynamic> json) {
//     return MessageModel(
//       senderId: json['senderid'].toString(),
//       receiverId: json['receiverid'].toString(),
//       message: json['message'],
//       createdAt: DateTime.parse(json['created_at']),
//     );
//   }
// }

class MessageModel {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime createdAt;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['sender_id'].toString(), // match API key
      receiverId: json['receiver_id'].toString(),
      message: json['message'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'sender_id': senderId,
        'receiver_id': receiverId,
        'message': message,
        'created_at': createdAt.toIso8601String(),
      };
}
