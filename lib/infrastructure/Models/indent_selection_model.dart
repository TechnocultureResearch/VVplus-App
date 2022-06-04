import 'dart:core';

class IndentSelection {
  String StrDocID;
  String StrRecId;
  String StrV_Date;
  String StrIndenter;
  String StrDepartment;
  String searchCode;
  String itemCode;
  String maintainStockValue;
  String itemName;
  String unit;
  int pendingQty;
  int rate;
  String remark;
  String refDocId;
  String indNo;
  String indDate;
  int indQty;
  String hsnSacName;
  String hsnSacCode;

  IndentSelection({
    this.StrDepartment,
    this.hsnSacName,
    this.hsnSacCode,
    this.StrDocID,
    this.StrIndenter,
    this.StrRecId,
    this.StrV_Date,
    this.searchCode,
    this.itemCode,
    this.maintainStockValue,
    this.itemName,
    this.unit,
    this.pendingQty,
    this.rate,
    this.remark,
    this.refDocId,
    this.indNo,
    this.indDate,
    this.indQty,
  });
  factory IndentSelection.fromJson(Map<String, dynamic> json) =>
      IndentSelection(
        StrDepartment: json["StrDepartment"],
        StrDocID: json["StrDocID"],
        StrIndenter: json["StrIndenter"],
        StrRecId: json["StrRecId"],
        StrV_Date: json["StrV_Date"],
        searchCode: json["SearchCode"],
        itemCode: json["ItemCode"],
        maintainStockValue: json["MaintainStockValue"],
        itemName: json["ItemName"],
        unit: json["Unit"],
        pendingQty: json["PendingQty"],
        rate: json["Rate"],
        remark: json["Remark"],
        refDocId: json["RefDocId"],
        indNo: json["IndNo"],
        indDate: json["IndDate"],
        indQty: json["IndQty"],
        hsnSacCode: json["HSN_SAC_Code"],
        hsnSacName: json["HSN_SACName"],
      );

  Map<String, dynamic> toJson() => {
        "StrV_Date": StrV_Date,
        "IndQty": indQty,
        "StrDocID": StrDocID,
        "StrIndenter": StrIndenter,
        "StrRecId": StrRecId,
        "StrV_Date": StrV_Date,
        "SearchCode": searchCode,
        "ItemCode": itemCode,
        "MaintainStockValue": maintainStockValue,
        "ItemName": itemName,
        "Unit": unit,
        "PendingQty": pendingQty,
        "Rate": rate,
        "Remark": remark,
        "RefDocId": refDocId,
        "IndNo": indNo,
        "IndDate": indDate,
        "HSN_SAC_Code": hsnSacCode,
        "HSN_SACName": hsnSacName,
      };
}
