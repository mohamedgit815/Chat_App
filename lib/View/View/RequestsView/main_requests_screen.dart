import 'package:chat_app/View/Main/responsive_builder.dart';
import 'package:chat_app/View/View/RequestsView/mobile_requests_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainRequestsScreen extends ConsumerStatefulWidget {
  const MainRequestsScreen({super.key});

  @override
  ConsumerState<MainRequestsScreen> createState() => _MainRequestsScreenState();
}

class _MainRequestsScreenState extends ConsumerState<MainRequestsScreen> {

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileRequestsPage()
    );
  }
}
