import 'dart:convert';

Languages languagesFromJson(String str) => Languages.fromJson(json.decode(str));

String languagesToJson(Languages data) => json.encode(data.toMap());

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'english': english,
      'spanish': spanish,
    };
  }

  @override
  String toString() {
    return 'Language{id: $id, english: $english, spanish: $spanish}';
  }
}
