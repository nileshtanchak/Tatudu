class SubTudu {
  int id;
  int parentTuduId;
  String title;
  String desc;
  bool isCompleted;

  SubTudu({
    this.id = 0,
    this.parentTuduId = 0,
    this.title = "",
    this.desc = "",
    this.isCompleted = false,
  });

  factory SubTudu.fromJson(Map<String, dynamic> json) {
    return SubTudu(
      id: json['id'] ?? 0,
      parentTuduId: json['parentTuduId'] ?? 0,
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
      isCompleted: (json['isCompleted'] ?? 0) == 1,
    );
  }

  Map<String, dynamic> toJson(SubTudu subTudu) {
    return <String, dynamic>{
      if (subTudu.id != 0) "id": subTudu.id,
      if (subTudu.parentTuduId != 0) "parentTuduId": subTudu.parentTuduId,
      "title": subTudu.title,
      "desc": subTudu.desc,
      "isCompleted": subTudu.isCompleted ? 1 : 0,
    };
  }
}
