import 'package:chat_app/Helper/const_functions.dart';
import 'package:chat_app/Helper/custom_widgets.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/View/Main/condtional_builder.dart';
import 'package:chat_app/ViewModel/Functions/auth_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class DefaultDrawer extends ConsumerStatefulWidget {
   const DefaultDrawer({super.key});

  @override
  ConsumerState<DefaultDrawer> createState() => _DefaultDrawerState();
}


class _DefaultDrawerState extends ConsumerState<DefaultDrawer>  with _DefaultDrawerClass {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Consumer(
            builder: (context,prov,_) => prov.watch(_myData).when(
                  error: (err,stack)=> ConstGeneral.errorProvider(err),
                  loading: () => ConstGeneral.loadingProvider() ,
                data: (myData) {
                  final UserModel data = UserModel.fromApp(myData.data()!);

                  return UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: data.image.isEmpty ? ConstColor.normalWhite : null,
                      backgroundImage: data.image.isEmpty ? null: NetworkImage(data.image),
                      child: AnimatedConditionalBuilder(
                        condition: data.image.isEmpty,
                        builder: (context)=> CustomText(
                            text: data.first.substring(0,1).toString() ,
                          fontSize: 24.0,
                          color: ConstColor.normalBlack,
                          fontWeight: FontWeight.bold,
                        ),
                        fallback: null,
                      ),
                    ),
                    accountName: Text('${data.first} ${data.last}') ,
                    accountEmail: AnimatedConditionalBuilder(
                      condition: data.bio.isEmpty,
                      builder: (context)=>Text(data.email.toString()),
                      fallback: (context)=>Text(data.bio.toString()),
                    )
                  );
                }
              )
          ),

          Expanded(
            flex: 1,
            child: Card(
              child: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (context)=>SimpleDialog(
                      alignment: Alignment.center,
                      title: Align(
                          alignment: Alignment.center,
                          child: Text('${context.translate!.translate(MainEnum.textChooseLang.name)}')),

                      children: [

                        const Divider(thickness: 1,),

                        _buildLangButton(langName: 'Arabic', ref: ref, lang: MainEnum.arabic.name),
                        _buildLangButton(langName: 'English', ref: ref, lang: MainEnum.english.name),
                        _buildLangButton(langName: 'Español', ref: ref, lang: MainEnum.espanol.name),
                      ],
                    ));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: _langName!,
                      fontSize: 20.0,
                    ),
                  )
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Card(
              child: InkWell(
                  onTap: (){
                   //ConstNavigator.pushNamedRouter(route: MainPostsScreen.posts, context: context);
                  },
                  child:Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: '${context.translate!.translate(MainEnum.textWrite.name)}',
                      fontSize: 20.0,
                    ),
                  )

              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Card(
              child: InkWell(
                  onTap: (){
                   // ConstNavigator.pushNamedRouter(route: MainChangePwScreen.changePw, context: context);
                  },
                  child:Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: '${context.translate!.translate(MainEnum.textChange.name)}',
                      fontSize: 20.0,
                    ),
                  )

              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Consumer(
              builder: (context,prov,_) {

                return prov.watch(_myData).when(
                    error: (err,stack)=>ConstGeneral.errorProvider(err),
                    loading: ()=>ConstGeneral.loadingProvider() ,
                  data: (myData) {
                   // final UserModel _data = UserModel.fromApp(myData.data()!);

                    return Card(
                    child: InkWell(
                        onTap: (){
                        //  Navigator.of(context).pushNamed(MainProfileUpdateScreen.profileUpdate,arguments: _data);
                        },
                        child:Container(
                          margin: const EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            text: '${context.translate!.translate(MainEnum.textUpdate.name)}',
                            fontSize: 20.0,
                          ),
                        )

                    ),
                  );
                  }
                );
              }
            ),
          ),

          Expanded(
            flex: 1,
            child: Card(
              child: InkWell(
                  onTap: () async{
                    return await AuthFunctions.signOut(context);
                  },
                  child:Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: '${context.translate!.translate(MainEnum.textLogOut.name)}',
                      fontSize: 20.0,
                    ),
                  )

              ),
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}


mixin _DefaultDrawerClass {
  final _myData = StreamProvider((ref)=> AuthFunctions.getUserData() );
  late String? _langName = 'English';

  Widget _buildLangButton({
    required String langName ,
    required WidgetRef ref ,
    required String lang
  }) {
    return InkWell(
        onTap: (){
          ref.read(ConstState.langProv).toggleLang(lang);
          _langName = langName;
        },
        child: Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: CustomText(text: langName,
              fontSize: 18.0,
            ))
    );
  }
}