import 'dart:io';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect(String userId) {
    socket = IO.io("http://192.168.1.9:5000",
        IO.OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((_) {
      print("Connected to socket");
      socket.emit("join", userId); // join personal room
    });
  }

  void sendMessage(String senderId, String receiverId, String message) {
    socket.emit("send_message", {
      "senderId": senderId,
      "receiverId": receiverId,
      "message": message,
    });
  }

  void onMessage(Function(Map<String, dynamic>) callback) {
    socket.on("receive_message", (data) => callback(data));
  }

  void disconnect() {
    socket.disconnect();
  }
}
