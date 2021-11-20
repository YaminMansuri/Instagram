import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post_model.dart';

class PostProvider with ChangeNotifier {
  Future<http.Response> getUserById(var userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    var postUrl = Uri.parse(
      "https://insta-backend-server.herokuapp.com/api/users/user/$userId",
    );

    final response = await http.get(postUrl, headers: {
      HttpHeaders.authorizationHeader: token!,
    });

    notifyListeners();
    return response;
  }

  Future<dynamic> getPosts(page) async {
    print("Provider $page");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    var postUrl = Uri.parse(
      "https://insta-backend-server.herokuapp.com/api/posts?page=$page",
    );

    final response = await http.get(postUrl, headers: {
      HttpHeaders.authorizationHeader: token!,
    });
    // print(json.decode(response.body));

    notifyListeners();
    // return json.decode(response.body);
    return response;
  }
  // Future<http.Response> getPosts(page) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString("token");

  //   var postUrl = Uri.parse(
  //     "https://insta-backend-server.herokuapp.com/api/posts?page=$page",
  //   );

  //   final response = await http.get(postUrl, headers: {
  //     HttpHeaders.authorizationHeader: token!,
  //   });
  //   print(json.decode(response.body));

  //   notifyListeners();
  //   return response;
  // }

  Future<dynamic> addPost(PostModel post, var filepath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString("token");
    var userId = await prefs.getString("userId");
    var addPostUrl = Uri.parse(
      "https://insta-backend-server.herokuapp.com/api/posts/add",
    );

    var request = http.MultipartRequest("POST", addPostUrl);
    request.files.add(
      await http.MultipartFile.fromPath(
        "img",
        filepath,
      ),
    );

    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": token.toString(),
    });

    Map<String, String> data = {"userId": userId!};
    request.fields.addAll(data);

    var response = await request.send();

    notifyListeners();
    return response;
  }
}
