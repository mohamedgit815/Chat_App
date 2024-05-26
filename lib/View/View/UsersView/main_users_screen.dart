import 'package:chat_app/View/Main/responsive_builder.dart';
import 'package:chat_app/View/View/UsersView/mobile_users_page.dart';
import 'package:flutter/material.dart';

class MainUsersScreen extends StatelessWidget {
  const MainUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileUsersPage()
    );
  }
}
