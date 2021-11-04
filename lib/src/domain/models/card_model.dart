import 'dart:convert';

class CardModel {
  int id;
  String title;
  String cardImage;
  bool isTrailer;
  CardModel({
    required this.id,
    required this.title,
    required this.cardImage,
    required this.isTrailer,
  });

  CardModel copyWith({
    int? id,
    String? title,
    String? cardImage,
    bool? isTrailer,
  }) {
    return CardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      cardImage: cardImage ?? this.cardImage,
      isTrailer: isTrailer ?? this.isTrailer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'cardImage': cardImage,
      'isTrailer': isTrailer,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'],
      title: map['title'],
      cardImage: map['cardImage'],
      isTrailer: map['isTrailer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CardModel.fromJson(String source) => CardModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CardModel(id: $id, title: $title, cardImage: $cardImage, isTrailer: $isTrailer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CardModel &&
      other.id == id &&
      other.title == title &&
      other.cardImage == cardImage &&
      other.isTrailer == isTrailer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      cardImage.hashCode ^
      isTrailer.hashCode;
  }
}
