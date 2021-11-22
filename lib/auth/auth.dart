import 'dart:convert';

import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CustomBottomNavBar/custom_bottom_nav_bar.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';

class Auth extends StatefulWidget {
  static String route = "/auth";

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _formKey = GlobalKey<FormState>();

  UserModel _userModel = UserModel();

  bool _showProgress = false;

  void _submitForm() async {
    _formKey.currentState!.save();

    setState(() {
      _showProgress = true;
    });

    var response = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).signup(_userModel);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> userData = json.decode(response.body);
      print("User Data: $userData");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", userData["token"]);
      await prefs.setString("userId", userData["userId"]);

      Navigator.popAndPushNamed(
        context,
        BottomNavBar.route,
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext ctx) => AlertDialog(
          title: const Text("An error occurred"),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("User already exist"),
              ],
            ),
          ),
        ),
      );
    }

    setState(() {
      _showProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: "User Name"),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please provide a value.";
                          } else if (value.length < 3) {
                            return "Name should be atleast of 3 letters";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userModel = UserModel(
                            name: value,
                            email: _userModel.email,
                            password: _userModel.password,
                          );
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Email"),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          _userModel = UserModel(
                            name: _userModel.name,
                            email: value,
                            password: _userModel.password,
                          );
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Password"),
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        onSaved: (value) {
                          _userModel = UserModel(
                            name: _userModel.name,
                            email: _userModel.email,
                            password: value,
                          );
                        },
                        onFieldSubmitted: (_) => _submitForm(),
                      ),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text("Register"),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                child: Center(
                  child: _showProgress ? CircularProgressIndicator() : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
