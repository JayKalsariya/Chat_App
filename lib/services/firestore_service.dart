import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/todo_model.dart';

class FireStoreService {
  FireStoreService._();

  static final FireStoreService instance = FireStoreService._();

  //Initialize Firebase
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //Collection Reference
  String collectionPath = 'ToDo';

  //Add Data
  Future<void> addData({required Model model}) async {
    // // Auto ID
    // await fireStore.collection(CollectionPath).add(
    //       model.toMap,
    //     );

    // Manual ID
    await fireStore.collection(collectionPath).doc(model.id).set(
          model.toMap,
        );
  }

  //Get Data
  Future<List<Model>> getData() async {
    List<Model> allData = [];

    //Get snapShots
    QuerySnapshot<Map<String, dynamic>> snapShots =
        await fireStore.collection(collectionPath).get();

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
    return fireStore.collection(collectionPath).snapshots();
  }

  //Data Update
  Future<void> updateData({required Model model}) async {
    await fireStore
        .collection(collectionPath)
        .doc(model.id)
        .update(model.toMap);
  }
}
