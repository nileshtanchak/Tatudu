class Tudu {
  int id;
  String title;
  String desc;

  Tudu({
    this.id = 0,
    this.title = "",
    this.desc = "",
  });

  factory Tudu.fromJson(Map<String, dynamic> json) {
    return Tudu(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
    );
  }

  Map<String, dynamic> toJson(Tudu tudu) {
    return <String, dynamic>{
      if (tudu.id != 0) "id": tudu.id,
      "title": tudu.title,
      "desc": tudu.desc,
    };
  }
}
