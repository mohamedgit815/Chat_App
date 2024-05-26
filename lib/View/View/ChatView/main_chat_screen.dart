import 'package:chat_app/Helper/const_functions.dart';
import 'package:chat_app/Helper/const_general.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/View/Main/responsive_builder.dart';
import 'package:chat_app/View/View/ChatView/mobile_chat_page.dart';
import 'package:flutter/material.dart';


class MainChatScreen extends StatefulWidget {
  final UserModel userModel;
  const MainChatScreen({super.key,required this.userModel});

  @override
  State<MainChatScreen> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> with WidgetsBindingObserver{

  @override
  void initState() {
    super.initState();
    _update(true);
  }

  @override
  void dispose() {
    super.dispose();
    _update(false);
  }

  @override
  Widget build(BuildContext context) {

    return ResponsiveBuilderScreen(
        mobile: MobileChatPage( data: widget.userModel )
    );
  }

  Future<void> _update(bool page) async {
    return await ConstState.fireStore.collection(fireStoreUser).doc(ConstState.firebaseId).update({
      'page': page
    });
  }
}