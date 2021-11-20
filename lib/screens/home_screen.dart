import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../providers/post_provider.dart';
// import '../widget/post_list.dart';
import '../widget/post_list_try.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final ImagePicker _picker = ImagePicker();

  late final File? pickedImage;

  Future _chooseImage(context) async {
    print("Choosing a file");
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final File pickedImageFile = File(image!.path);

    pickedImage = pickedImageFile;

    PostModel post = PostModel(img: pickedImage);

    if (pickedImage != null) {
      await Provider.of<PostProvider>(
        context,
        listen: false,
      ).addPost(post, pickedImage?.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        elevation: 2,
        title: Text(
          "Instagram",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(231, 236, 242, 1),
      body: Container(
        child: PostList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addPostHandler(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void addPostHandler(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: double.infinity,
          child: ElevatedButton(
            onPressed: () => _chooseImage(context),
            child: Text("Choose an Image"),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
