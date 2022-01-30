class Category {
  int? id;
  String? name;
  String? urlImage;

  Category({this.id, this.name, this.urlImage});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    urlImage = json['urlImage'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['urlImage'] = urlImage;
    return data;
  }
}
