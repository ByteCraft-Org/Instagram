// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utils/colors.dart';
import 'package:ionicons/ionicons.dart';

class AppLandingPage extends StatefulWidget {
  const AppLandingPage({super.key});

  @override
  State<AppLandingPage> createState() => _AppLandingPageState();
}

class _AppLandingPageState extends State<AppLandingPage> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        children: [
          Center(child: Text("Home")),
          Center(child: Text("Search")),
          Center(child: Text("Add Post")),
          Center(child: Text("Reels")),
          Center(child: Text("Profile")),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: backgroundColor,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.add_circle,
              color: _page == 2 ? primaryColor : secondaryColor,
            )
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/ic_reel.svg",
              colorFilter: ColorFilter.mode(
              _page == 3 ? primaryColor : secondaryColor, BlendMode.srcIn
              )
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box,
              color: _page == 4 ? primaryColor : secondaryColor,
            )
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}