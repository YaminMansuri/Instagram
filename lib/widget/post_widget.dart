import 'dart:io';

import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final _postImage;
  final _token;

  PostWidget(this._postImage, this._token);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 400,
                      maxHeight: 500,
                    ),
                    child: Image.network(
                      "$_postImage",
                      width: MediaQuery.of(context).size.width - 10,
                      fit: BoxFit.cover,
                      headers: {HttpHeaders.authorizationHeader: _token},
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.home),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.comment),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
