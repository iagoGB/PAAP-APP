class User {
  int? id;
  String? email;
  String? cpf;
  String? name;
  int? workload;
  String? siape;
  String? departament;
  String? telephone;
  DateTime? entryDate;
  String? avatar;
  List<EventUser>? events;

  User({
    this.id,
    this.email,
    this.cpf,
    this.name,
    this.workload,
    this.siape,
    this.departament,
    this.telephone,
    this.entryDate,
    this.avatar,
    this.events,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    cpf = json['cpf'];
    name = json['name'];
    workload = json['workload'];
    siape = json['siape'];
    departament = json['departament'];
    telephone = json['telephone'];
    entryDate = DateTime.tryParse(json['entryDate']);
    avatar = json['avatar'];
    if (json['events'] != null) {
      events = <EventUser>[];
      json['events'].forEach((v) {
        events?.add(EventUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['cpf'] = cpf;
    data['name'] = name;
    data['workload'] = workload;
    data['siape'] = siape;
    data['departament'] = departament;
    data['telephone'] = telephone;
    data['entryDate'] = entryDate;
    data['avatar'] = avatar;
    if (events != null) {
      data['events'] = events?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventUser {
  int? id;
  String? title;
  bool? isPresent;

  EventUser({this.id, this.title, this.isPresent});

  EventUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isPresent = json['isPresent'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['isPresent'] = isPresent;
    return data;
  }
}
