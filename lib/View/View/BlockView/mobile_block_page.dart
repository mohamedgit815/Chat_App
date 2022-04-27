import 'package:chatapp/Helper/Default/default_add_person.dart';
import 'package:chatapp/Helper/const_functions.dart';
import 'package:chatapp/Helper/custom_widgets.dart';
import 'package:chatapp/Helper/default_widgets.dart';
import 'package:chatapp/Model/user_model.dart';
import 'package:chatapp/View/Main/condtional_builder.dart';
import 'package:chatapp/View/Main/route_builder.dart';
import 'package:chatapp/ViewModel/Functions/chat_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileBlockPage extends StatefulWidget {
  const MobileBlockPage({Key? key}) : super(key: key);

  @override
  _MobileBlockPageState createState() => _MobileBlockPageState();
}

class _MobileBlockPageState extends State<MobileBlockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: Column(
        children: [

          Expanded(
            child: Consumer(
                builder: (context,prov,_) {
                  return prov.watch(ConstState.fetchBlockProv).when(
                      error: (err,stack)=>ConstGeneral.errorProvider(err) ,
                      loading: ()=>ConstGeneral.loadingProvider() ,
                      data: (data)=> AnimatedConditionalBuilder(
                          condition: data.docs.isEmpty,
                          builder: (context)=> ConstGeneral.notFoundData('You don\' have any Friends'),
                          fallback: (context){
                            return ListView.builder(
                                itemCount: data.docs.length ,
                                itemBuilder: (context,i) {
                                  final UserModel _data = UserModel.fromApp(data.docs.elementAt(i).data());
                                  return ListTile(
                                    key: ValueKey<String>(_data.id),
                                    title: CustomText(text: '${_data.first} ${_data.last}',key: ValueKey<String>(_data.id),) ,
                                      subtitle: DefaultVisibleText(userModel: _data,key: ValueKey<String>(_data.id)),
                                    leading: DefaultCircleAvatar(userModel: _data,key: ValueKey<String>(_data.id),),
                                    onTap: () async {
                                      return await showModalBottomSheet(context: context, builder: (context)=>Column(
                                        children: [
                                          Card(
                                            color: ConstColor.lightMainColor,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CustomText(
                                                text: '${_data.first} ${_data.last}',fontSize: 20.0,
                                                fontWeight: FontWeight.w500,
                                                color: ConstColor.normalWhite,
                                              ),
                                            ),
                                          ) ,

                                          Expanded(
                                            child: DefaultModalBottomSheet(
                                                text: 'Profile ${_data.first} ${_data.last}' ,
                                                iconData: Icons.person ,
                                                onPressed: () async {
                                                  ConstNavigator.pushNamedRouter(route: RouteGenerators.profile, context: context,arguments: _data);
                                                }
                                            ),
                                          ) ,

                                          const Spacer(flex: 4)
                                        ],
                                      ),
                                      );
                                    },
                                    trailing: DefaultAddPerson(data: _data)
                                   // trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.block))
                                  );
                                }
                            );
                          })
                  );
                }
            ),
          )


        ],
      ),
    );
  }
}
