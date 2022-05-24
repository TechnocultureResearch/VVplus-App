class Supplier {
  String SubCode;
  String Name;
  String CityName;
  String ManualCode;
  String State;
  String GSTIN;
  String Location;
  String Form_Code;
  String Form_Desc;

  Supplier(
      {this.SubCode,
      this.Name,
      this.CityName,
      this.ManualCode,
      this.State,
      this.Form_Code,
      this.GSTIN,
      this.Location,
      this.Form_Desc});
  @override
  String toString() => Name;
  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
      Name: json["Name"],
      SubCode: json["SubCode"],
      ManualCode: json["ManualCode"],
      CityName: json["CityName"],
      Form_Code: json["Form_Code"],
      State: json["State"],
      Form_Desc: json["Form_Desc"],
      GSTIN: json["GSTIN"],
      Location: json["Location"]);

  Map<String, dynamic> toJson() => {
        "Name": Name,
        "SubCode": SubCode,
        "ManualCode": ManualCode,
        "CityName": CityName,
        "Form_Code": Form_Code,
        "State": State,
        "Form_Desc": Form_Desc,
        "GSTIN": GSTIN,
        "Location": Location,
      };
}
