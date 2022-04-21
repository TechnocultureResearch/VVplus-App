
class IssuedTo{
  String SubCode;
  String Name;
  String ManualCode;

  IssuedTo
      ({
    this.ManualCode,
    this.Name,
    this.SubCode
  });

  factory IssuedTo.fromJson(Map<String, dynamic> json)=> IssuedTo(
    ManualCode: json["ManualCode"],
    Name: json["Name"],
    SubCode: json["SubCode"],
  );

  Map<String, dynamic> toJson()=>{
    "ManualCode": ManualCode,
    "Name": Name,
    "SubCode": SubCode,
  };

}