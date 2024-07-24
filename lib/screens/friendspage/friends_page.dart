import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter/model/user_model.dart';
import 'package:counter/services/firestore_service.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mitro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: StreamBuilder(
              stream: FireStoreService.instance.getAllUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<UserModel> allUsers = snapshot.data?.docs
                          .map((e) => UserModel.fromMap(e.data()))
                          .toList() ??
                      [];
                  return ListView.builder(
                    itemCount: allUsers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(allUsers[index].displayName),
                          subtitle: Text(allUsers[index].email),
                          trailing: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.person_add_alt_1_rounded,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              FireStoreService.instance
                                  .addFriends(userModel: allUsers[index]);
                            },
                            style: ElevatedButton.styleFrom(
                              // backgroundColor: Colors.grey.shade800,
                              backgroundColor: Colors.blue.shade400,
                            ),
                            label: const Text('Add',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
