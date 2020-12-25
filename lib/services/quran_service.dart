// To parse this JSON data, do
//
//     final quran = quranFromJson(jsonString);

import 'dart:convert';

Quran quranFromJson(String str) => Quran.fromJson(json.decode(str));

String quranToJson(Quran data) => json.encode(data.toJson());

class Quran {
  Quran({
    this.reciters,
  });

  List<Reciter> reciters;

  factory Quran.fromJson(Map<String, dynamic> json) => Quran(
    reciters: List<Reciter>.from(json["reciters"].map((x) => Reciter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "reciters": List<dynamic>.from(reciters.map((x) => x.toJson())),
  };
}

class Reciter {
  Reciter({
    this.id,
    this.name,
    this.server,
    this.rewaya,
    this.count,
    this.letter,
    this.suras,
  });

  String id;
  String name;
  String server;
  String rewaya;
  String count;
  String letter;
  String suras;

  factory Reciter.fromJson(Map<String, dynamic> json) => Reciter(
    id: json["id"],
    name: json["name"],
    server: json["Server"],
    rewaya: json["rewaya"],
    count: json["count"],
    letter: json["letter"],
    suras: json["suras"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "Server": server,
    "rewaya": rewaya,
    "count": count,
    "letter": letter,
    "suras": suras,
  };
}
