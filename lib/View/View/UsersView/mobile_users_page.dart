import 'package:chatapp/Helper/Default/default_add_person.dart';
import 'package:chatapp/Helper/const_functions.dart';
import 'package:chatapp/Helper/custom_widgets.dart';
import 'package:chatapp/Helper/default_widgets.dart';
import 'package:chatapp/Model/user_model.dart';
import 'package:chatapp/View/Main/route_builder.dart';
import 'package:chatapp/ViewModel/Functions/chat_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileUsersPage extends StatefulWidget {
  const MobileUsersPage({Key? key}) : super(key: key);

  @override
  _MobileUsersPageState createState() => _MobileUsersPageState();
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
                  data: (data)=> RefreshIndicator(
                    onRefresh: () async {
                      return await prov.refresh(ConstState.fetchUsersProv);
                    },
                    child: ListView.builder(
                      //separatorBuilder: (context,i)=> const Divider(thickness: 1),
                      itemCount: data.docs.length ,
                      itemBuilder: (context,i) {
                        final UserModel _data = UserModel.fromApp(data.docs.elementAt(i).data());
                        final _checkFriendsProv = StreamProvider((ref)=>FriendsFunctions.checkFriends(data.docs.elementAt(i).id));
                        final _checkBlockProv = StreamProvider((ref)=>BlockFunctions.checkUserBlockOrNo(data.docs.elementAt(i).id));

                        return Consumer(
                            key: ValueKey<String>(_data.id),
                          builder: (context,provCheckFriends,_) {
                            return provCheckFriends.watch(_checkFriendsProv).when(
                                error: (err,stack)=>ConstGeneral.errorProvider(err) ,
                                loading: ()=>ConstGeneral.loadingVisibilityProvider() ,
                              data: (checkFriends)=>Consumer(
                                  key: ValueKey<String>(_data.id),
                                  builder: (context,provCheckBlock,_) {
                                    return provCheckBlock.watch(_checkBlockProv).when(
                                        error: (err,stack)=>ConstGeneral.errorProvider(err),
                                        loading: ()=>ConstGeneral.loadingVisibilityProvider(),
                                        data: (checkBlock)=>Visibility(
                                          key: ValueKey<String>(_data.id),
                                          visible: _data.id == ConstState.firebaseId || checkFriends.exists ||checkBlock.exists  ? false : true,
                                          child: ListTile(
                                            key: ValueKey<String>(_data.id),
                                            title: CustomText(text: '${_data.first} ${_data.last}',key: ValueKey<String>(_data.id)),
                                            subtitle: DefaultVisibleText(userModel: _data,key: ValueKey<String>(_data.id)),
                                            leading: DefaultCircleAvatar(userModel: _data,key: ValueKey<String>(_data.id)),
                                            trailing: DefaultAddPerson(data: _data,key: ValueKey<String>(_data.id)),
                                            onTap: (){
                                              ConstNavigator.pushNamedRouter(route: RouteGenerators.profile, context: context,arguments: _data);
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
