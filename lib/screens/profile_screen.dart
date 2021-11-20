import 'dart:convert';

import "package:flutter/material.dart";
import 'package:instagram/providers/post_provider.dart';
import "package:provider/provider.dart";
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  static final route = "profile_screen";

  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String name = "";

  late String email = "mansuri_yamin";

  dynamic userId = 0;

  getAndFillUserData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userIdPref = prefs.getString("userId");
    dynamic response = await Provider.of<PostProvider>(context, listen: false)
        .getUserById(userIdPref);
    Map<String, dynamic> data = json.decode(response.body);
    if (mounted)
      setState(() {
        name = data["name"];
        email = data["email"];
      });
    // userId = userIdPref;
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    dynamic data;
    if (!ModalRoute.of(context)!.settings.arguments.toString().endsWith("null"))
      data =
          ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    if (data == null) getAndFillUserData(context);
    if (data != null && data.isNotEmpty && mounted) {
      setState(() {
        name = data["name"];
        userId = data["userId"];
      });
    }
    print(data);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          email,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Hero(
                tag: userId.toString(),
                child: CircleAvatar(
                  radius: 65,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  child: CircleAvatar(
                    radius: 63,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 60,
                      foregroundImage: NetworkImage(
                        "https://icon2.cleanpng.com/20180920/cpy/kisspng-computer-icons-portable-network-graphics-avatar-ic-5ba3c66dae9957.9805960115374598217152.jpg",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Hero(
              tag: userId.toDouble(),
              child: SizedBox(
                width: 140.0,
                height: 30.0,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      // letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280),
              child: Text("Android Developer.\n The Developer of this App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // color: Colors.grey[600],
                    // fontSize: 15,
                    // fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "32",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Posts",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "1,092",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Followers",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "83",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Following",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              child: Container(
                height: MediaQuery.of(context).size.height,
                // color: Colors.blueGrey[50],
                color: Colors.grey[200],
              ),
            )
          ],
        ),
      ),
    );
  }
}
