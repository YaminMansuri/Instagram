import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CustomBottomNavBar/custom_bottom_nav_bar.dart';
import '../screens/post_image_screen.dart';
import '../screens/profile_screen.dart';
import 'auth/auth.dart';
import 'providers/auth_provider.dart';
import 'providers/post_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _screen = BottomNavBar();

  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {
      setState(() {
        _screen = Auth();
      });
    } else {
      setState(() {
        _screen = BottomNavBar();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PostProvider(),
        ),
      ],
      child: MaterialApp(
        home: _screen,
        routes: {
          Auth.route: (_) => Auth(),
          BottomNavBar.route: (_) => BottomNavBar(),
          PostImageScreen.route: (_) => PostImageScreen(),
          ProfileScreen.route: (_) => ProfileScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
