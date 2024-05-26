
import 'package:chat_app/Helper/Default/default_add_person.dart';
import 'package:chat_app/Helper/const_functions.dart';
import 'package:chat_app/Helper/custom_widgets.dart';
import 'package:chat_app/Helper/default_widgets.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/View/Main/route_builder.dart';
import 'package:chat_app/ViewModel/Functions/chat_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileUsersPage extends StatefulWidget {
  const MobileUsersPage({super.key});

  @override
  State<MobileUsersPage>  createState() => _MobileUsersPageState();
}

class _MobileUsersPageState extends State<MobileUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Consumer(
                builder:(BuildContext context,WidgetRef prov,Widget? _)=> prov.watch(ConstState.fetchUsersProv).when(
                  error: (err,stack)=>ConstGeneral.errorProvider(err),
                  loading: ()=>ConstGeneral.loadingProvider(),
                  data: (value)=> RefreshIndicator(
                    onRefresh: () async {
                      return await prov.refresh(ConstState.fetchUsersProv);
                    },
                    child: ListView.builder(
                      //separatorBuilder: (context,i)=> const Divider(thickness: 1),
                      itemCount: value.docs.length ,
                      itemBuilder: (context,i) {
                        final UserModel data = UserModel.fromApp(value.docs.elementAt(i).data());
                        final checkFriendsProv = StreamProvider((ref)=>FriendsFunctions.checkFriends(value.docs.elementAt(i).id));
                        final checkBlockProv = StreamProvider((ref)=>BlockFunctions.checkUserBlockOrNo(value.docs.elementAt(i).id));

                        return Consumer(
                            key: ValueKey<String>(data.id),
                          builder: (context,provCheckFriends,_) {
                            return provCheckFriends.watch(checkFriendsProv).when(
                                error: (err,stack)=>ConstGeneral.errorProvider(err) ,
                                loading: ()=>ConstGeneral.loadingVisibilityProvider() ,
                              data: (checkFriends)=>Consumer(
                                  key: ValueKey<String>(data.id),
                                  builder: (context,provCheckBlock,_) {
                                    return provCheckBlock.watch(checkBlockProv).when(
                                        error: (err,stack)=>ConstGeneral.errorProvider(err),
                                        loading: ()=>ConstGeneral.loadingVisibilityProvider(),
                                        data: (checkBlock)=>Visibility(
                                          key: ValueKey<String>(data.id),
                                          visible: data.id == ConstState.firebaseId || checkFriends.exists ||checkBlock.exists  ? false : true,
                                          child: ListTile(
                                            key: ValueKey<String>(data.id),
                                            title: CustomText(text: '${data.first} ${data.last}',key: ValueKey<String>(data.id)),
                                            subtitle: DefaultVisibleText(userModel: data,key: ValueKey<String>(data.id)),
                                            leading: DefaultCircleAvatar(userModel: data,key: ValueKey<String>(data.id)),
                                            trailing: DefaultAddPerson(data: data,key: ValueKey<String>(data.id)),
                                            onTap: (){
                                              ConstNavigator.pushNamedRouter(route: RouteGenerators.profile, context: context,arguments: data);
                                            },
                                          ),
                                        )
                                    );
                                  }
                              )
                            );
                          }
                        );
                      },
                    ),
                  ),
                )
              ))
        ],
      ),
    );
  }
}
