import 'package:flutter/material.dart';
import 'package:instagram/screens/profile_screen.dart';

class PostHeader extends StatelessWidget {
  final name;
  final userId;

  const PostHeader({Key? key, required this.name, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 7,
        right: 10,
        left: 10,
        bottom: 7,
      ),
      child: Row(
        children: [
          _buildProfilePic(context),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserName(),
              _buildTime(),
            ],
          ),
          _buildOptionBtn(),
        ],
      ),
    );
  }

  Expanded _buildOptionBtn() {
    return Expanded(
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.more_vert),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Text _buildTime() {
    return Text(
      "15 minuites ago",
      textAlign: TextAlign.start,
    );
  }

  Hero _buildUserName() {
    return Hero(
      tag: userId.toDouble(),
      child: SizedBox(
        width: 100,
        height: 14,
        child: Material(
          color: Colors.transparent,
          child: Text(
            name!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 14,
              decoration: TextDecoration.none,
              // letterSpacing: 1,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }

  InkWell _buildProfilePic(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProfileScreen.route,
          arguments: {"userId": userId, "name": name},
        );
      },
      child: Hero(
        tag: userId.toString(),
        child: CircleAvatar(
          radius: 25,
          foregroundImage: NetworkImage(
              "https://icon2.cleanpng.com/20180920/cpy/kisspng-computer-icons-portable-network-graphics-avatar-ic-5ba3c66dae9957.9805960115374598217152.jpg"),
        ),
      ),
    );
  }
}
