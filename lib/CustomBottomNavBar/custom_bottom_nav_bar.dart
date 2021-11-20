import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:instagram/CustomBottomNavBar/custom_animated_bottom_bar_try.dart';
// import 'package:instagram/CustomBottomNavBar/custom_animated_bottom_bar.dart';

import '../screens/activity_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';

class BottomNavBar extends StatefulWidget {
  // static String route = "/bottomNavBar";
  static ScrollController controller = ScrollController();

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    ActivityScreen(),
    ProfileScreen(),
  ];

  PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // static dynamic controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
      //   elevation: 2,
      //   title: Text(
      //     "Instagram",
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 24,
      //     ),
      //   ),
      // ),

      // body: _screens[_currentIndex],

      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
      ),

      // body: IndexedStack(
      //   index: _currentIndex,
      //   children: [..._screens],
      // ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 60,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      curve: Curves.easeInOut,
      onItemSelected: (index) {
        print("Value of INDEX = $index, $_currentIndex");

        if (index == 0 && _currentIndex == 0) {
          BottomNavBar.controller.animateTo(
            -100,
            duration: Duration(milliseconds: 500),
            // curve: Curves.easeInCubic,
            curve: Curves.easeInOutCubic,
          );
        }

        _pageController.jumpToPage(index);
        setState(() => _currentIndex = index);
      },
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.home_outlined),
          // title: Text('Home'),
          title: "Home",
          activeColor: Colors.blueAccent[700],
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.search),
          // title: Text('Search'),
          title: "Search",
          activeColor: Colors.redAccent[400],
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.favorite_outline),
          // title: Text('Favorite'),
          title: "Favorite",
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.person_outline),
          // title: Text('Profile'),
          title: "Profile",
          activeColor: Colors.tealAccent[700],
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
