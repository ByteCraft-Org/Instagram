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
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        children: const [
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
              _page == 0 ? Icons.home_rounded : Icons.home_outlined,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: _page == 1 ? 32 : null,
              color: _page == 1 ? primaryColor : secondaryColor,
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _page == 2 ? Ionicons.add_circle : Ionicons.add_circle_outline,
              color: _page == 2 ? primaryColor : secondaryColor,
            )
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 3 ? "assets/images/ic_reel.svg" : "assets/images/ic_reel_outlined.svg",
              colorFilter: ColorFilter.mode(
              _page == 3 ? primaryColor : secondaryColor, BlendMode.srcIn
              )
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _page == 4 ? Icons.person : Icons.person_outline_outlined,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
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