class Notes {
  String id;
  String title;
  String description;
  int isImp;

  Notes({this.isImp, this.description, this.title, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isImp': isImp
    };
  }
}
