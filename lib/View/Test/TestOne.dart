
import 'package:chat_app/Helper/const_functions.dart';
import 'package:chat_app/View/Main/route_builder.dart';
import 'package:flutter/material.dart';

class TestOne extends StatelessWidget {
  String? _data = '';


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(

        children: [
          MaterialButton(onPressed: () async {
             ConstNavigator.pushNamedRouter(route: RouteGenerators.routeTest, context: context,arguments: [
              'Google',
              'Bing',
            ]);


          },child: Text(_data == null || _data!.isEmpty ? 'Next': _data!),),


          MaterialButton(onPressed: (){
          },child: const Text('test'),)

          // Visibility(
          //     visible: _data == null || _data!.isEmpty ? false : true,
          //     child: Text(_data!))
        ],
      ),
    );
  }
}


class TestTow extends StatelessWidget {
  final String test;

  const TestTow({Key? key, required this.test}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(

        children: [
          MaterialButton(onPressed: (){
            ConstNavigator.backPageRouter(context: context,arguments: 'Yandex');
          },child: Text(test),),



        ],
      ),
    );
  }
}