import 'dart:convert';

//StrRecord strRecordFromJson(String str) => StrRecord.fromJson(json.decode(str));

//String strRecordToJson(StrRecord data) => json.encode(data.toJson());

List<ItemCurrentStatus> strRecordFromJson(String str) =>
    List<ItemCurrentStatus>.from(json.decode(str).map((x) => ItemCurrentStatus.fromJson(x)));

String strRecordToJson(List<ItemCurrentStatus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemCurrentStatus {
  ItemCurrentStatus({
    this.strItemName,
    this.strCostCenterName,
    this.dblQty,
    this.strUnit,
    this.SearchCode,this.Name,this.Code,this.BarCodeType,this.BatchApp,this.ExpiryApp,this.FixedBarCode,
    this.HSN_SAC,this.IGName,this.LotNoYN,this.MaintainStockOn,this.MaxStock,this.MinStock,
    this.PurchaseRate,this.ReOrder,this.SKU
  });
  @override
  String toString() => Name;

  String strItemName;
  String strCostCenterName;
  String dblQty;
  String strUnit;
  String SearchCode;
  String Name;
  String Code; String SKU; String IGName; String MinStock; String MaxStock; String ReOrder;
  String BatchApp; String LotNoYN; String MaintainStockOn; String PurchaseRate; String BarCodeType;
  String ExpiryApp; String FixedBarCode; String HSN_SAC;

  factory ItemCurrentStatus.fromJson(Map<String, dynamic> json) => ItemCurrentStatus(
    strItemName: json["StrItemName"],
    strCostCenterName: json["StrCostCenterName"],
    dblQty: json["DblQty"],
    strUnit: json["StrUnit"],
    SearchCode: json["SearchCode"],
    Name: json["Name"],
    Code: json["Code"],SKU: json["SKU"],IGName: json["IGName"],MinStock: json["MinStock"],
    MaxStock: json["MaxStock"],ReOrder: json["ReOrder"],BatchApp: json["BatchApp"],
    LotNoYN: json["LotNoYN"],MaintainStockOn: json["MaintainStockOn"],PurchaseRate: json["PurchaseRate"],
    BarCodeType: json["BarCodeType"],ExpiryApp: json["ExpiryApp"],FixedBarCode: json["FixedBarCode"],
    HSN_SAC: json["HSN_SAC"],
  );

  Map<String, dynamic> toJson() => {
    "StrItemName": strItemName,
    "StrCostCenterName": strCostCenterName,
    "DblQty": dblQty,
    "StrUnit": strUnit,
    "SearchCode": SearchCode,
    "Name": Name,"Code": Code,"SKU": SKU,"IGName":IGName,"MinStock":MinStock,"MaxStock":MaxStock,
    "ReOrder": ReOrder,"BatchApp":BatchApp,"LotNoYN":LotNoYN,"MaintainStockOn":MaintainStockOn,
    "PurchaseRate": PurchaseRate,"BarCodeType":BarCodeType,"ExpiryApp":ExpiryApp,
    "FixedBarCode": FixedBarCode,"HSNSAC": HSN_SAC,
  };
}
