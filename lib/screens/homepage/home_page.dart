import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter/model/todo_model.dart';
import 'package:counter/model/user_model.dart';
import 'package:counter/myroutes/routes.dart';
import 'package:counter/services/auth_services.dart';
import 'package:counter/services/firestore_service.dart';
import 'package:counter/utils/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   FireStoreService.instance.getUser();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: true,
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.black54,
                backgroundImage: NetworkImage(
                  FireStoreService.instance.currentUser.photoURL,
                ),
                // child: Icon(Icons.person),
                // child: ,
              ),
              decoration: const BoxDecoration(
                // color: Theme.of(context).colorScheme.inversePrimary,
                color: Colors.blue,
              ),
              accountName:
                  Text(FireStoreService.instance.currentUser.displayName),
              accountEmail: Text(FireStoreService.instance.currentUser.email),
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('My Friends'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.friends);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text(
                      'Are you sure?',
                      style: TextStyle(fontSize: 18),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          AuthServices.instance.signOut().then((value) => {
                                Navigator.pushReplacementNamed(
                                    context, MyRoutes.signin),
                              });
                        },
                        child: const Text('Yes',
                            style: TextStyle(color: Colors.blue)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'No',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
//Todo Child
//         child: StreamBuilder(
//           stream: FireStoreService.instance.getStream(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snaps) {
//             if (snaps.hasData) {
//               QuerySnapshot? snap = snaps.data;
//               List<QueryDocumentSnapshot> allDocs = snap?.docs ?? [];
//               List<Model> allTodos = allDocs
//                   .map(
//                     (e) => Model.fromMap(e.data() as Map),
//                   )
//                   .toList();
//               return ListView.builder(
//                 itemCount: allTodos.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: ListTile(
//                       leading: Text(allTodos[index].id),
//                       title: Text(allTodos[index].title),
//                       subtitle: Text(allTodos[index].dTime.toString()),
//                       trailing: Checkbox(
//                         value: allTodos[index].status,
//                         onChanged: (value) {
//                           allTodos[index].status = value ?? false;
//                           FireStoreService.instance.updateData(
//                             model: allTodos[index],
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ),
        child: StreamBuilder(
          stream: FireStoreService.instance.getMyFriendsStream(),
          builder: (context, snaps) {
            if (snaps.hasData) {
              List<UserModel> myFriends = snaps.data?.docs
                      .map((e) => UserModel.fromMap(e.data()))
                      .toList() ??
                  [];
              return myFriends.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No Anyone Friends !!'),
                          20.0.height,
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, MyRoutes.friends);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            icon: const Icon(
                              Icons.person_add_alt_1_rounded,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Add Friends',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: myFriends.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              MyRoutes.chat,
                              arguments: myFriends[index],
                            );
                          },
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(myFriends[index].photoURL),
                              ),
                              title: Text(myFriends[index].displayName),
                              subtitle: Text(myFriends[index].email),
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
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 56,
          // padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            // color: Colors.blue.shade100,
            color: Colors.blue.shade400,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.home, color: Colors.black, size: 32)),
              IconButton(
                  onPressed: () {},
                  icon:
                      const Icon(Icons.search, color: Colors.black, size: 32)),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.friends);
                },
                icon: const Icon(Icons.group, size: 32, color: Colors.black),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.profile_circled,
                      color: Colors.black, size: 32)),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     FireStoreService.instance.addData(
      //       model: Model(
      //         '1003',
      //         'Task Complete',
      //         false,
      //         DateTime.now().millisecondsSinceEpoch,
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
