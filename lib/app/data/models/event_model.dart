import 'package:paap_app/app/data/models/category_model.dart';

class Event {
  int? id;
  String? picture;
  String? title;
  String? location;
  String? description;
  String? qrCode;
  DateTime? dateTime;
  int? workload;
  Category? category;
  List<String>? speakers;
  List<String>? enrolled;

  Event({
    this.id,
    this.picture,
    this.title,
    this.location,
    this.description,
    this.qrCode,
    this.dateTime,
    this.workload,
    this.category,
    this.speakers,
    this.enrolled,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    picture = json['picture'];
    title = json['title'];
    location = json['location'];
    description = json['description'];
    qrCode = json['qrCode'];
    dateTime = DateTime.tryParse(json['dateTime']);
    workload = json['workload'];
    category =
        json['category'] != null ? Category?.fromJson(json['category']) : null;
    speakers = json['speakers'].cast<String>();
    enrolled = json['enrolled'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['picture'] = picture;
    data['title'] = title;
    data['location'] = location;
    data['description'] = description;
    data['qrCode'] = qrCode;
    data['dateTime'] = dateTime;
    data['workload'] = workload;
    if (category != null) {
      data['category'] = category?.toJson();
    }
    data['speakers'] = speakers;
    data['enrolled'] = enrolled;
    return data;
  }
}
