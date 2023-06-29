import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:bloc_demo/Model/User_Model.dart';
import 'user_list.dart';

// getUsers = fetchPost
// UserRepository
class UserRepository {
  String Url = 'https://retoolapi.dev/aMsZrK/data';
  Future<List<UserModel>> getUsers() async {
    Response response = await http.get(Uri.parse(Url));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);

      return result.map(((e) => UserModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
