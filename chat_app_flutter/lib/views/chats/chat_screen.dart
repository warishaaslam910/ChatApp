// import 'package:flutter/material.dart';
// import '../../controllers/chat_controller.dart';
// import '../../models/message_model.dart';
// import 'widgets/message_bubble.dart';

// class ChatScreen extends StatefulWidget {
//   final String myUserId;
//   final String friendUserId;

//   const ChatScreen(
//       {super.key, required this.myUserId, required this.friendUserId});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final ChatController _chatController = ChatController();
//   final TextEditingController _msgController = TextEditingController();

//   List<MessageModel> messages = [];

//   @override
//   void initState() {
//     super.initState();
//     _chatController.connectSocket(widget.myUserId);

//     _chatController
//         .getMessages(widget.myUserId, widget.friendUserId)
//         .then((msgs) {
//       setState(() => messages = msgs);
//     });

//     _chatController.onMessage((msg) {
//       if ((msg.senderId == widget.friendUserId &&
//               msg.receiverId == widget.myUserId) ||
//           (msg.senderId == widget.myUserId &&
//               msg.receiverId == widget.friendUserId)) {
//         setState(() => messages.add(msg));
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _chatController.disconnectSocket();
//     super.dispose();
//   }

//   void _sendMessage() {
//     if (_msgController.text.isNotEmpty) {
//       _chatController.sendMessage(
//           widget.myUserId, widget.friendUserId, _msgController.text);
//       _msgController.clear();
//     }
//   }

//   List<MessageModel> mess = [
//     MessageModel(
//       senderId: "123",
//       receiverId: "456",
//       message: "Hello!",
//       createdAt: DateTime.now(),
//     ),
//     MessageModel(
//       senderId: "456",
//       receiverId: "123",
//       message: "Hi there!",
//       createdAt: DateTime.now(),
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Chat")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: mess.length,
//               itemBuilder: (context, index) {
//                 final msg = mess[index];

//                 return MessageBubble(
//                   // message: msg,
//                   // isMe: msg.senderId == widget.myUserId,
//                   message: mess[index],
//                   isMe: true, // or false
//                 );
//               },
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _msgController,
//                   decoration: const InputDecoration(
//                     hintText: "Type a message...",
//                     contentPadding: EdgeInsets.all(10),
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.send),
//                 onPressed: _sendMessage,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../controllers/chat_controller.dart';
import '../../models/message_model.dart';
import 'widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String myUserId;
  final String friendUserId;

  const ChatScreen({
    super.key,
    required this.myUserId,
    required this.friendUserId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController _chatController = ChatController();
  final TextEditingController _msgController = TextEditingController();

  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();

    // Connect to socket
    _chatController.connectSocket(widget.myUserId);

    // Fetch existing messages from API
    _chatController
        .getMessages(widget.myUserId, widget.friendUserId)
        .then((msgs) {
      setState(() => messages = msgs);
    });

    // Listen for incoming messages via socket
    _chatController.onMessage((msg) {
      if ((msg.senderId == widget.friendUserId &&
              msg.receiverId == widget.myUserId) ||
          (msg.senderId == widget.myUserId &&
              msg.receiverId == widget.friendUserId)) {
        setState(() => messages.add(msg));
      }
    });
  }

  @override
  void dispose() {
    _chatController.disconnectSocket();
    _msgController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_msgController.text.isNotEmpty) {
      final newMsg = MessageModel(
        senderId: widget.myUserId,
        receiverId: widget.friendUserId,
        message: _msgController.text,
        createdAt: DateTime.now(),
      );

      // Update UI immediately
      setState(() => messages.add(newMsg));

      // Send via API and socket
      _chatController.sendMessage(
          widget.myUserId, widget.friendUserId, _msgController.text);

      _msgController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return MessageBubble(
                  message: msg,
                  isMe: msg.senderId.toString() == widget.myUserId.toString(),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _msgController,
                  decoration: const InputDecoration(
                    hintText: "Type a message...",
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
