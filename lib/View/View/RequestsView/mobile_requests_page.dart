import 'package:chatapp/Helper/const_functions.dart';
import 'package:chatapp/Helper/custom_widgets.dart';
import 'package:chatapp/Helper/default_widgets.dart';
import 'package:chatapp/Model/user_model.dart';
import 'package:chatapp/View/Main/condtional_builder.dart';
import 'package:chatapp/ViewModel/Functions/chat_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileRequestsPage extends ConsumerStatefulWidget {
  const MobileRequestsPage({Key? key}) : super(key: key);

  @override
  _MobileRequestsPageState createState() => _MobileRequestsPageState();
}

class _MobileRequestsPageState extends ConsumerState<MobileRequestsPage> with _MobileRequests{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requests'),
        centerTitle: true,
      ),
      body: Column(
        children:  [
          
          Expanded(
              child: Consumer(
                builder: (context,prov,_) {

                  return prov.watch(ConstState.fetchRequestsProv).when(
                      error: (err,stack)=> ConstGeneral.errorProvider(err),
                      loading: ()=> ConstGeneral.loadingProvider() ,
                    data: (data)=>AnimatedConditionalBuilder(
                        condition: data.docs.isEmpty,
                        builder: (context)=>ConstGeneral.notFoundData('No Requests'),
                        fallback: (context){
                          return ListView.builder(
                              itemCount: data.docs.length,
                              itemBuilder: (context,i) {
                                final UserModel _data = UserModel.fromApp(data.docs.elementAt(i).data());
                                final _knowFriends = StreamProvider((ref)=>FriendsFunctions.knowNumFriends(_data.id));


                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(

                                    children:  [

                                      DefaultCircleAvatar(userModel: _data , radius: 35.0),


                                      Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                child: CustomText(text: '${_data.first} ${_data.last}',fontSize: 18.0,),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Consumer(
                                                    builder: (context,provFriends,_) {
                                                      return provFriends.watch(_knowFriends).when(
                                                          error: (err,stack)=> ConstGeneral.errorProvider(err) ,
                                                          loading: ()=> ConstGeneral.loadingVisibilityProvider() ,
                                                          data: (knowFriend)=>CustomText(text: '${knowFriend.docs.length} From Friends',fontSize: 15.0)
                                                      );
                                                    }
                                                ),
                                              ),

                                              Row(
                                                children: [
                                                  const Spacer(),
                                                  Expanded(
                                                      flex: 15,
                                                      child: CustomElevatedButton(
                                                          onPressed: () async {
                                                            return await _refusedRequests(context, _data.id);
                                                          },
                                                          child: const CustomText(text: 'Refused') ,
                                                          borderRadius: BorderRadius.circular(10.0)
                                                      )),

                                                  const Spacer(),


                                                  Expanded(
                                                      flex: 15,
                                                      child: Consumer(
                                                          builder: (context,provMyData,_) {
                                                            return provMyData.watch(ConstState.myDataProv).when(
                                                                error: (err,stack)=> ConstGeneral.errorProvider(err) ,
                                                                loading: ()=> ConstGeneral.loadingVisibilityProvider() ,
                                                                data: (myData)=>CustomElevatedButton(
                                                                  onPressed: () async {
                                                                    final UserModel _myData = UserModel.fromApp(myData.data()!);
                                                                    return await _acceptRequests(data: _data, myData: _myData);
                                                                  },
                                                                  child: const CustomText(text: 'Accept') ,
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                )
                                                            );
                                                          }
                                                      )),

                                                  const Spacer(),
                                                ],
                                              )
                                            ],
                                          ))

                                    ],
                                  ),
                                );
                              }
                          );
                        })
                  );
                }
              ))

        ],
      ),
    );
  }
}

class _MobileRequests {
  /// Functions
  Future<void> _refusedRequests(BuildContext context ,String id) async {
    return await showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text('${context.translate!.translate(MainEnum.textSure.name)}'),
      actions: [
        CustomElevatedButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: const Text('No')),
      //  }, child: Text('${context.translate!.translate(MainEnum.textNo.name)}')),
        CustomElevatedButton(onPressed: () async {
          await RequestsFunction.refusedRequests(id);
          Navigator.of(context).pop();
        }, child: const Text('Yes')),
       // }, child: Text('${context.translate!.translate(MainEnum.textYes.name)}')),
      ],
    ));
  }

  Future<void> _acceptRequests({required UserModel data , required UserModel myData}) async {
    await RequestsFunction.acceptRequests(
        id: data.id,
        model: data ,
        myModel: myData
    );
    await RequestsFunction.refusedRequests(data.id);
  }
}
