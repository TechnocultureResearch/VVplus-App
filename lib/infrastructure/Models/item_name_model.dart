import 'dart:convert';

//StrRecord strRecordFromJson(String str) => StrRecord.fromJson(json.decode(str));

//String strRecordToJson(StrRecord data) => json.encode(data.toJson());

List<ItemNameModel> strRecordFromJson(String str) =>
    List<ItemNameModel>.from(json.decode(str).map((x) => ItemNameModel.fromJson(x)));

String strRecordToJson(List<ItemNameModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemNameModel {
  ItemNameModel({
    this.requestQty,
    this.CostCenterName,
    this.dblQty,
    this.Unit,
    this.SearchCode,this.Name,this.Code,this.BarCodeType,this.BatchApp,this.ExpiryApp,this.FixedBarCode,
    this.HSN_SAC,this.IGName,this.LotNoYN,this.MaintainStockOn,this.MaxStock,this.MinStock,
    this.PurchaseRate,this.ReOrder,this.SKU,
    this.ItemName,
    this.ItemCode,
    this.ItemManualCode,
    this.ItemMinStock,
    this.ItemMaxStock,
    this.ItemReorder,
    this.ItemSKU,
    this.ItemGroup,
    this.ItemCategory,
    this.ItemType,
    this.ItemDescription,
    this.ItemMaintainStockOn,
  });

  @override
  String toString() => Name;

  String requestQty;
  String ItemName;
  String CostCenterName;
  String dblQty;
  String Unit;
  String SearchCode;
  String Name;
  String Code; String SKU; String IGName; String MinStock; String MaxStock; String ReOrder;
  String BatchApp; String LotNoYN; String MaintainStockOn; String PurchaseRate; String BarCodeType;
  String ExpiryApp; String FixedBarCode; String HSN_SAC;
  String ItemCode;
  String ItemManualCode;
  String ItemMinStock;
  String ItemMaxStock;
  String ItemReorder;
  String ItemSKU;
  String ItemGroup;
  String ItemCategory;
  String ItemType;
  String ItemDescription;
  String ItemMaintainStockOn;

  factory ItemNameModel.fromJson(Map<String, dynamic> json) => ItemNameModel(
    requestQty: json["requestQty"],
    CostCenterName: json["CostCenterName"],
    dblQty: json["DblQty"],
    Unit: json["Unit"],
    SearchCode: json["SearchCode"],
    Name: json["Name"],
    Code: json["Code"],SKU: json["SKU"],IGName: json["IGName"],MinStock: json["MinStock"],
    MaxStock: json["MaxStock"],ReOrder: json["ReOrder"],BatchApp: json["BatchApp"],
    LotNoYN: json["LotNoYN"],MaintainStockOn: json["MaintainStockOn"],PurchaseRate: json["PurchaseRate"],
    BarCodeType: json["BarCodeType"],ExpiryApp: json["ExpiryApp"],FixedBarCode: json["FixedBarCode"],
    HSN_SAC: json["HSN_SAC"],
    ItemCode: json["ItemCode"],
    ItemName: json["ItemName"],
    ItemManualCode: json["ItemManualCode"],
    ItemMinStock: json["ItemMinStock"],
    ItemMaxStock: json["ItemMaxStock"],
    ItemReorder: json["ItemReorder"],
    ItemSKU: json["ItemSKU"],
    ItemGroup: json["ItemGroup"],
    ItemCategory: json["ItemCategory"],
    ItemType: json["ItemType"],
    ItemDescription: json["ItemDescription"],
    ItemMaintainStockOn: json["ItemMaintainStockOn"],
  );

  Map<String, dynamic> toJson() => {
    "requestQty": requestQty,
    "ItemName": ItemName,
    "StrCostCenterName": CostCenterName,
    "DblQty": dblQty,
    "StrUnit": Unit,
    "SearchCode": SearchCode,
    "Name": Name,"Code": Code,"SKU": SKU,"IGName":IGName,"MinStock":MinStock,"MaxStock":MaxStock,
    "ReOrder": ReOrder,"BatchApp":BatchApp,"LotNoYN":LotNoYN,"MaintainStockOn":MaintainStockOn,
    "PurchaseRate": PurchaseRate,"BarCodeType":BarCodeType,"ExpiryApp":ExpiryApp,
    "FixedBarCode": FixedBarCode,"HSNSAC": HSN_SAC,
    "ItemCode": ItemCode,
    "ItemName": ItemName,
    "ItemManualCode": ItemManualCode,
    "ItemMinStock": ItemMinStock,
    "ItemMaxStock": ItemMaxStock,
    "ItemReorder": ItemReorder,
    "ItemSKU": ItemSKU,
    "ItemGroup": ItemGroup,
    "ItemCategory": ItemCategory,
    "StrItemType": ItemType,
    "ItemDescription": ItemDescription,
    "ItemMaintainStockOn": ItemMaintainStockOn,
  };
}
