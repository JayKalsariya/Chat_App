import 'package:counter/model/messge_model.dart';
import 'package:counter/model/user_model.dart';
import 'package:counter/services/firestore_service.dart';
import 'package:counter/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController msg = TextEditingController();
    UserModel userModel =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(userModel.displayName),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FireStoreService.instance.getChats(user: userModel),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MessageModel> messages = snapshot.data?.docs
                              .map(
                                (e) => MessageModel.fromMap(
                                  e.data(),
                                ),
                              )
                              .toList() ??
                          [];

                      return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          MessageModel message = messages[index];

                          if (message.type == 'received') {
                            FireStoreService.instance
                                .seenMessage(user: userModel, msg: message);
                          }

                          return Row(
                            mainAxisAlignment: message.type == "sent"
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.sizeOf(context).width * 0.7,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  margin: const EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade900,
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
//Message
                                      Text(
                                        message.msg,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
//Time
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${message.time.toString().split(" ")[1].split(":")[0]}:${message.time.toString().split(" ")[1].split(":")[1]}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                          5.0.width,
                                          Icon(
                                            message.type == "sent"
                                                ? Icons.done_all_rounded
                                                : null,
                                            color: message.status == "seen"
                                                ? Colors.blue.shade400
                                                : Colors.white,
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
              TextFormField(
                cursorColor: Colors.grey,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.center,
                maxLines: 6,
                minLines: 1,
                controller: msg,
                onFieldSubmitted: (val) {
                  FireStoreService.instance
                      .sendMessage(
                        user: userModel,
                        msg: MessageModel(
                          msg.text,
                          "unseen",
                          "sent",
                          DateTime.now(),
                        ),
                      )
                      .then((value) => msg.clear());
                },
                decoration: InputDecoration(
                  hintText: "Enter Message",
                  suffixIcon: IconButton(
                    onPressed: () {
                      FireStoreService.instance
                          .sendMessage(
                            user: userModel,
                            msg: MessageModel(
                              msg.text,
                              "unseen",
                              "sent",
                              DateTime.now(),
                            ),
                          )
                          .then((value) => msg.clear());
                    },
                    icon: const Icon(Icons.send, color: Colors.blue),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
