import 'package:chat_app/View/Main/responsive_builder.dart';
import 'package:chat_app/View/View/BlockView/mobile_block_page.dart';
import 'package:flutter/material.dart';

class MainBlockScreen extends StatelessWidget {
  const MainBlockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileBlockPage()
    );
  }
}
