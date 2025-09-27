import '../services/api_services.dart';
import '../services/socket_service.dart';
import '../models/message_model.dart';

class ChatController {
  final ApiService _apiService = ApiService();
  final SocketService _socketService = SocketService();

  void connectSocket(String userId) {
    _socketService.connect(userId);
  }

  void sendMessage(String senderId, String receiverId, String message) async {
    await _apiService.sendMessage(senderId, receiverId, message);

    // _socketService.sendMessage(senderId, receiverId, message);
  }

  void onMessage(Function(MessageModel) callback) {
    _socketService.onMessage((data) {
      callback(MessageModel.fromJson(data));
    });
  }

  Future<List<MessageModel>> getMessages(String user1, String user2) async {
    final response = await _apiService.getMessages(user1, user2);
    return (response.data as List)
        .map((msg) => MessageModel.fromJson(msg))
        .toList();
  }

  void disconnectSocket() {
    _socketService.disconnect();
  }
}
