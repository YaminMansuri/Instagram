import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:instagram/screens/post_image_screen.dart';

class PostImage extends StatelessWidget {
  final image;
  final postImage;
  final token;

  const PostImage({
    Key? key,
    required this.image,
    required this.postImage,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final image = Image.network(
    //   postImage,
    //   width: MediaQuery.of(context).size.width - 10,
    //   alignment: Alignment.topCenter,
    //   cacheHeight: 1000,
    //   fit: BoxFit.cover,
    //   headers: {HttpHeaders.authorizationHeader: token!},
    // );
    // precacheImage(image.image, context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      // padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              PostImageScreen.route,
              arguments: {
                "postImage": postImage,
                "token": token,
              },
            );
          },
          child: Container(
            constraints: BoxConstraints(
              minHeight: 0,
              maxHeight: 420,
            ),
            child: Hero(
              tag: postImage,

              // * perfect
              // child: Image.network(
              //   postImage,
              //   width: MediaQuery.of(context).size.width - 10,
              //   alignment: Alignment.topCenter,
              //   cacheHeight: 1200,
              //   fit: BoxFit.cover,
              //   headers: {HttpHeaders.authorizationHeader: token},
              // ),
              // child: image,
              child: image,
            ),
          ),
        ),
      ),
    );
  }
}
