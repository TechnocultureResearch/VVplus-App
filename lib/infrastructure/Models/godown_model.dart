class Godown {
  String GodCode;
  String GodName;

  Godown({
    this.GodCode,
    this.GodName,
});

  factory Godown.fromJson(Map<String, dynamic> json) => Godown(
    GodCode: json["GodCode"],
    GodName: json["GodName"],
  );
  Map<String,dynamic> tojson()=> {
    "GodCode": GodCode,
    "GodName": GodName,
  };
}