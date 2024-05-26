import 'package:chat_app/Helper/const_functions.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/View/Main/condtional_builder.dart';
import 'package:chat_app/ViewModel/Functions/auth_functions.dart';
import 'package:chat_app/ViewModel/Functions/chat_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DefaultAddPerson extends StatelessWidget {
  final UserModel data;
  final Color? color;
  final ValueKey? valueKey;

  const DefaultAddPerson({
    super.key ,
    required this.data ,
    this.valueKey,
    this.color
  });


  @override
  Widget build(BuildContext context) {
    final checkUserBlock = StreamProvider((ref)=>BlockFunctions.checkUserBlock(data.id));
    final checkRequests = StreamProvider((ref)=>RequestsFunction.checkRequests(data.id));
    final checkMyRequests = StreamProvider((ref)=>RequestsFunction.checkMyRequests(data.id));

    return LayoutBuilder(
      key: valueKey,
      builder:(context, constraints) => SizedBox(
        key: valueKey,
          width: constraints.maxWidth * 0.15,
          child: Consumer(
            key: valueKey,
            builder: (context,provMyData,_){
              return provMyData.watch(_fetchMyData).when(
                  error: (err,stack)=>ConstGeneral.errorProvider(err),
                  loading: ()=>ConstGeneral.loadingVisibilityProvider() ,
                  data: (value){
                    final UserModel myData = UserModel.fromApp(value.data()!);

                    return Consumer(
                      key: valueKey,
                      builder: (context,provCheckBlock,_) {
                        return provCheckBlock.watch(checkUserBlock).when(
                            error: (err,stack)=>ConstGeneral.errorProvider(err) ,
                            loading: ()=>ConstGeneral.loadingVisibilityProvider() ,
                          data: (checkBlocks)=> AnimatedConditionalBuilder(
                            key: valueKey,
                              condition: checkBlocks.exists,
                              builder: (context){
                                return IconButton(
                                    key: valueKey,
                                    onPressed: () async {
                                  return await BlockFunctions.removeFromBlock(data.id);
                                }, icon: const Icon(Icons.person_add_disabled));
                              },
                              fallback: (context){
                                return Consumer(
                                  key: valueKey,
                                    builder:(context , provCheck , _) {
                                      return provCheck.watch(checkMyRequests).when(
                                          error: (err,stack)=>ConstGeneral.errorProvider(err),
                                          loading: ()=>ConstGeneral.loadingVisibilityProvider(),
                                          data: (checkMyRequests)=> AnimatedConditionalBuilder(
                                            key: valueKey,
                                            condition: checkMyRequests.exists ,
                                            builder: (context){
                                              return IconButton(
                                                key: valueKey,
                                                  onPressed: () async {
                                                    await RequestsFunction.acceptRequests(
                                                        id: data.id,
                                                        model: data ,
                                                        myModel: myData
                                                    );
                                                    await RequestsFunction.refusedRequests(data.id);
                                                    await RequestsFunction.removeRequests(data.id);
                                                  }, icon: Icon(Icons.person_add,color: color ?? ConstColor.lightMainColor,));
                                            },
                                            fallback: (BuildContext context){
                                              return Consumer(
                                                key: valueKey,
                                                  builder:(context,provCheck,_)=>
                                                      provCheck.watch(checkRequests).when(
                                                        error: (err,stack)=> ConstGeneral.errorProvider(err),
                                                        loading: ()=> ConstGeneral.loadingVisibilityProvider(),
                                                        data: (checkRequests)=> AnimatedConditionalBuilder(
                                                            key: valueKey,
                                                            duration: const Duration(milliseconds: 500),
                                                            switchOutCurve: Curves.easeInOutCubic,
                                                            switchInCurve: Curves.easeInOutCubic,
                                                            condition: !checkRequests.exists ,
                                                            builder:(context)=> IconButton(
                                                              key: valueKey,
                                                                onPressed: () async {

                                                                  return await RequestsFunction.sendRequest(id: data.id,model: myData);

                                                                }, icon: Icon(Icons.send,color: color ?? ConstColor.lightMainColor,)) ,
                                                            fallback:(context)=> IconButton(
                                                              key: valueKey,
                                                                onPressed: () async {
                                                                  return await RequestsFunction.removeRequests(data.id);
                                                                }, icon: Icon(Icons.delete_outline,color: color ?? ConstColor.lightMainColor,))
                                                        ),
                                                      )

                                              );
                                            },
                                          )
                                      );
                                    }
                                );
                              }
                          )
                        );
                      }
                    );
                  }
              );
            },
          )
      ),
    );
  }
}

final _fetchMyData = StreamProvider((ref)=>AuthFunctions.getUserData());
