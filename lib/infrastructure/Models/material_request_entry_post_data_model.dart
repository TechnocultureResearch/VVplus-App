// To parse this JSON data, do
//
//     final materialRequestEntryPostData = materialRequestEntryPostDataFromJson(jsonString);

import 'dart:convert';

List<MaterialRequestEntryPostData> materialRequestEntryPostDataFromJson(String str) =>
    List<MaterialRequestEntryPostData>.from(json.decode(str).map((x) =>
        MaterialRequestEntryPostData.fromJson(x)));

String materialRequestEntryPostDataToJson(List<MaterialRequestEntryPostData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialRequestEntryPostData {
  MaterialRequestEntryPostData({
    this.indentSubCode,
    this.intendDate,
    this.itemName,
    this.reqQty,
    this.itemUnit,
    this.rate,
    this.itemSubCode,
    this.reqDate,
    this.remarks,
  });

  String indentSubCode;
  String intendDate;
  String itemName;
  String reqQty;
  String itemUnit;
  String rate;
  String itemSubCode;
  String reqDate;
  String remarks;

  factory MaterialRequestEntryPostData.fromJson(Map<String, dynamic> json) => MaterialRequestEntryPostData(
    indentSubCode: json["IndentSubCode"],
    intendDate: json["IntendDate"],
    itemName: json["ItemName"],
    reqQty: json["ReqQty"],
    itemUnit: json["ItemUnit"],
    rate: json["Rate"],
    itemSubCode: json["ItemSubCode"],
    reqDate: json["ReqDate"],
    remarks: json["Remarks"],
  );

  Map<String, dynamic> toJson() => {
    "IndentSubCode": indentSubCode,
    "IntendDate": intendDate,
    "ItemName": itemName,
    "ReqQty": reqQty,
    "ItemUnit": itemUnit,
    "Rate": rate,
    "ItemSubCode": itemSubCode,
    "ReqDate": reqDate,
    "Remarks": remarks,
  };
}
