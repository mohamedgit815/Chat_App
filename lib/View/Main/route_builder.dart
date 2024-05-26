import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/View/Authentications/ForgetAccount/main_reset_screen.dart';
import 'package:chat_app/View/Authentications/Login/main_login_screen.dart';
import 'package:chat_app/View/Authentications/SignUp/main_signup_screen.dart';
import 'package:chat_app/View/Main/tabbar_screen.dart';
import 'package:chat_app/View/Profile/Profile/main_profile_screen.dart';
import 'package:chat_app/View/Profile/ProfileMe/main_profileme_screen.dart';
import 'package:chat_app/View/Test/TestOne.dart';
import 'package:chat_app/View/View/BlockView/main_block_screen.dart';
import 'package:chat_app/View/View/ChatView/main_chat_screen.dart';
import 'package:chat_app/View/View/RequestsView/main_requests_screen.dart';
import 'package:chat_app/View/View/UsersView/main_users_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerators {
  static const String routeTest = '/Test';

  static const String main = '/MainScreen';
  static const String login = '/MainLoginScreen';
  static const String register = '/MainRegisterScreen';
  static const String reset = '/MainResetScreen';
  static const String profileMe = '/MainProfileMeScreen';
  static const String profile = '/MainProfileScreen';
  static const String updatePW = '/MainUpdatePwScreen';
  static const String updateImage = '/MainUpdateImageScreen';
  static const String homeDetails = '/MainHomeDetailsScreen';
  static const String users = '/MainUsersScreen';
  static const String requests = '/MainRequestsScreen';
  static const String block = '/MainBlockScreen';
  static const String chat = '/MainChatScreen';

  static MaterialPageRoute<dynamic> _materialPageRoute(Widget page){
    return MaterialPageRoute(builder: (_)=>page);
  }

  static CupertinoPageRoute<dynamic> _cupertinoPageRoute(Widget page){
    return CupertinoPageRoute(builder: (_)=>page);
  }


  static Route<dynamic>? onGenerate(RouteSettings settings) {
    switch(settings.name) {

      case routeTest :
        final List<String> test = settings.arguments as List<String>;
        final String one = test.elementAt(0);
        final String tow = test.elementAt(1);

        return _cupertinoPageRoute(TestTow(test: one));

        case main : return _materialPageRoute(const TabBarScreen());


        case login : return _materialPageRoute(const MainLoginScreen());


        case register : return _cupertinoPageRoute(const MainSignUpScreen());


        case reset : return _cupertinoPageRoute(const MainResetScreen());


        case profileMe : return _cupertinoPageRoute(const MainProfileMeScreen());


        case users : return _materialPageRoute(const MainUsersScreen());


        case requests : return _cupertinoPageRoute(const MainRequestsScreen());


        case chat :
          final UserModel userModel = settings.arguments as UserModel;
          return _cupertinoPageRoute(MainChatScreen(userModel: userModel));


        case block : return _cupertinoPageRoute(const MainBlockScreen());

        case profile :
          final UserModel data = settings.arguments as UserModel;
          return _cupertinoPageRoute(MainProfileScreen(userModel: data));

    }
    return null;
  }
}