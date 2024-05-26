import 'dart:async';
import 'package:chat_app/Helper/const_functions.dart';
import 'package:chat_app/Helper/const_general.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChatSate extends ChangeNotifier {
  List data = [];

  removeData(){
    notifyListeners();
    data.clear();
  }

  StreamSubscription<QuerySnapshot<Map<String,dynamic>>> fetchFriends(){
    notifyListeners();
    return ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreFriends).snapshots().listen((event) {
          notifyListeners();
          return data.addAll(event.docs.map((e) => UserModel.fromApp(e.data())).toList());
    });
  }


  // StreamSubscription<QuerySnapshot<Map<String,dynamic>>> fetchRequests(){
  //   notifyListeners();
  //   return ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
  //       .collection(fireStoreRequests).snapshots().listen((event) {
  //         notifyListeners();
  //         for(int i = 0; i < event.docs.length ; i++) {
  //           data.addAll(event.docs.map((e) => UserModel.fromApp(e.data())).toList());
  //         }
  //       });
  // }


}