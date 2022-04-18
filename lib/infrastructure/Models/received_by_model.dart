
class ReceivedBy{
  String SubCode;
  String Name;
  String ManualCode;

  ReceivedBy
      ({
    this.ManualCode,
    this.Name,
    this.SubCode
  });

  factory ReceivedBy.fromJson(Map<String, dynamic> json)=> ReceivedBy(
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