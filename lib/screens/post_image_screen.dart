import 'dart:io';

import 'package:flutter/material.dart';

class PostImageScreen extends StatefulWidget {
  static String route = "postImageScreen";

  @override
  State<PostImageScreen> createState() => _PostImageScreenState();
}

class _PostImageScreenState extends State<PostImageScreen>
    with SingleTickerProviderStateMixin {
  final _transformationController = TransformationController();
  late TapDownDetails _doubleTapDetails;

  late AnimationController _animationController;
  late Animation<Matrix4> _animation;

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    Matrix4 _endMatrix;
    Offset _position = _doubleTapDetails.localPosition;

    if (_transformationController.value != Matrix4.identity()) {
      _endMatrix = Matrix4.identity();
    } else {
      _endMatrix = Matrix4.identity()
        ..translate(-_position.dx * 2, -_position.dy * 2)
        ..scale(3.0);
    }

    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: _endMatrix,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(_animationController),
    );
    _animationController.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    )..addListener(() {
        _transformationController.value = _animation.value;
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postImageData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // print(postImageData);
    final postImage = postImageData["postImage"]!;
    final token = postImageData["token"]!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          print(details.delta.dy);
          if (details.delta.dy > 12) {
            Navigator.pop(context);
          }
        },
        child: Container(
          height: double.infinity,
          color: Colors.transparent,
          child: Center(
            child: Hero(
              tag: postImage,
              child: GestureDetector(
                onDoubleTapDown: _handleDoubleTapDown,
                onDoubleTap: _handleDoubleTap,
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  clipBehavior: Clip.none,
                  minScale: 0.5,
                  maxScale: 10,
                  // child: postImage,
                  child: Image.network(
                    postImage,
                    cacheHeight: 1000,
                    headers: {HttpHeaders.authorizationHeader: token},
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
