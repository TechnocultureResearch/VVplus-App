

class IndentNo{
  String RefDocId; String IndNo; String IndDate; String Department; String Indenter;
  String ICCName; String ItemName; String Unit; num IndQty; num AdjQty;
  num PendingQty; String ItemCode; num Rate; String Remark;
  String MaintainStockValue; String V_SNo; String Site_Code;
  String StrDocID;
  String StrRecId;
  String StrV_Date;
  String StrIndenter;
  String StrDepartment;

  IndentNo({
    this.AdjQty, this.Department, this.ICCName, this.IndDate, this.Indenter, this.IndNo,
    this.IndQty, this.ItemCode, this.ItemName, this.MaintainStockValue, this.PendingQty,
    this.Rate, this.Remark, this.RefDocId, this.Site_Code, this.Unit, this.V_SNo,
    this.StrDocID, this.StrV_Date, this.StrRecId, this.StrIndenter, this.StrDepartment
});
  factory IndentNo.fromJson(Map<String, dynamic> json) => IndentNo(
  RefDocId: json["RefDocId"], AdjQty: json["AdjQty"], Department: json["Department"],
    ICCName: json["ICCName"], IndDate: json["IndDate"], Indenter: json["Indenter"],
    IndNo: json["IndNo"], IndQty: json["IndQty"], ItemCode: json["ItemCode"],
    ItemName: json["ItemName"], MaintainStockValue: json["MaintainStockValue"],
    PendingQty: json["PendingQty"], Rate: json["Rate"], Remark: json["Remark"],
    Site_Code: json["Site_Code"], Unit: json["Unit"], V_SNo: json["V_SNo"],
      StrV_Date: json["StrV_Date"], StrRecId: json["StrRecId"], StrIndenter: json["StrIndenter"],
    StrDocID: json["StrDocID"], StrDepartment: json["StrDepartment"]
  );

  Map<String, dynamic> toJson() => {
    "RefDocId": RefDocId, "AdjQty0": AdjQty, "Department": Department, "ICCName": ICCName,
    "IndDate": IndDate, "Indenter": Indenter, "IndNo": IndNo, "IndQty": IndQty,
    "ItemCode": ItemCode, "ItemName": ItemName, "MaintainStockValue": MaintainStockValue,
    "PendingQty": PendingQty, "Rate": Rate, "Remark": Remark, "Site_Code": Site_Code,
    "Unit": Unit, "V_SNo": V_SNo,
    "StrDepartment": StrDepartment, "StrIndenter": StrIndenter, "StrRecId": StrRecId,
    "StrV_Date": StrV_Date, "StrDocID": StrDocID
  };
}