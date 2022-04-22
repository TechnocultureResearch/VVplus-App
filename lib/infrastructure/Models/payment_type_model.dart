
class PaymentType{
  String Code;
  String Name;
  PaymentType({
   this.Code,
   this.Name
});

  factory PaymentType.fromJson(Map<String, dynamic> json) => PaymentType(
    Code: json["Code"],
    Name: json["Name"]
  );

  Map<String, dynamic> toJson() => {
    "Code": Code,
    "Name": Name
  };
}