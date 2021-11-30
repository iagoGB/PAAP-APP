class Auth {
  int? id;
  String? token;
  String? role;
  String? username;

  Auth({this.id, this.token, this.role, this.username});

  Auth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    role = json['role'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['token'] = token;
    data['role'] = role;
    data['username'] = username;
    return data;
  }
}
