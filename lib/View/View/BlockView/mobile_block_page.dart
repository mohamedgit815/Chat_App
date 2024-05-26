import 'package:chat_app/Helper/Default/default_add_person.dart';
import 'package:chat_app/Helper/const_functions.dart';
import 'package:chat_app/Helper/custom_widgets.dart';
import 'package:chat_app/Helper/default_widgets.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/View/Main/condtional_builder.dart';
import 'package:chat_app/View/Main/route_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileBlockPage extends StatefulWidget {
  const MobileBlockPage({super.key});

  @override
  State<MobileBlockPage> createState() => _MobileBlockPageState();
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
                                  final UserModel data_ = UserModel.fromApp(data.docs.elementAt(i).data());
                                  return ListTile(
                                    key: ValueKey<String>(data_.id),
                                    title: CustomText(text: '${data_.first} ${data_.last}',key: ValueKey<String>(data_.id),) ,
                                      subtitle: DefaultVisibleText(userModel: data_,key: ValueKey<String>(data_.id)),
                                    leading: DefaultCircleAvatar(userModel: data_,key: ValueKey<String>(data_.id),),
                                    onTap: () async {
                                      return await showModalBottomSheet(context: context, builder: (context)=>Column(
                                        children: [
                                          Card(
                                            color: ConstColor.lightMainColor,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CustomText(
                                                text: '${data_.first} ${data_.last}',fontSize: 20.0,
                                                fontWeight: FontWeight.w500,
                                                color: ConstColor.normalWhite,
                                              ),
                                            ),
                                          ) ,

                                          Expanded(
                                            child: DefaultModalBottomSheet(
                                                text: 'Profile ${data_.first} ${data_.last}' ,
                                                iconData: Icons.person ,
                                                onPressed: () async {
                                                  ConstNavigator.pushNamedRouter(route: RouteGenerators.profile, context: context,arguments: data_);
                                                }
                                            ),
                                          ) ,

                                          const Spacer(flex: 4)
                                        ],
                                      ),
                                      );
                                    },
                                    trailing: DefaultAddPerson(data: data_)
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
