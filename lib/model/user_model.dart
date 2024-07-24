import 'package:counter/services/firestore_service.dart';

class UserModel {
  String uid;
  String displayName;
  String email;
  String phoneNumber;
  var photoURL;
  List<UserModel> friends = [];

  UserModel(
      this.uid, this.displayName, this.email, this.phoneNumber, this.photoURL) {
    coming();
  }

  factory UserModel.fromMap(Map data) => UserModel(
        data['uid'] ?? "0000",
        data['displayName'] ?? "No Name",
        data['email'] ?? "No Email",
        data['phoneNumber'] ?? "No Phone Number",
        data['photoURL'] ??
            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      );

  Future<void> coming() async {
    if (uid == FireStoreService.instance.currentUser.uid) {
      friends = await FireStoreService.instance.getFriends();
    }
  }

  Map<String, dynamic> get toMap => {
        'uid': uid,
        'displayName': displayName ?? "No Name",
        'email': email ?? "No Email",
        'phoneNumber': phoneNumber ?? "No Phone Number",
        'photoURL': photoURL ??
            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      };
}
