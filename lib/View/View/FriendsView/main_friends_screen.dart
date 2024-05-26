import 'package:chat_app/View/Main/responsive_builder.dart';
import 'package:chat_app/View/View/FriendsView/mobile_friends_page.dart';
import 'package:flutter/material.dart';

class MainFriendsScreen extends StatelessWidget {
  const MainFriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return const ResponsiveBuilderScreen(
        mobile: MobileFriendsPage()
    );
  }
}
