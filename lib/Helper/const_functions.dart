import 'dart:async';
import 'dart:convert';
import 'package:chat_app/Helper/const_general.dart';
import 'package:chat_app/View/Main/localizations.dart';
import 'package:chat_app/View/Main/tabbar_screen.dart';
import 'package:chat_app/ViewModel/Functions/auth_functions.dart';
import 'package:chat_app/ViewModel/Functions/chat_functions.dart';
import 'package:chat_app/ViewModel/Functions/home_functions.dart';
import 'package:chat_app/ViewModel/State/lang_state.dart';
import 'package:chat_app/ViewModel/State/theme_state.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:flashy_flushbar/flashy_flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// Main Enum Applications
enum MainEnum{
  /// The Main Languages in The Application
  english , arabic , espanol ,

  /// Text Languages
  textProfile , textHome , textAccount , textLogOut , textChange , textUpdate ,
  textSetting , textSure , textYes , textNo , textChooseLang , textChat , textPost ,
  textWrite , textDelete , textPeople , textAccept , textRefused , textRequests ,
  textFriends , textMessage , textBlock , textName , textBio , textEmail , textBioHere,
  textYou ,

}

/// Extension For BuildContext
extension MainContext on BuildContext {
  AppLocalization? get translate => AppLocalization.of(this);
  ThemeData get theme => Theme.of(this);
  ModalRoute<Object?>? get modal => ModalRoute.of(this);
  bool get keyBoard => MediaQuery.of(this).viewInsets.bottom == 0;
  Size get mainSize => MediaQuery.of(this).size;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}


class ConstGeneral {

  static Locale switchLang(String lang){
    SharedPreferences.getInstance().then((value) async {
      await value.setString('lang', lang);
    });
    if(lang == 'english'){
      lang = 'en';
    } else if(lang == 'arabic'){
      lang = 'ar';
    } else if(lang == 'espanol') {
      lang = 'es';
    }
    return Locale(lang,'');
  }

  static Center errorProvider(Object err){
    return Center(child: FittedBox(
        fit: BoxFit.scaleDown,
        child: CustomText(text: err.toString())),);
  }

  static Center loadingProvider(){
    return const Center(child: CircularProgressIndicator.adaptive(),);
  }

  static Visibility loadingVisibilityProvider(){
    return const Visibility(
        visible: false,
        child: CircularProgressIndicator.adaptive());
  }

  static Center notFoundData(String text){
    return Center(child: FittedBox(
      fit: BoxFit.scaleDown,
      child: CustomText(
        text: text ,
        fontSize: 20.0,
        color: ConstColor.lightMainColor,
      ),
    ),);
  }

  static MaterialStateProperty<Color> materialStateColor(Color color){
    return MaterialStateProperty.all<Color>(color);
  }
}


class ConstState {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseStorage fireStorage = FirebaseStorage.instance;
  static final String firebaseId = FirebaseAuth.instance.currentUser!.uid;
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;


  static final themeProv = ChangeNotifierProvider((ref)=>ThemeState());
  static final langProv = ChangeNotifierProvider((ref)=>LangState());
  static final myDataProv = StreamProvider((ref)=>AuthFunctions.getUserData());
  static final fetchHomeProv = FutureProvider((ref)=>HomeFunctions.fetchHomeData());
  static final fetchUsersProv = FutureProvider((ref)=>AuthFunctions.fetchAllUsers());
  static final fetchFriendsProv = StreamProvider((ref)=>FriendsFunctions.fetchFriends());
  static final fetchRequestsProv = StreamProvider((ref)=>RequestsFunction.fetchRequests());
  static final fetchBlockProv = StreamProvider((ref)=>BlockFunctions.fetchBlock());
  //static final fetchFriendsProv = ChangeNotifierProvider<ChatSate>((ref)=>ChatSate());
 // static final fetchRequestsProv = ChangeNotifierProvider<ChatSate>((ref)=>ChatSate());



