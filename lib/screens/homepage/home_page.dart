import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter/model/todo_model.dart';
import 'package:counter/myroutes/routes.dart';
import 'package:counter/services/auth_services.dart';
import 'package:counter/services/firestore_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              AuthServices.instance.signOut().then((value) => {
                    Navigator.pushReplacementNamed(context, MyRoutes.signin),
                  });
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: FireStoreService.instance.getStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snaps) {
            if (snaps.hasData) {
              QuerySnapshot? snap = snaps.data;
              List<QueryDocumentSnapshot> allDocs = snap?.docs ?? [];
              List<Model> allTodos = allDocs
                  .map(
                    (e) => Model.fromMap(e.data() as Map),
                  )
                  .toList();
              return ListView.builder(
                itemCount: allTodos.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Text(allTodos[index].id),
                      title: Text(allTodos[index].title),
                      subtitle: Text(allTodos[index].dTime.toString()),
                      trailing: Checkbox(
                        value: allTodos[index].status,
                        onChanged: (value) {
                          allTodos[index].status = value ?? false;
                          FireStoreService.instance.updateData(
                            model: allTodos[index],
                          );
                        },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FireStoreService.instance.addData(
            model: Model(
              '1002',
              'Task Complete',
              false,
              DateTime.now().millisecondsSinceEpoch,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
