class Event {
  int? id;
  String? picture;
  String? title;
  String? location;
  dynamic qrCode;
  String? dateTime;
  int? workload;
  String? category;
  List<String>? speakers;
  List<String>? enrolled;

  Event({
      this.id,
      this.picture,
      this.title,
      this.location,
      this.qrCode,
      this.dateTime,
      this.workload,
      this.category,
      this.speakers,
      this.enrolled
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    picture = json['picture'];
    title = json['title'];
    location = json['location'];
    qrCode = json['qrCode'];
    dateTime = json['dateTime'];
    workload = json['workload'];
    category = json['category'];
    speakers = json['speakers'].cast<String>();
    enrolled = json['enrolled'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['picture'] = picture;
    data['title'] = title;
    data['location'] = location;
    data['qrCode'] = qrCode;
    data['dateTime'] = dateTime;
    data['workload'] = workload;
    data['category'] = category;
    data['speakers'] = speakers;
    data['enrolled'] = enrolled;
    return data;
  }
}
