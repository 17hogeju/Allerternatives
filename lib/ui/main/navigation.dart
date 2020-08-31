import 'package:allerternatives/ui/main/home/home_view.dart';
import 'package:allerternatives/ui/main/user_info/userInfo_view.dart';
import 'package:allerternatives/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

class MyNavigation extends StatefulWidget {
  @override
  _MyNavigationState createState() => _MyNavigationState();
}

class _MyNavigationState extends State<MyNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _children = [HomeView(), UserInfoView()];

  void onTappedBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: primaryColor,
        onTap: onTappedBar,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.location_on,
            ),
            activeIcon: new Icon(
              Icons.location_on,
            ),
            title: new Text(
              "Home",
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            activeIcon: new Icon(
              Icons.person,
            ),
            title: new Text(
              "Profile",
            ),
          ),
        ],
      ),
    );
  }
}
