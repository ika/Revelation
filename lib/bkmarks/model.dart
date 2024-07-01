// Bookmarks Model

class BmModel {
  int? id;
  String title;
  String subtitle;
  int doc; // document
  int page;
  int para; // paragraph id

  BmModel(
      {this.id,
      required this.title,
      required this.subtitle,
      required this.doc,
      required this.page,
      required this.para});

  // used when inserting data to the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'doc': doc,
      'page': page,
      'para': para
    };
  }
}
