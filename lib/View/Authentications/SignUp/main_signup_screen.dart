import 'package:chatapp/View/Authentications/SignUp/mobile_signup_page.dart';
import 'package:chatapp/View/Main/responsive_builder.dart';
import 'package:flutter/material.dart';

class MainSignUpScreen extends StatelessWidget {
  const MainSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileSignUpPage()
    );
  }
}
