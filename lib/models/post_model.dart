class PostModel {
  final img;
  final likes;
  final comments;

  PostModel({this.img, this.likes = 0, this.comments = 0});

  Map toJson() => {
        "img": img,
        "likes": likes,
        "comments": comments,
      };
}