  static StreamSubscription<RemoteMessage> onMessage(BuildContext context) {
    return FirebaseMessaging.onMessage.listen((event) {
      FlashyFlushbar
        (
        leadingWidget: const Icon(
          Icons.error_outline,
          color: Colors.black,
          size: 24,
        ),
        message: "event.data.",
        duration: const Duration(seconds: 1),
        trailingWidget: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () {
            FlashyFlushbar.cancel();
          },
        ),
        isDismissible: false,
      ).show(
      );


      // Flushbar(
      //   flushbarPosition: FlushbarPosition.TOP,
      //   shouldIconPulse: false,
      //   margin: const EdgeInsets.all(10.0),
      //   duration: const Duration(seconds: 100),
      //   title: event.notification!.title,
      //   messageText: CustomText(
      //     text: event.notification!.body.toString(),
      //     color: Colors.white,
      //   ),
      //   borderRadius: BorderRadius.circular(10.0),
      //   // margin: const EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
      //   mainButton: MaterialButton(onPressed: (){},child: const Text('Google'),),
      //   backgroundColor: Colors.black.withOpacity(0.5),
      //   isDismissible: true,
      //   dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      //   icon: const CircleAvatar(child: Icon(Icons.person)),
      //   onTap: (_){
      //   },
      // ).show(context);
    });
  }

  static StreamSubscription<RemoteMessage> onMessageOpenedApp(BuildContext context) {
    return FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Fluttertoast.showToast(msg: 'Message');
      Navigator.of(context).pushNamedAndRemoveUntil(TabBarScreen.tabBar, (route) => false);
    });
  }


 static Future<http.Response> sendMessage({
    required String id , required String title ,
    required String body , required String userToken}) async {
    const String token = 'AAAAcJ5noSQ:APA91bEfPtobjmIeMY2t64SMtyfl9zhfvJFgeh6T6U1WJ4M-nY-J3JFCIC-hPNIeCY3SZ422b1MOKLYxrLYlNMQjFRxxM0sKq7Wk7bgb4VHpbYd3sgaU-zurQvFyPXuNd1tBfU7gb8S5';
    return await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String,String>{
          'Content-Type':'application/json',
          'Authorization': 'key=$token'
        },
        body: jsonEncode(<String,dynamic>{
          'notification': <String,String>{
            'title': title.toString(),
            'body': body.toString(),
          } ,
          'priority': 'high' ,
          'data' : {
            'click_action' : 'FLUTTER_NOTIFICATION_CLICK',
            'id': id.toString() ,
          },
          'to': userToken
          // 'to': 'fTQQelA0RnWBfzdL76A-sk:APA91bH-6Lp9dHAnzJIjQP_25l9zWW2yQPCiYleMSMeiKUStmUJ39oThC_hkhzNH2V7-eAzzPqNUDl_Hz_26MrgMYtByN9kDvvThh9e3WbffiJ54hotJAAQSMH4nDjscod5B_GDZzyTA'
          // 'to': 'f-__WICVTt-jE-gvJfsx88:APA91bHFysPzK-aBr5Q7DZZjASD6IyyCYGgiCQEKOWpADvOqvtwSvDv-feuVANQNkwNte6_BL-HyJkdJ58RUIl_rFpqgqVcrb5ruFYrmpW7OZk0Red-CBco0iSPSHS2VHlNR_je3b2G5'
        })
    );
  }

}


class ConstNavigator {

  static Future<dynamic> backPageRouter({required BuildContext context, dynamic arguments}) async {
    return await Navigator.of(context).maybePop(arguments);
  }

  static Future<dynamic> pushNamedRouter({required String route ,required BuildContext context,dynamic arguments}) async {
    return await Navigator.of(context).pushNamed(route,arguments: arguments);
  }

  static Future<dynamic> pushNamedAndReplaceRouter({required String route ,required BuildContext context,dynamic arguments}) async {
    return await Navigator.of(context).pushReplacementNamed(route,arguments: arguments);
  }

  static Future<dynamic> pushNamedAndRemoveRouter({required String route ,required BuildContext context,dynamic arguments}) async {
    return await Navigator.of(context).pushNamedAndRemoveUntil(route , (route) => false,arguments: arguments);
  }

}


class ConstValidator {
  static String? validatorName(String? v) {
    return !v!.contains(regExpName) ? 'Enter your Name by write form' : null ;
  }

  static String? validatorEmail(String? v) {
    return !v!.contains(regExpEmail) ? 'Enter your Email by write form' : null ;
  }

  static String? validatorPhone(String? v) {
    return !v!.contains(regExpPhone) ? 'Enter your Phone by write form' : null;
  }

  static String? validatorPw(String? v) {
    return !v!.contains(regExpPw) ? '[UpperCase , LowerCase , \$ ,# ,%]' : null;
  }
}


class ConstColor {

// Dark Theme
  static const Color darkMainColor = Colors.indigo;
  static const Color darkColorOne = Color(0xff424242);
  static const Color darkColorTow = Color(0xff303030);
  static const Color darkColorFour = Color(0xff1a1a1a);



// LightTheme
//const Color lightMainColor = Color(0xFF333333);
  static const Color lightMainColor = Color(0xff075E55);
  static const Color lightColorTow = Color(0xffCC7D00);
  static const Color lightColorThree = Color(0xff7B7B7B);
  static const MaterialColor lightColorFour = Colors.red;


// HelperColors
  static const Color normalWhite = Color(0xffFFFFFF);
  static const Color normalTrans = Colors.transparent;
  static const MaterialColor normalGrey = Colors.grey;
  static const Color normalBlack = Color(0xff333333);
  static const Color helperColorOne = Color(0xffCCCCCC);
}