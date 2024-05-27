import 'package:chat_app/Helper/const_functions.dart';
import 'package:chat_app/View/Authentications/Login/main_login_screen.dart';
import 'package:chat_app/View/Main/localizations.dart';
import 'package:chat_app/View/Main/route_builder.dart';
import 'package:chat_app/View/Main/tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutterfire_ui/i10n.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'Chat App' ,

      restorationScopeId: 'root' ,

      debugShowCheckedModeBanner: false ,

      themeMode: ThemeMode.light ,


      theme: ThemeData(
            primaryColor: const Color(0xff075E55) ,
            useMaterial3: false,
            colorScheme: const ColorScheme.light().copyWith(
            primary: ConstColor.lightMainColor ,
            secondary: Colors.white ,

            brightness: Brightness.light
          ),
          iconTheme: const IconThemeData(
            color: ConstColor.normalWhite
          ) ,

          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xff075E55)
          )
        ) ,


      //home: TestOne(),

      home: Consumer(
          builder: (context, prov, child) => prov.watch(_checkAuth).when(
              error: (err,stack)=>ConstGeneral.errorProvider(err),
              loading: ()=>ConstGeneral.loadingVisibilityProvider() ,
            data: (data)=> data == null ? const MainLoginScreen() : const TabBarScreen()
          ),
         // child: const MainLoginScreen()
      ),


      onGenerateRoute: RouteGenerators.onGenerate ,

      //locale: TextTranslate.switchLang(ref.watch(langProv).lang),

      locale: const Locale('en'),


      supportedLocales: const [
        Locale("en","") ,
        Locale("ar","") ,
        Locale('es','')
      ] ,

      localizationsDelegates: const [
        AppLocalization.delegate ,
        GlobalWidgetsLocalizations.delegate ,
        GlobalMaterialLocalizations.delegate ,
        GlobalCupertinoLocalizations.delegate
      ],
      localeResolutionCallback: ( currentLocal , supportedLocal ) {
        if( currentLocal != null ) {
          for( Locale loopLocal in supportedLocal ) {
            if( currentLocal.languageCode == loopLocal.languageCode ){
              return currentLocal;
            }
          }
        }
        return supportedLocal.first ;
      },
    );
  }
}

final _checkAuth = StreamProvider((ref)=>ConstState.firebaseAuth.authStateChanges());