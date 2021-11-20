import 'package:flutter/material.dart';

class PostFooter extends StatelessWidget {
  final likes;
  final comments;

  const PostFooter({
    Key? key,
    required this.likes,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_outline),
        ),
        Text(likes.toString()),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.chat_bubble_outline),
        ),
        Text(comments.toString()),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.bookmark_outline),
        ),
        Expanded(
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.share_outlined),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
          ),
        ),
      ],
    );
  }
}
