

class BookingIdModel{
  String DocId; String V_Date; String UnitName; String SubCode; String Customer;
  String UnitCost; String UnitCode;String FloorName; String UnitCategoryname; String V_Type;
  String PName; String PCode; String FacingName; String UnitArea; String V_Prefix;
  String TaxStructureDesc;

  BookingIdModel({
    this.DocId, this.SubCode, this.V_Type, this.Customer, this.FacingName,
    this.FloorName, this.PCode, this.PName, this.TaxStructureDesc,
    this.UnitArea, this.UnitCategoryname, this.UnitCode, this.UnitCost,
    this.UnitName, this.V_Date, this.V_Prefix
});

  factory BookingIdModel.fromJson(Map<String, dynamic> json) => BookingIdModel(
    DocId: json["DocId"],
    SubCode: json["SubCode"],
    V_Type: json["V_Type"],
    Customer: json["Customer"],
    FacingName: json["FacingName"],
    FloorName: json["FloorName"],
    PCode: json["Pcode"],
    PName: json["PName"], TaxStructureDesc: json["TaxStructureDesc"],
    UnitArea: json["UnitArea"],
    UnitCategoryname: json["UnitCategoryname"],
    UnitCode: json["UnitCode"],
    UnitCost: json["UnitCost"], UnitName: json["UnitName"], V_Date: json["V_Date"],
    V_Prefix: json["V_Prefix"],
  );

  Map<String,dynamic> toJson() => {
    "DocId": DocId, "SubCode": SubCode, "V_Type": V_Type, "Customer": Customer,
    "FacingName": FacingName, "FloorName": FloorName, "PCode": PCode, "PName": PName,
    "UnitArea": UnitArea, "UnitCategoryname": UnitCategoryname, "UnitCode": UnitCode,
    "UnitCost": UnitCost, "V_Prefix": V_Prefix
  };
}