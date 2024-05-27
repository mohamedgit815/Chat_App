import 'package:chat_app/View/Authentications/ForgetAccount/main_reset_screen.dart';
import 'package:chat_app/View/Main/condtional_builder.dart';
import 'package:chat_app/View/Main/route_builder.dart';
import 'package:chat_app/View/Main/tabbar_screen.dart';
import 'package:chat_app/ViewModel/Functions/auth_functions.dart';
import 'package:chat_app/ViewModel/State/switch_state.dart';

import '../../../Helper/const_functions.dart';
import '../../../Helper/custom_widgets.dart';
import '../../../Helper/default_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileLoginPage extends ConsumerStatefulWidget {
  const MobileLoginPage({super.key});

  @override
  ConsumerState<MobileLoginPage> createState() => _MobileLoginPage();
}

class _MobileLoginPage extends ConsumerState<MobileLoginPage> with _MobileLoginClass{

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _pwController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool keyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    final Size mediaQ = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Container(
            height: double.infinity ,
            width: double.infinity ,
            color: Colors.grey.withOpacity(0.35),
            // decoration: const BoxDecoration(
            //     gradient: LinearGradient(
            //         colors: [
            //           Color(0xff9D84BB),
            //           Color(0xff9A81B7),
            //         ]
            //     )
            // ) ,
            child: LayoutBuilder(
              builder:(BuildContext nonContext , BoxConstraints constraints) => Form(
                key: _globalKey,
                child: ListView(
                    children: [

                      SizedBox(
                        height: keyBoard ? constraints.maxHeight : mediaQ.height * 0.7,
                        width: double.infinity ,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center ,
                          children: [
                            const CustomText(
                              text: 'Chat App',
                              fontSize: 24.0,
                              color: ConstColor.normalWhite,
                            ) ,

                            const SizedBox(height: 30.0) ,

                            DefaultExpandedAuth(
                              child: DefaultTextFormField(
                                  controller: _emailController,
                                  fillColor: ConstColor.normalWhite ,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0) ,
                                      borderSide: BorderSide.none
                                  ),
                                  hintStyle: const TextStyle(
                                      fontSize: 19.0,
                                      color: ConstColor.normalGrey
                                  ),
                                  style: const TextStyle(
                                      fontSize: 19.0,
                                      color: ConstColor.normalBlack
                                  ),
                                  hint: 'Enter your Email',
                                  validator: (v){
                                    return ConstValidator.validatorEmail(v);
                                  },
                                  inputType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next
                              ),
                            ) ,

                            const SizedBox(height: 20.0) ,

                            DefaultExpandedAuth(
                              child: Consumer(
                                  builder: (BuildContext buildContext,WidgetRef prov,_) {
                                    return DefaultTextFormField(
                                      controller: _pwController,
                                      fillColor: ConstColor.normalWhite ,
                                      password: prov.watch(_visiblePwProv).varSwitch,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20.0) ,
                                          borderSide: BorderSide.none
                                      ),
                                      hintStyle: const TextStyle(
                                          fontSize: 19.0,
                                          color: ConstColor.normalGrey
                                      ),
                                      style: const TextStyle(
                                          fontSize: 19.0,
                                          color: ConstColor.normalBlack
                                      ),
                                      hint: 'Enter your Password',
                                      validator: (v){
                                        return v!.isEmpty ? 'Enter your Password by Right Form' : null;
                                      },
                                      suffixIcon: AnimatedConditionalBuilder(
                                        condition: prov.read(_visiblePwProv).varSwitch,
                                        builder: (BuildContext buildContext){
                                          return DefaultIconButtonVisibility(
                                              ref: prov,
                                              color: ConstColor.normalBlack,
                                              icon: Icons.visibility,
                                              state: _visiblePwProv
                                          );
                                        },
                                        fallback: (BuildContext buildContext){
                                          return DefaultIconButtonVisibility(
                                              ref: prov,
                                              color: ConstColor.normalBlack,
                                              icon: Icons.visibility_off,
                                              state: _visiblePwProv
                                          );
                                        },
                                      ),
                                      inputType: TextInputType.visiblePassword,
                                      inputAction: TextInputAction.done,
                                      onSubmitted: (String v) async {
                                        await AuthFunctions.loginAuth(
                                            email: _emailController.text,
                                            password: _pwController.text,
                                            globalKey: _globalKey,
                                            route: TabBarScreen.tabBar,
                                            context: context,
                                            state: ref,
                                            indicatorState: _indicatorProv
                                        );
                                      },
                                    );
                                  }
                              ),
                            ) ,

                            const SizedBox(height: 20.0) ,

                            DefaultExpandedAuth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: (){
                                        ConstNavigator.pushNamedRouter(route: MainResetScreen.reset, context: context);
                                      },
                                      child: const CustomText(
                                        text: 'Forget your Password?' ,
                                        color: ConstColor.normalWhite,
                                      )),


                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0
                                    ),
                                    child: Consumer(
                                      builder:(buildContext,prov,_)=> AnimatedConditionalBuilder(
                                        condition: prov.watch(_indicatorProv).varSwitch,
                                        builder: (buildContext) {
                                          return CustomTextButton(
                                            size: const Size(double.infinity,50.0),
                                            backGroundColor: ConstColor.lightMainColor,
                                            //backGroundColor: const Color(0xffCA9EFF),
                                            borderRadius: BorderRadius.circular(20.0),
                                            onPressed: () async {
                                              await AuthFunctions.loginAuth(
                                                  email: _emailController.text ,
                                                  password: _pwController.text ,
                                                  globalKey: _globalKey ,
                                                  route: RouteGenerators.main ,
                                                  context: context ,
                                                  state: prov ,
                                                  indicatorState: _indicatorProv
                                              );

                                            },
                                            child: const CustomText(
                                              text: 'Login',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24.0,
                                              color: ConstColor.normalWhite ,
                                            ),
                                          );
                                        },
                                        fallback: (context) {
                                          return ConstGeneral.loadingProvider();
                                        },
                                      ),
                                    ),
                                  ),


                                  GestureDetector(
                                      onTap: (){
                                        ConstNavigator.pushNamedRouter(route: RouteGenerators.register , context: context);
                                      },
                                      child: const CustomText(
                                        text: 'Don\'t have an Account?SignUp' ,
                                        color: ConstColor.normalWhite,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      )

                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


mixin _MobileLoginClass {
  final _indicatorProv= ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final _visiblePwProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
}