

class BookingIdModel{
  String DocId;

  BookingIdModel({
    this.DocId,
});

  factory BookingIdModel.fromJson(Map<String, dynamic> json) => BookingIdModel(
    DocId: json["DocId"]
  );

  Map<String,dynamic> toJson() => {
    "DocId": DocId
  };
}