import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter/model/messge_model.dart';
import 'package:counter/model/todo_model.dart';
import 'package:counter/model/user_model.dart';
import 'package:counter/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class FireStoreService {
  FireStoreService._() {
    getUser();
  }

  static final FireStoreService instance = FireStoreService._();

  //Initialize Firebase
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //Collection Reference
  String collectionPath = "ToDo";
  String userPath = "allUsers";

  late UserModel currentUser;

  //Add User
  Future<void> addUser({required User user}) async {
    Map<String, dynamic> data = {
      'uid': user.uid,
      'email': user.email ?? "demo@mail",
      'displayName': user.displayName ?? user.email!.split('@')[0],
      'phoneNumber': user.phoneNumber ?? "no number",
      'photoURL': user.photoURL ??
          "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
    };

    await fireStore.collection(userPath).doc(user.uid).set(data);
  }

  //Get User
  Future<void> getUser() async {
    DocumentSnapshot snap = await fireStore
        .collection(userPath)
        .doc(AuthServices.instance.auth.currentUser?.uid)
        .get();

    Logger().i(snap.data());
    currentUser = UserModel.fromMap(snap.data() as Map);

    Logger().i(currentUser.uid);
  }

  //Add Data
  Future<void> addData({required Model model}) async {
    // // Auto ID
    // await fireStore.collection(CollectionPath).add(
    //       model.toMap,
    //     );

    // Manual ID
    await fireStore
        .collection(userPath)
        .doc(currentUser.uid)
        .collection(collectionPath)
        .doc(model.id)
        .set(
          model.toMap,
        );
  }

  //Get Data
  Future<List<Model>> getData() async {
    List<Model> allData = [];

    //Get snapShots
    QuerySnapshot<Map<String, dynamic>> snapShots = await fireStore
        .collection(userPath)
        .doc(currentUser.uid)
        .collection(collectionPath)
        .get();

    //Get Docs
    List<QueryDocumentSnapshot> docs = snapShots.docs;

    //Parse Data
    allData = docs
        .map(
          (e) => Model.fromMap(e.data() as Map),
        )
        .toList();

    return allData;
  }

  //Data Stream
  Stream<QuerySnapshot<Map<String, dynamic>>> getStream() {
    return fireStore
        .collection(userPath)
        .doc(currentUser.uid)
        .collection(collectionPath)
        .snapshots();
  }

  //Data Update
  Future<void> updateData({required Model model}) async {
    await fireStore
        .collection(userPath)
        .doc(currentUser.uid)
        .collection(collectionPath)
        .doc(model.id)
        .update(model.toMap);
  }

  //Get Users
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return fireStore.collection(userPath).snapshots();
  }

  //Add Friends
  Future<void> addFriends({required UserModel userModel}) async {
    await fireStore
        .collection(userPath)
        .doc(currentUser.uid)
        .collection('MyFriends')
        .doc(userModel.uid)
        .set(userModel.toMap)
        .then((value) => Logger().i("Friend Added"))
        .onError((error, stackTrace) => Logger().e("Error : $error"));

    await fireStore
        .collection(userPath)
        .doc(userModel.uid)
        .collection('MyFriends')
        .doc(currentUser.uid)
        .set(currentUser.toMap);
  }

  //Get Friends
  Future<List<UserModel>> getFriends() async {
    List<UserModel> allFriends = [];

    allFriends = (await fireStore
            .collection(userPath)
            .doc(currentUser.uid)
            .collection('MyFriends')
            .get())
        .docs
        .map((e) => UserModel.fromMap(e.data()))
        .toList();

    return allFriends;
  }

  //Get Friends Stream
  Stream<QuerySnapshot<Map<String, dynamic>>> getMyFriendsStream() {
    return fireStore
        .collection(userPath)
        .doc(currentUser.uid)
        .collection('MyFriends')
        .snapshots();
  }

  //Send Message
  Future<void> sendMessage(
      {required UserModel user, required MessageModel msg}) async {
    await fireStore
        .collection(userPath)
        .doc(currentUser.uid)
        .collection('MyFriends')
        .doc(user.uid)
        .collection('Messages')
        .doc(msg.time.millisecondsSinceEpoch.toString())
        .set(msg.toMap);

    Map<String, dynamic> data = msg.toMap;
    data['type'] = 'received';

    await fireStore
        .collection(userPath)
        .doc(user.uid)
        .collection('MyFriends')
        .doc(currentUser.uid)
        .collection('Messages')
        .doc(msg.time.millisecondsSinceEpoch.toString())
        .set(data);
  }

  //Seen Message
  Future<void> seenMessage(
      {required UserModel user, required MessageModel msg}) async {
    await fireStore
        .collection(userPath)
        .doc(currentUser.uid)
        .collection('MyFriends')
        .doc(user.uid)
        .collection('Messages')
        .doc(msg.time.millisecondsSinceEpoch.toString())
        .update({'status': "seen"});

    await fireStore
        .collection(userPath)
        .doc(user.uid)
        .collection('MyFriends')
        .doc(currentUser.uid)
        .collection('Messages')
        .doc(msg.time.millisecondsSinceEpoch.toString())
        .update({'status': "seen"});
  }

  //Get Chats
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(
      {required UserModel user}) {
    return fireStore
        .collection(userPath)
        .doc(currentUser.uid)
        .collection('MyFriends')
        .doc(user.uid)
        .collection('Messages')
        .snapshots();
  }
}
