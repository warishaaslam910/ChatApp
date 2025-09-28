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
//       final response = await _authController.getAllUsers();
//       setState(() {
//         friends =
//             response.where((u) => u.id != widget.loggedInUser.id).toList();
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
//       appBar: AppBar(
//         title: const Text(
//           "Select Friend",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         backgroundColor: Color.fromARGB(255, 85, 23, 155).withOpacity(0.7),
//         elevation: 0,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: friends.length,
//               itemBuilder: (context, index) {
//                 final friend = friends[index];
//                 return InkWell(
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
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 12),
//                     margin:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Color.fromARGB(255, 85, 26, 153).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 2,
//                           offset: Offset(0, 1),
//                         )
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           radius: 24,
//                           backgroundColor:
//                               Color.fromARGB(255, 85, 23, 155).withOpacity(0.7),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 friend.name,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 "Tap to chat",
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.grey.shade600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Icon(Icons.chat_bubble_outline,
//                             color: Colors.grey.shade600),
//                       ],
//                     ),
//                   ),
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

// ------------------ SEARCH BAR WIDGET ------------------
class FriendSearchBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;

  const FriendSearchBar({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
              ),
              onChanged: onSearchChanged,
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------ MAIN SCREEN ------------------
class FriendListScreen extends StatefulWidget {
  final UserModel loggedInUser;

  const FriendListScreen({super.key, required this.loggedInUser});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  final AuthController _authController = AuthController();
  List<UserModel> friends = [];
  List<UserModel> filteredFriends = [];
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
        filteredFriends = List.from(friends); // show all by default
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load friends: $e")),
      );
    }
  }

  void _filterFriends(String query) {
    if (query.isEmpty) {
      setState(() => filteredFriends = List.from(friends));
    } else {
      setState(() {
        filteredFriends = friends
            .where((friend) =>
                friend.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Friend",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor:
            const Color.fromARGB(255, 85, 23, 155).withOpacity(0.7),
        elevation: 0,
      ),
      body: Column(
        children: [
          FriendSearchBar(onSearchChanged: _filterFriends),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredFriends.length,
                    itemBuilder: (context, index) {
                      final friend = filteredFriends[index];
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 85, 26, 153)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                             CircleAvatar(
  radius: 24,
  backgroundColor: const Color.fromARGB(255, 85, 23, 155).withOpacity(0.7),
  backgroundImage: friend.profilePicUrl != null && friend.profilePicUrl!.isNotEmpty
      ? NetworkImage(friend.profilePicUrl!)
      : null,
  child: (friend.profilePicUrl == null || friend.profilePicUrl!.isEmpty)
      ? Text(
          friend.name[0].toUpperCase(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      : null,
),

                              const SizedBox(width: 12),
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
                              Icon(Icons.chat_bubble_outline,
                                  color: Colors.grey.shade600),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
