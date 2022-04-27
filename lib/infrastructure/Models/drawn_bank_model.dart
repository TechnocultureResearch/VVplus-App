

import 'dart:convert';

List<DrawnBank> strRecordFromJson(String str) =>
    List<DrawnBank>.from(json.decode(str).map((x) => DrawnBank.fromJson(x)));

String strRecordToJson(List<DrawnBank> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class DrawnBank{
  String StrSubCode;
  String StrName;

  DrawnBank({
    this.StrName,
    this.StrSubCode,
});

  factory DrawnBank.fromJson(Map<String, dynamic> json) => DrawnBank(
    StrName: json["StrName"],
    StrSubCode: json["StrSubCode"],
  );
  Map<String, dynamic> toJson() => {
    "StrName": StrName,
    "StrSubCode": StrSubCode,
  };
}