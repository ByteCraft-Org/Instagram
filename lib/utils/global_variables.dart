import 'package:flutter/material.dart';

double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

const List<Widget> navigationBarItems = [
  Center(child: Text("Home")),
  Center(child: Text("Search")),
  Center(child: Text("Add Post")),
  Center(child: Text("Reels")),
  Center(child: Text("Profile")),
];