import 'package:chat_app/View/Main/responsive_builder.dart';
import 'package:chat_app/View/Profile/ProfileMe/mobile_profileme_page.dart';
import 'package:flutter/material.dart';


class MainProfileMeScreen extends StatelessWidget {
  static const String profileMe = '/MainProfileMeScreen';
  const MainProfileMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileProfileMePage()
    );
  }
}
