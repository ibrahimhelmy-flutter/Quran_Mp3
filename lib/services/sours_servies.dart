// To parse this JSON data, do
//
//     final surahs = surahsFromJson(jsonString);

import 'dart:convert';

List<Surahs> surahsFromJson(String str) => List<Surahs>.from(json.decode(str).map((x) => Surahs.fromJson(x)));

String surahsToJson(List<Surahs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Surahs {
  Surahs({
    this.number,
    this.name,
    this.transliterationEn,
    this.translationEn,
    this.totalVerses,
    this.revelationType,
  });

  int number;
  String name;
  String transliterationEn;
  String translationEn;
  int totalVerses;
  RevelationType revelationType;

  factory Surahs.fromJson(Map<String, dynamic> json) => Surahs(
    number: json["number"],
    name: json["name"],
    transliterationEn: json["transliteration_en"],
    translationEn: json["translation_en"],
    totalVerses: json["total_verses"],
    revelationType: revelationTypeValues.map[json["revelation_type"]],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
    "transliteration_en": transliterationEn,
    "translation_en": translationEn,
    "total_verses": totalVerses,
    "revelation_type": revelationTypeValues.reverse[revelationType],
  };
}

enum RevelationType { MECCAN, MEDINAN }

final revelationTypeValues = EnumValues({
  "Meccan": RevelationType.MECCAN,
  "Medinan": RevelationType.MEDINAN
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
