import 'dart:math';
import 'package:chat_app/Helper/const_functions.dart';
import 'package:chat_app/Helper/const_general.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/State/switch_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ChatFunctions {
  /// Chats
  static Future<QuerySnapshot<Map<String,dynamic>>> fetchUserChat() async {
    return await ConstState.fireStore.collection(fireStoreUser)
        .orderBy('date',descending: true).get();
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchStreamUserChat() {
    return ConstState.fireStore.collection(fireStoreUser).
        orderBy('date',descending: true).snapshots();
  }



  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchChat({
    required String id , required String name
  }) {
    return ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreFriends).doc(id)
        .collection(name).orderBy('date',descending: true).snapshots();
  }


  static Future<void> updateDateChat() async {
    return await ConstState.fireStore.collection(fireStoreUser).doc(ConstState.firebaseId).update({
      'date': DateTime.now()
    });
  }

  static Future<void> sendMessageChat({
    required String id , required String text ,required String name ,
    required String myName , required WidgetRef state , required String subText ,
    required ChangeNotifierProvider<SwitchState>indicatorState ,required String subUser
}) async {
    state.read(indicatorState).falseSwitch();
    final int number = Random().nextInt(999999999);
    final int number1 = Random().nextInt(999999999);
    final int number2 = Random().nextInt(999999999);
    final String dateNumber = DateTime.now().toString().substring(21,26);

    final String random = '$number$dateNumber$number1$number2';

    await ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreFriends).doc(id).collection(name)
        .doc(random).set({
      'date': Timestamp.now() ,
      'text': text ,
      'id': ConstState.firebaseId ,
      'subText': subText ,
      'subUser' : subUser ,
      'token' : '${await FirebaseMessaging.instance.getToken()}'
    });

    await ConstState.fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreFriends).doc(ConstState.firebaseId)
        .collection(myName).doc(random).set({
      'date': Timestamp.now() ,
      'text': text ,
      'id': ConstState.firebaseId ,
      'subText': subText ,
      'subUser' : subUser,
      'token' : '${await FirebaseMessaging.instance.getToken()}'
    });

    state.read(indicatorState).trueSwitch();
  }



  static Future<void> deleteMessageChat({
    required String id , required String deleteId ,
    required String name , required String myName
  }) async {


    await ConstState.fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreFriends).doc(ConstState.firebaseId)
        .collection(myName).doc(deleteId).delete();


    await ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreFriends).doc(id)
        .collection(name).doc(deleteId).delete();
  }


}


class FriendsFunctions {
  /// Friends

  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchFriends(){
    return ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreFriends).snapshots();
  }

  static Stream<DocumentSnapshot<Map<String,dynamic>>> checkFriends(String id){
    return ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreFriends).doc(id).snapshots();
  }

  static Future<void> removeFriends(String id) async {
    /// Delete To My Collection
    await ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreFriends).doc(id).delete();

    /// Delete To His Collection
    await ConstState.fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreFriends).doc(ConstState.firebaseId).delete();
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> knowNumFriends(String id){
    return ConstState.fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreFriends).snapshots();
  }

}


class RequestsFunction {
  static Future<void> sendRequest({
    required String id , required UserModel model ,
  }) async {
    return await ConstState.fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreRequests).doc(model.id).set(model.toApp());
  }


  static Stream<DocumentSnapshot<Map<String,dynamic>>> checkRequests(String id) {
    return ConstState.fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreRequests).doc(ConstState.firebaseId).snapshots();
  }

  static Stream<DocumentSnapshot<Map<String,dynamic>>> checkMyRequests(String id) {
    return ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreRequests).doc(id).snapshots();
  }

  static Future<void> removeRequests(String id) async {
    return await ConstState.fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreRequests).doc(ConstState.firebaseId).delete();
  }


  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchRequests() {
    return ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreRequests).snapshots();
  }

  static Future<void> refusedRequests(String id) async {
    return await ConstState.fireStore.collection(fireStoreProfile)
        .doc(ConstState.firebaseId).collection(fireStoreRequests).doc(id).delete();
  }

  static Future<void> acceptRequests({
    required String id ,
    required UserModel model ,
    required UserModel myModel
  }) async {
    /// Send To My Collection
    await ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreFriends).doc(id).set(model.toApp());

    /// Send To His Collection
    await ConstState.fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreFriends).doc(ConstState.firebaseId).set(myModel.toApp());
  }
}


class BlockFunctions {
  static Future<void> addToBlock({
    required UserModel model ,
  }) async {
    return await ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreBlocks).doc(model.id).set(model.toApp());
  }

  static Stream<DocumentSnapshot<Map<String,dynamic>>> checkUserBlock(String id) {
    return ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreBlocks).doc(id).snapshots();
  }

  static Stream<DocumentSnapshot<Map<String,dynamic>>> checkUserBlockOrNo(String id) {
    return ConstState.fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreBlocks).doc(ConstState.firebaseId).snapshots();
  }

  static Future<void> removeFromBlock(String id) async {
    return await ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreBlocks).doc(id).delete();
  }


  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchBlock() {
    return ConstState.fireStore.collection(fireStoreProfile).doc(ConstState.firebaseId)
        .collection(fireStoreBlocks).orderBy('date', descending: true).snapshots();
  }
}