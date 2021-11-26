import 'dart:convert';

import 'package:flutter/material.dart';
import "package:instagram/CustomBottomNavBar/custom_bottom_nav_bar.dart";
import 'package:instagram/providers/post_provider.dart';
import 'package:instagram/widget/post_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostList extends StatefulWidget {
  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  String? _token;
  List _posts = [];
  int _page = 1;
  bool _isLoading = true;

// image = Image.network(
//       postImage,
//       width: MediaQuery.of(context).size.width - 10,
//       alignment: Alignment.topCenter,
//       cacheHeight: 1000,
//       fit: BoxFit.cover,
//       headers: {HttpHeaders.authorizationHeader: token},
//     );

  // image.image.resolve(new ImageConfiguration()).addListener(ImageStreamListener((info, call) {}));

  fetchMorePost() async {
    final response =
        await Provider.of<PostProvider>(context, listen: false).getPosts(_page);
    Map<dynamic, dynamic> postData = json.decode(response.body);
    setState(() {
      _posts.addAll(postData["posts"]);
      _isLoading = false;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
  }

  void fillImageList() {}

  @override
  void initState() {
    super.initState();
    fetchMorePost();
    fillImageList();
  }

  // !Perfect code do not touch it Okay!?
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!_isLoading &&
                  (scrollInfo.metrics.maxScrollExtent -
                              scrollInfo.metrics.pixels)
                          .round() <=
                      150) {
                setState(() {
                  _page++;
                  _isLoading = true;
                });
                fetchMorePost();
              }
              return true;
            },
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: BottomNavBar.controller,
              itemCount: _posts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = _posts.elementAt(index)["img"];
                final userId = _posts.elementAt(index)["userId"];
                final likes = _posts.elementAt(index)["likes"];
                final comments = _posts.elementAt(index)["comments"];

                return Column(
                  children: [
                    PostWidget(
                      "https://insta-backend-server.herokuapp.com/api/posts/post/$item",
                      likes,
                      comments,
                      userId,
                      _token,
                      index,
                      0
                    ),
                    if (_isLoading && index == _posts.length - 1)
                      Container(
                        margin: EdgeInsets.all(10),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
