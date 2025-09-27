import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://192.168.1.9:5000/api",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {"Content-Type": "application/json"},
  ));

  // REGISTER
  Future<Response> register(String name, String email, String password) async {
    try {
      final response = await _dio.post("/auth/register", data: {
        "name": name,
        "email": email,
        "password": password,
      });
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  // LOGIN
  Future<Response> login(String email, String password) async {
    try {
      final response = await _dio.post("/auth/login", data: {
        "email": email,
        "password": password,
      });
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

//GET USERS
  Future<Response> getUsers() async {
    try {
      final response = await _dio.get("/auth/all");
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  // GET MESSAGES between 2 users
  Future<Response> getMessages(String user1, String user2) async {
    try {
      final response = await _dio.get("/messages/$user1/$user2");
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  // SEND MESSAGE (optional if you also want REST besides socket)
  Future<Response> sendMessage(
      String senderId, String receiverId, String message) async {
    try {
      final response = await _dio.post("/messages", data: {
        "senderId": senderId,
        "receiverId": receiverId,
        "message": message,
      });
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }
}




// import 'package:dio/dio.dart';

// class ApiService {
//   final Dio _dio = Dio(BaseOptions(
//     baseUrl: "http://your_server_ip:5000/api",
//     connectTimeout: const Duration(seconds: 10),
//     receiveTimeout: const Duration(seconds: 10),
//     headers: {"Content-Type": "application/json"},
//   ));

//   // REGISTER
//   Future<Response> register(String username, String password) async {
//     try {
//       final response = await _dio.post("/auth/register", data: {
//         "username": username,
//         "password": password,
//       });
//       return response;
//     } on DioException catch (e) {
//       throw Exception(e.response?.data ?? e.message);
//     }
//   }

//   // LOGIN
//   Future<Response> login(String username, String password) async {
//     try {
//       final response = await _dio.post("/auth/login", data: {
//         "username": username,
//         "password": password,
//       });
//       return response;
//     } on DioException catch (e) {
//       throw Exception(e.response?.data ?? e.message);
//     }
//   }

//   // GET MESSAGES between 2 users
//   Future<Response> getMessages(String user1, String user2) async {
//     try {
//       final response = await _dio.get("/messages/$user1/$user2");
//       return response;
//     } on DioException catch (e) {
//       throw Exception(e.response?.data ?? e.message);
//     }
//   }

//   // SEND MESSAGE (optional if you also want REST besides socket)
//   Future<Response> sendMessage(
//       String senderId, String receiverId, String message) async {
//     try {
//       final response = await _dio.post("/messages", data: {
//         "senderId": senderId,
//         "receiverId": receiverId,
//         "message": message,
//       });
//       return response;
//     } on DioException catch (e) {
//       throw Exception(e.response?.data ?? e.message);
//     }
//   }
// }
