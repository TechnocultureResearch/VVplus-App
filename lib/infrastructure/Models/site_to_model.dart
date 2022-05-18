

class SiteTo{
  String Code; String Name; String SubCode; String PartyName;String Location;
  String Form_Code; String Form_Desc;

  SiteTo({
    this.Name, this.Location, this.Form_Desc, this.Form_Code,
  this.SubCode, this.Code, this.PartyName
  });

  factory SiteTo.fromJson(Map<String, dynamic> json) => SiteTo(
    Location: json["Location"],
    Form_Desc: json["Form_Desc"],
    Form_Code: json["Form_Code"],
    SubCode: json["SubCode"],
    Name: json["Name"],
    Code: json["Code"],
    PartyName: json["PartyName"]
  );
  Map<String, dynamic> tJson() => {
    "Location": Location,
    "Form_Desc": Form_Desc,
    "Form_Code": Form_Code,
    "SubCode": SubCode,
    "Name": Name,
    "Code": Code,
    "PartyName": PartyName
  };
}
