import 'dart:convert';

//StrRecord strRecordFromJson(String str) => StrRecord.fromJson(json.decode(str));
//String strRecordToJson(StrRecord data) => json.encode(data.toJson());

List<VoucherType> strRecordFromJson(String str) =>
    List<VoucherType>.from(json.decode(str).map((x) => VoucherType.fromJson(x)));

String strRecordToJson(List<VoucherType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class VoucherType {
  VoucherType({
    this.strSubCode,
    this.strName,
    this.godown,
    this.purchaseOrderSelect,
    this.supplier,
    this.V_Type,
    this.Description,
    this.Name
  });

  String strSubCode;
  String strName;
  String godown;
  String purchaseOrderSelect;
  String supplier;
  String V_Type;
  String Description;
  String Name;

  factory VoucherType.fromJson(Map<String, dynamic> json) => VoucherType(
    strSubCode: json["StrSubCode"],
    strName: json["StrName"],
    godown: json["Godown"],
    purchaseOrderSelect: json["Purchase_order_select"],
    supplier: json["Supplier"],
    V_Type: json["V_Type"],
    Description: json["Description"],
    Name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "StrSubCode": strSubCode,
    "StrName": strName,
    "Godown": godown,
    "Purchase_order_select": purchaseOrderSelect,
    "Supplier": supplier,
    "V_Type": V_Type,
    "Description": Description,
    "Name": Name
  };
}