import 'dart:convert';

class MovieBriefModel {
  bool hasViewd;
  bool isNew;
  bool isTrailer = false;
  String date;
  String time;
  String image;
  String title;
  String lang;
  MovieBriefModel({
    this.hasViewd=false,
    this.isNew = false,
    this.isTrailer = true,
    required this.date,
    required this.time,
    required this.image,
    required this.title,
    required this.lang,
  });

  MovieBriefModel copyWith({
    bool? hasViewd,
    bool? isNew,
    bool? isTrailer,
    String? date,
    String? time,
    String? image,
    String? title,
    String? lang,
  }) {
    return MovieBriefModel(
      hasViewd: hasViewd ?? this.hasViewd,
      isNew: isNew ?? this.isNew,
      isTrailer: isTrailer ?? this.isTrailer,
      date: date ?? this.date,
      time: time ?? this.time,
      image: image ?? this.image,
      title: title ?? this.title,
      lang: lang ?? this.lang,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hasViewd': hasViewd,
      'isNew': isNew,
      'isTrailer': isTrailer,
      'date': date,
      'time': time,
      'image': image,
      'title': title,
      'lang': lang,
    };
  }

  factory MovieBriefModel.fromMap(Map<String, dynamic> map) {
    return MovieBriefModel(
      hasViewd: map['hasViewd'] != null ? map['hasViewd'] : null,
      isNew: map['isNew'],
      isTrailer: map['isTrailer'],
      date: map['date'],
      time: map['time'],
      image: map['image'],
      title: map['title'],
      lang: map['lang'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieBriefModel.fromJson(String source) =>
      MovieBriefModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MovieBriefModel(hasViewd: $hasViewd, isNew: $isNew, isTrailer: $isTrailer, date: $date, time: $time, image: $image, title: $title, lang: $lang)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieBriefModel &&
        other.hasViewd == hasViewd &&
        other.isNew == isNew &&
        other.isTrailer == isTrailer &&
        other.date == date &&
        other.time == time &&
        other.image == image &&
        other.title == title &&
        other.lang == lang;
  }

  @override
  int get hashCode {
    return hasViewd.hashCode ^
        isNew.hashCode ^
        isTrailer.hashCode ^
        date.hashCode ^
        time.hashCode ^
        image.hashCode ^
        title.hashCode ^
        lang.hashCode;
  }
}
