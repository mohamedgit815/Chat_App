import 'package:chat_app/View/Main/app.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Future<void> _messageBackGround(RemoteMessage message) async {
//   await Fluttertoast.showToast(msg: 'New Message');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  //FirebaseMessaging.onBackgroundMessage(_messageBackGround);

  //print(await FirebaseMessaging.instance.getToken());

  runApp(const ProviderScope(child: MyApp()));
}