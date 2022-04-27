import 'package:chatapp/Model/user_model.dart';
import 'package:chatapp/View/Main/responsive_builder.dart';
import 'package:chatapp/View/Profile/Profile/mobile_profile_page.dart';
import 'package:flutter/material.dart';

class MainProfileScreen extends StatelessWidget {
  final UserModel userModel;
  const MainProfileScreen({Key? key,required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilderScreen(
        mobile:MobileProfilePage(userModel: userModel)
    );
  }
}
