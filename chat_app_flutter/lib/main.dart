import 'package:flutter/material.dart';
import 'views/login_screen.dart';
import 'views/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: "/login",
      routes: {
        "/login": (_) => const LoginScreen(),
        "/register": (_) => const RegisterScreen(),
        // remove /chat route
      },
    );
  }
}



// import 'package:chat_app_flutter/views/chats/chat_screen.dart';
// import 'package:chat_app_flutter/views/login_screen.dart';
// import 'package:chat_app_flutter/views/register_screen.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chat App',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       initialRoute: "/login",
//       routes: {
//         "/login": (_) => const LoginScreen(),
//         "/register": (_) => const RegisterScreen(),
//         "/chat": (_) => const ChatScreen(
//               myUserId: "123", // replace dynamically
//               friendUserId: "456",
//             ),
//       },
//     );
//   }
// }



// // import 'package:chat_app_flutter/views/chats/chat_screen.dart';
// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: "Chat App",
// //       theme: ThemeData(primarySwatch: Colors.blue),
// //       home: const ChatScreen(
// //         myUserId: "1", // replace with logged-in user id
// //         friendUserId: "2", // replace with friend's user id
// //       ),
// //     );
// //   }
// // }
