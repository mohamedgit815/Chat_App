import 'package:chatapp/View/Main/responsive_builder.dart';
import 'package:chatapp/View/View/BlockView/mobile_block_page.dart';
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
