import 'dart:convert';

List<ChangeApplicable> changeApplicableFromJson(String str) =>
    List<ChangeApplicable>.from(
        json.decode(str).map((x) => ChangeApplicable.fromJson(x)));

String changeApplicableToJson(List<ChangeApplicable> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChangeApplicable {
  ChangeApplicable({this.strSubCode, this.strName, this.name});

  String strSubCode;
  String strName;
  String name;

  factory ChangeApplicable.fromJson(Map<String, dynamic> json) =>
      ChangeApplicable(
        strSubCode: json["StrSubCode"],
        strName: json["StrName"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "StrSubCode": strSubCode,
        "StrName": strName,
        "Name": name,
      };
}
