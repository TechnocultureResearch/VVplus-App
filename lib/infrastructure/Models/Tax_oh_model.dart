


class TAXOH {
  String Code;
  String ExpCode; String AcName; String R0ff;
  String Name;  String Account;
  String ShortName; String Description; String SubExpCode; String SubExpense;
  num RC_TaxPer; num TaxPer;

  TAXOH({
  this.Name, this.Code, this.Description, this.Account, this.AcName, this.ExpCode,
  this.R0ff, this.ShortName, this.SubExpCode, this.SubExpense,
  this.TaxPer, this.RC_TaxPer,
});

  factory TAXOH.fromJson(Map<String, dynamic> json) => TAXOH(
    Name: json["Name"],
    Code: json["Code"],
    Description: json["Description"],
    Account: json["Account"], SubExpense: json["SubExpense"],
    AcName: json["AcName"], ShortName: json["ShortName"], SubExpCode: json["SubExpCode"],
    ExpCode: json["ExpCode"], R0ff: json["R0ff"],
    RC_TaxPer: json["RC_TaxPer"],TaxPer: json["TaxPer"],
  );

  Map<String, dynamic> toJson() => {
    "Name": Name, "Code": Code, "Description": Description, "Account": Account,
    "SubExpense": SubExpense,  "AcName": AcName, "ShortName": ShortName,
    "SubExpCode": SubExpCode, "ExpCode": ExpCode, "R0ff": R0ff,
    "RC_TaxPer": RC_TaxPer, "TaxPer": TaxPer,
  };
}