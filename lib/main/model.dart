// Main Database Model

class Rev {
  int id;
  String t;

  Rev({required this.id, required this.t});

  factory Rev.fromJson(Map<String, dynamic> json) =>
      Rev(id: json['id'], t: json['t']);
}
