import 'package:chatapp/View/Authentications/Login/mobile_login_page.dart';
import 'package:chatapp/View/Main/responsive_builder.dart';
import 'package:chatapp/View/View/UsersView/mobile_users_page.dart';
import 'package:flutter/material.dart';

class MainUsersScreen extends StatelessWidget {
  const MainUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileUsersPage()
    );
  }
}
