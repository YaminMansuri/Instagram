import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import "package:instagram/CustomBottomNavBar/custom_bottom_nav_bar.dart";
import 'package:instagram/providers/post_provider.dart';
import 'package:instagram/widget/post_widget_try.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostList extends StatefulWidget {
  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  String? _token;
  List _posts = [];
  Set _updatedPosts = {};
  List _images = [];
  List _postImage = [];
  int _page = 1;
  bool _isLoading = true;
  int counter = 0;

  fetchMorePost() async {
    final response =
        await Provider.of<PostProvider>(context, listen: false).getPosts(_page);
    Map<dynamic, dynamic> postData = json.decode(response.body);
    print("postDataResponse = $postData");
    if (mounted)
      setState(() {
        _posts.addAll(postData["posts"]);
      });
    fillImageList();
  }

  void fillImageList() {
    _posts.forEach((post) {
      loadImages(post["img"]);
    });

    checkImagesLoaded();
  }

  checkImagesLoaded() {
    ImageStreamListener listener = ImageStreamListener((info, call) {
      if (call == false && mounted)
        setState(() {
          counter++;
        });

      if (counter == _posts.length && mounted)
        setState(() {
          print("Updated Posts are: $_updatedPosts");
          _updatedPosts.addAll(_posts);
          _isLoading = false;
        });
    });

    _images.forEach((image) {
      precacheImage(image.image, context);
      image.image.resolve(new ImageConfiguration()).addListener(listener);
      print(image);
    });
  }

  loadImages(postImage) {
    if (!_postImage.contains(postImage)) {
      _images.add(Image.network(
        "https://insta-backend-server.herokuapp.com/api/posts/post/$postImage",
        width: MediaQuery.of(context).size.width - 10,
        alignment: Alignment.topCenter,
        cacheHeight: 1000,
        fit: BoxFit.cover,
        headers: {HttpHeaders.authorizationHeader: _token!},
      ));
      _postImage.add(postImage);
    }
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
  }

  @override
  void initState() {
    super.initState();
    getToken();
    fetchMorePost();
  }

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
                      900 &&
                  mounted) {
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
              itemCount: _updatedPosts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = _updatedPosts.elementAt(index)["img"];
                final userId = _updatedPosts.elementAt(index)["userId"];
                final likes = _updatedPosts.elementAt(index)["likes"];
                final comments = _updatedPosts.elementAt(index)["comments"];

                final image = _images.elementAt(index);
                print(image);
                print("UpdatedPosts = $_updatedPosts, ${_updatedPosts.length}");

                return Column(
                  children: [
                    PostWidget(
                      "https://insta-backend-server.herokuapp.com/api/posts/post/$item",
                      likes,
                      comments,
                      userId,
                      _token,
                      index,
                      image,
                    ),
                    if (_isLoading && index == _updatedPosts.length - 1)
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
