// class UserModel {
//   final String id;
//   final String username;

//   UserModel({required this.id, required this.username});

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'].toString(),
//       username: json['username'],
//     );
//   }
// }

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? token; // optional because token comes separately

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'], // only available at login/register
    );
  }
}
