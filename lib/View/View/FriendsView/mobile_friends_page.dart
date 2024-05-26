import 'package:chat_app/Helper/const_functions.dart';
import 'package:chat_app/Helper/custom_widgets.dart';
import 'package:chat_app/Helper/default_widgets.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/View/Main/condtional_builder.dart';
import 'package:chat_app/View/Main/route_builder.dart';
import 'package:chat_app/ViewModel/Functions/chat_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileFriendsPage extends StatefulWidget {
  const MobileFriendsPage({super.key});

  @override
  State<MobileFriendsPage> createState() => _MobileFriendsPageState();
}

class _MobileFriendsPageState extends State<MobileFriendsPage> with _MobileFriends{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Expanded(
            child: Consumer(
              builder: (context,prov,_) {
                return prov.watch(ConstState.fetchFriendsProv).when(
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
                                  subtitle: CustomText(text: data_.date.toDate().toString().substring(0,11),key: ValueKey<String>(data_.id),) ,
                                  leading: DefaultCircleAvatar(userModel: data_,key: ValueKey<String>(data_.id),),
                                  onTap: () async {
                                    ConstNavigator.pushNamedRouter(route: RouteGenerators.chat, context: context,arguments: data_);
                                  },
                                  onLongPress: () async {
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

                                        Expanded(
                                          child: DefaultModalBottomSheet(
                                              text: '${context.translate!.translate(MainEnum.textBlock.name)} ${data_.first} ${data_.last}' ,
                                              iconData: Icons.person_add_disabled_outlined ,
                                              onPressed: () async {
                                                showDialog(context: context, builder: (context)=>AlertDialog(
                                                  title: const Text('Are you Sure'),
                                                  actions: [
                                                    CustomElevatedButton(onPressed: (){
                                                      Navigator.maybePop(context);
                                                    }, child: const Text('No')),
                                                    CustomElevatedButton(onPressed: () async {
                                                      await BlockFunctions.addToBlock(model: data_);
                                                      await FriendsFunctions.removeFriends(data_.id);
                                                      if(context.mounted) {
                                                        Navigator.maybePop(context);
                                                      }
                                                    }, child: const Text('Yes')),
                                                  ],
                                                ));
                                              }
                                          ),
                                        ) ,

                                        const Spacer(flex: 3)
                                      ],
                                    ),
                                    );
                                  },
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

mixin _MobileFriends {}