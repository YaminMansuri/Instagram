import 'dart:convert';
// import 'dart:html';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:http/http.dart" as http;

// @Crossorigin
class NetworkHandler {
  final storage = FlutterSecureStorage();

  // ! Check this
  Future get() async {
    var token = await storage.read(key: "token");

    // var postUrl = Uri.parse("http://192.168.43.45:5000/api/users/post");
    var postUrl =
        Uri.parse("https://insta-backend-server.herokuapp.com/api/users/post");
    final response = await http.get(postUrl, headers: {
      HttpHeaders.authorizationHeader: token!,
    });
    print(json.decode(response.body));
  }

  Future<http.Response> post(Map<String, String> body) async {
    // var signupUrl = Uri.parse("http://192.168.3.1:5000/api/signup");
    // var signupUrl = Uri.parse("http://127.0.0.1:5000/api/signup");
    var signupUrl =
        Uri.parse("https://insta-backend-server.herokuapp.com/api/signup");

    print(json.encode(body));

    final response = await http.post(
      signupUrl,
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: json.encode(body),
    );

    print(response.body);
    // var a = json.decode(response.body);
    // print(a["token"]);
    return response;
  }
}
