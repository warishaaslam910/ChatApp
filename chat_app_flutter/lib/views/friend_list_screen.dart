// import 'package:chat_app_flutter/views/chats/chat_screen.dart';
// import 'package:flutter/material.dart';
// import '../../controllers/auth_controller.dart';
// import '../../models/user_model.dart';

// class FriendListScreen extends StatefulWidget {
//   final UserModel loggedInUser;

//   const FriendListScreen({super.key, required this.loggedInUser});

//   @override
//   State<FriendListScreen> createState() => _FriendListScreenState();
// }

// class _FriendListScreenState extends State<FriendListScreen> {
//   final AuthController _authController = AuthController();
//   List<UserModel> friends = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadFriends();
//   }

//   Future<void> _loadFriends() async {
//     try {
//       // ✅ you need an API for this: GET /auth/users (all users)
//       final response = await _authController.getAllUsers();
//       setState(() {
//         friends = response
//             .where((u) => u.id != widget.loggedInUser.id) // exclude self
//             .toList();
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() => isLoading = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to load friends: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Select Friend")),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: friends.length,
//               itemBuilder: (context, index) {
//                 final friend = friends[index];
//                 return ListTile(
//                   title: Text(friend.name),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ChatScreen(
//                           myUserId: widget.loggedInUser.id,
//                           friendUserId: friend.id,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:chat_app_flutter/views/chats/chat_screen.dart';
import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../models/user_model.dart';

class FriendListScreen extends StatefulWidget {
  final UserModel loggedInUser;

  const FriendListScreen({super.key, required this.loggedInUser});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  final AuthController _authController = AuthController();
  List<UserModel> friends = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    try {
      final response = await _authController.getAllUsers();
      setState(() {
        friends =
            response.where((u) => u.id != widget.loggedInUser.id).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load friends: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Friend")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                final friend = friends[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          myUserId: widget.loggedInUser.id,
                          friendUserId: friend.id,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        // Profile picture avatar
                        CircleAvatar(
                          radius: 24,
                          // backgroundImage: friend.profilePicUrl != null
                          //     ? NetworkImage(friend.profilePicUrl!)
                          //     : null,
                          // child: friend.profilePicUrl == null
                          //     ? Text(
                          //         friend.name[0].toUpperCase(),
                          //         style: TextStyle(
                          //             fontSize: 20, fontWeight: FontWeight.bold),
                          //       )
                          //     : null,
                          backgroundColor: Colors.blueAccent,
                        ),
                        const SizedBox(width: 12),
                        // Name + optional last message
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                friend.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Tap to chat",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Optional: last message time or indicator
                        Icon(Icons.chat_bubble_outline,
                            color: Colors.grey.shade600)
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
