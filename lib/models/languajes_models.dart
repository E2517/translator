import 'dart:convert';

Languages languagesFromJson(String str) => Languages.fromJson(json.decode(str));

String languagesToJson(Languages data) => json.encode(data.toJson());

class Languages {
  Languages({
    this.id,
    this.english,
    this.spanish,
  });

  int id;
  String english;
  String spanish;

  factory Languages.fromJson(Map<String, dynamic> json) => Languages(
        id: json["id"],
        english: json["english"],
        spanish: json["spanish"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "english": english,
        "spanish": spanish,
      };
}
