class MessageModel {
  String msg, status, type;
  DateTime time;

  MessageModel(this.msg, this.status, this.type, this.time);

  factory MessageModel.fromMap(Map data) => MessageModel(
        data['msg'],
        data['status'],
        data['type'],
        DateTime.fromMillisecondsSinceEpoch(int.parse(data['time'])),
      );

  Map<String, dynamic> get toMap => {
        'msg': msg,
        'status': status,
        'type': type,
        'time': time.millisecondsSinceEpoch.toString(),
      };
}
