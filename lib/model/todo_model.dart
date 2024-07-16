class Model {
  String id, title;
  bool status;
  int dTime;

  Model(this.id, this.title, this.status, this.dTime);

  factory Model.fromMap(Map data) => Model(
        data['id'] ?? "0000",
        data['title'] ?? "No Title",
        data['status'] ?? false,
        data['d_time'] ?? 10101010,
      );

  Map<String, dynamic> get toMap => {
        'id': id,
        'title': title,
        'status': status,
        'd_time': dTime,
      };
}
