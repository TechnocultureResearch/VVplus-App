import 'dart:convert';

//StrRecord strRecordFromJson(String str) => StrRecord.fromJson(json.decode(str));

//String strRecordToJson(StrRecord data) => json.encode(data.toJson());

List<ItemName> strRecordFromJson(String str) =>
    List<ItemName>.from(json.decode(str).map((x) => ItemName.fromJson(x)));

String strRecordToJson(List<ItemName> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemName {
  ItemName({
    this.strCostCenterName,
    this.dblQty,
    this.strUnit,
    this.SearchCode,this.Name,this.Code,this.BarCodeType,this.BatchApp,this.ExpiryApp,this.FixedBarCode,
    this.HSN_SAC,this.IGName,this.LotNoYN,this.MaintainStockOn,this.MaxStock,this.MinStock,
    this.PurchaseRate,this.ReOrder,this.SKU,
    this.strItemCode,
    this.strItemName,
    this.strItemManualCode,
    this.strItemMinStock,
    this.strItemMaxStock,
    this.strItemReorder,
    this.strItemSku,
    this.strItemGroup,
    this.strItemCategory,
    this.strItemType,
    this.strItemDescription,
    this.strItemMaintainStockOn,
  });
  String strItemName;
  String strCostCenterName;
  String dblQty;
  String strUnit;
  String SearchCode;
  String Name;
  String Code; String SKU; String IGName; String MinStock; String MaxStock; String ReOrder;
  String BatchApp; String LotNoYN; String MaintainStockOn; String PurchaseRate; String BarCodeType;
  String ExpiryApp; String FixedBarCode; String HSN_SAC;
  String strItemCode;
  String strItemManualCode;
  String strItemMinStock;
  String strItemMaxStock;
  String strItemReorder;
  String strItemSku;
  String strItemGroup;
  String strItemCategory;
  String strItemType;
  String strItemDescription;
  String strItemMaintainStockOn;

  factory ItemName.fromJson(Map<String, dynamic> json) => ItemName(
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
    strItemCode: json["StrItemCode"],
    strItemName: json["StrItemName"],
    strItemManualCode: json["StrItemManualCode"],
    strItemMinStock: json["StrItemMinStock"],
    strItemMaxStock: json["StrItemMaxStock"],
    strItemReorder: json["StrItemReorder"],
    strItemSku: json["StrItemSKU"],
    strItemGroup: json["StrItemGroup"],
    strItemCategory: json["StrItemCategory"],
    strItemType: json["StrItemType"],
    strItemDescription: json["StrItemDescription"],
    strItemMaintainStockOn: json["StrItemMaintainStockOn"],
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
    "StrItemCode": strItemCode,
    "StrItemName": strItemName,
    "StrItemManualCode": strItemManualCode,
    "StrItemMinStock": strItemMinStock,
    "StrItemMaxStock": strItemMaxStock,
    "StrItemReorder": strItemReorder,
    "StrItemSKU": strItemSku,
    "StrItemGroup": strItemGroup,
    "StrItemCategory": strItemCategory,
    "StrItemType": strItemType,
    "StrItemDescription": strItemDescription,
    "StrItemMaintainStockOn": strItemMaintainStockOn,
  };
}
