import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Size screenSize;
  final List<Widget> drawerList;
  const CustomDrawer({
    super.key,
    required this.screenSize,
    this.drawerList = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: screenSize.height * 0.025),
        child: Column(
          children: drawerList,
        ),
      ),
    );
  }
}
