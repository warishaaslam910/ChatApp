import 'package:chat_app_flutter/services/api_services.dart';
import '../models/user_model.dart';

class AuthController {
  final ApiService _apiService = ApiService();

  // REGISTER
  Future<UserModel> register(String name, String email, String password) async {
    final response = await _apiService.register(name, email, password);
    return UserModel.fromJson(response.data['user']);
  }

  // LOGIN
  Future<UserModel> login(String email, String password) async {
    final response = await _apiService.login(email, password);
    return UserModel.fromJson(response.data['user']);
  }

//GET ALL USERS
  // Future<List<UserModel>> getAllUsers() async {
  //   final response = await _apiService.getUsers();
  //   return (response.data as List).map((u) => UserModel.fromJson(u)).toList();
  // }

  // GET ALL USERS
  Future<List<UserModel>> getAllUsers() async {
    final response = await _apiService.getUsers();
    final List usersList =
        response.data['users'] as List; // <-- Access the 'users' key
    return usersList.map((u) => UserModel.fromJson(u)).toList();
  }
}








// import 'package:chat_app_flutter/services/api_services.dart';


// import '../models/user_model.dart';

// class AuthController {
//   final ApiService _apiService = ApiService();

//   Future<UserModel> register(String username, String password) async {
//     final response = await _apiService.register(username, password);
//     return UserModel.fromJson(response.data['user']);
//   }

//   Future<UserModel> login(String username, String password) async {
//     final response = await _apiService.login(username, password);
//     return UserModel.fromJson(response.data['user']);
//   }
// }
