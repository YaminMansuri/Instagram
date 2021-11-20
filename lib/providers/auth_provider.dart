import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  Future<http.Response> signup(UserModel user) async {
    var signupUrl =
        Uri.parse("https://insta-backend-server.herokuapp.com/api/signup");

    print(json.encode(user));

    final response = await http.post(
      signupUrl,
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: json.encode(user),
    );

    print(response.body);

    return response;
  }
}
