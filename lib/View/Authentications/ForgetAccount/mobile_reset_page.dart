import 'package:chat_app/Helper/default_widgets.dart';
import 'package:chat_app/View/Authentications/Login/main_login_screen.dart';
import 'package:chat_app/View/Main/condtional_builder.dart';
import 'package:chat_app/ViewModel/Functions/auth_functions.dart';
import 'package:chat_app/ViewModel/State/switch_state.dart';

import '../../../Helper/const_functions.dart';
import '../../../Helper/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileResetPage extends StatefulWidget {
  const MobileResetPage({super.key});

  @override
  State<MobileResetPage> createState() => _MobileResetPageState();
}

class _MobileResetPageState extends State<MobileResetPage> with _MobileResetClass{

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool keyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    final Size mediaQ = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.35),
            // decoration: const BoxDecoration(
            //     gradient: LinearGradient(
            //         colors: [
            //           Color(0xff9D84BB),
            //           Color(0xff9A81B7),
            //         ]
            //     )
            // ),
            child: LayoutBuilder(
              builder:(BuildContext nonContext , BoxConstraints constraints) => Form(
                key: _globalKey,
                child: ListView(
                    children: [

                      SizedBox(
                        height: keyBoard ? constraints.maxHeight : mediaQ.height * 0.7,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center ,
                          children: [
                            const CustomText(
                              text: 'Reset Email',
                              fontSize: 24.0 ,
                              color: ConstColor.normalWhite ,

                            ) ,

                            const SizedBox(height: 30.0) ,

                            DefaultExpandedAuth(
                              child: DefaultTextFormField(
                                fillColor: ConstColor.normalWhite ,
                                controller: _emailController,
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
                                inputAction: TextInputAction.done ,
                                onSubmitted: (String v){

                                },
                              ),
                            ) ,

                            const SizedBox(height: 20.0) ,

                            DefaultExpandedAuth(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 10.0
                                ),
                                child: Consumer(
                                    builder: (nonContext,prov,_) {
                                      return AnimatedConditionalBuilder(
                                          condition: prov.watch(_indicatorProv).varSwitch,
                                          builder: (BuildContext nonContext){
                                            return CustomTextButton(
                                              size: const Size(double.infinity,50.0),
                                              backGroundColor: ConstColor.lightMainColor,
                                              //backGroundColor: const Color(0xffCA9EFF),
                                              borderRadius: BorderRadius.circular(20.0),
                                              onPressed: () async {

                                                return await AuthFunctions.resetEmailAuth(
                                                    globalKey: _globalKey,
                                                    email: _emailController.text,
                                                    context: context,
                                                    indicatorState: _indicatorProv,
                                                    state: prov,
                                                    route: MainLoginScreen.login
                                                );

                                              },
                                              child: const CustomText(text: 'Reset',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 24.0,
                                                color: ConstColor.normalWhite ,
                                              ),
                                            );
                                          },
                                          fallback: (BuildContext context) {
                                            return const CircularProgressIndicator.adaptive();
                                          }
                                      );
                                    }
                                ),
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

mixin _MobileResetClass {
  final _indicatorProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
}