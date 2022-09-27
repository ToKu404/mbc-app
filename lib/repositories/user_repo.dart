import 'dart:convert';

import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  Future<UserModel> userLogin(String email, String password, String token);
  Future<User> userGetById(String id);
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserModel> userLogin(
      String email, String password, String token) async {
    var _response = await http.post(
      Uri.parse(Api.instance.loginURL),
      body: {
        "email": email,
        "password": password,
        "token": token,
      },
    );

    print("UserRepositoryImpl $email");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("Data $data");
      UserModel model = UserModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<User> userGetById(String id) async {
    var _response = await http.get(Uri.parse(Api.instance.userURL + "/" + id));
    print("UserRepository, userGetById ${_response.statusCode}");
    if (_response.statusCode == 201) {
      var data = json.decode(_response.body);
      print("userGetById $data");
      User model = User.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
