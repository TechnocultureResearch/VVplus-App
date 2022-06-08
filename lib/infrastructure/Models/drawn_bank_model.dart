import 'dart:convert';

List<DrawnBank> strRecordFromJson(String str) =>
    List<DrawnBank>.from(json.decode(str).map((x) => DrawnBank.fromJson(x)));

String strRecordToJson(List<DrawnBank> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DrawnBank {
  String subCode;
  String name;

  DrawnBank({
    this.subCode,
    this.name,
  });

  factory DrawnBank.fromJson(Map<String, dynamic> json) => DrawnBank(
        subCode: json["SubCode"],
        name: json["Name"],
      );
  Map<String, dynamic> toJson() => {
        "SubCode": subCode,
        "Name": name,
      };
}
