
class CreditAccount{
  String SubCode; String Name; String ManualCode; String udmname;
  String Account_Code; String Account_Name; String nature;

  CreditAccount({
    this.Name, this.SubCode, this.ManualCode, this.Account_Name,
    this.Account_Code,this.nature,this.udmname
});

  factory CreditAccount.fromJson(Map<String, dynamic> json) => CreditAccount(
    Name: json["Name"],
    SubCode: json["SubCode"],
    ManualCode: json["ManualCode"],
    Account_Name: json["Account_Name"],
    Account_Code: json["Account_Code"],
    nature: json["nature"],
    udmname: json["udmname"]
  );
  Map<String, dynamic> toJson() => {
    "Name": Name,
    "SubCode": SubCode,
    "ManualCode": ManualCode,
    "Account_Name": Account_Name,
    "Account_Code": Account_Code,
    "nature": nature,
    "udmname": udmname
  };
}