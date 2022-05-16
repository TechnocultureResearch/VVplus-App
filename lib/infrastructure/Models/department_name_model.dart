import 'dart:convert';

//StrRecord strRecordFromJson(String str) => StrRecord.fromJson(json.decode(str));
//String strRecordToJson(StrRecord data) => json.encode(data.toJson());

List<DepartmentName> strRecordFromJson(String str) => List<DepartmentName>.from(
    json.decode(str).map((x) => DepartmentName.fromJson(x)));

String strRecordToJson(List<DepartmentName> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentName {
  DepartmentName({
    this.strSubCode,
    this.strName,
    this.Name,
    this.subCode,
  });
  String subCode;
  String strSubCode;
  String strName;
  String Name;

  factory DepartmentName.fromJson(Map<String, dynamic> json) => DepartmentName(
        strSubCode: json["StrSubCode"],
        strName: json["StrName"],
        Name: json["Name"],
        subCode: json["SubCode"],
      );

  Map<String, dynamic> toJson() => {
        "StrSubCode": strSubCode,
        "StrName": strName,
        "Name": Name,
        "SubCode": subCode,
      };
}
