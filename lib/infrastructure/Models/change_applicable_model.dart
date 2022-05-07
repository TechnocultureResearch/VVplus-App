import 'dart:convert';

List<ChangeApplicable> changeApplicableFromJson(String str) =>
    List<ChangeApplicable>.from(
        json.decode(str).map((x) => ChangeApplicable.fromJson(x)));

String changeApplicableToJson(List<ChangeApplicable> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChangeApplicable {
  ChangeApplicable({
    this.strSubCode,
    this.strName,
  });

  String strSubCode;
  String strName;

  factory ChangeApplicable.fromJson(Map<String, dynamic> json) =>
      ChangeApplicable(
        strSubCode: json["StrSubCode"],
        strName: json["StrName"],
      );

  Map<String, dynamic> toJson() => {
        "StrSubCode": strSubCode,
        "StrName": strName,
      };
}
