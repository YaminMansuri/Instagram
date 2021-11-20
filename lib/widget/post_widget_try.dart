import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:instagram/providers/post_provider.dart';
import 'package:instagram/widget/post_footer.dart';
import 'package:instagram/widget/post_header.dart';
import 'package:instagram/widget/post_image.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatefulWidget {
  final _postImage;
  final _likes;
  final _comments;
  final _userId;
  final _token;
  final _index;
  final _image;

  PostWidget(
    this._postImage,
    this._likes,
    this._comments,
    this._userId,
    this._token,
    this._index,
    this._image,
  );

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  String name = "";
  bool isInit = true;

  @override
  void didChangeDependencies() {
    // print("Loading ${widget._isLoading}");
    // if (isInit) {
    //   Provider.of<PostProvider>(context)
    //       .getUserById(widget._userId)
    //       .then((value) {
    //     Map<String, dynamic> data = json.decode(value.body);
    //     name = data["name"];
    //   });
    // }
    if (isInit) {
      getUserName();
    }
    // print("name $name");
    isInit = false;

    super.didChangeDependencies();
  }

  getUserName() async {
    dynamic response =
        await Provider.of<PostProvider>(context).getUserById(widget._userId);
    Map<String, dynamic> data = json.decode(response.body);
    name = data["name"];
  }

  // @override
  // void initState() {
  //   // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
  //   //   getUserName();
  //   //   print(name);
  //   //   print(timeStamp);
  //   // });
  //   Future.delayed(Duration(seconds: 0)).then((value) => getUserName());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // if (!widget._isLoading)
        Card(
          elevation: 8,
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              PostHeader(name: name, userId: widget._index),
              PostImage(
                image: widget._image,
                postImage: widget._postImage,
                token: widget._token,
              ),
              PostFooter(
                likes: widget._likes,
                comments: widget._comments,
              ),
            ],
          ),
        ),
        SizedBox(),
      ],
    );
  }
}
