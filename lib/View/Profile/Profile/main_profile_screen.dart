
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/View/Main/responsive_builder.dart';
import 'package:chat_app/View/Profile/Profile/mobile_profile_page.dart';
import 'package:flutter/material.dart';

class MainProfileScreen extends StatelessWidget {
  final UserModel userModel;
  const MainProfileScreen({super.key,required this.userModel});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilderScreen(
        mobile:MobileProfilePage(userModel: userModel)
    );
  }
}
