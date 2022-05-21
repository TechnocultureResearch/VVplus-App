
class FillTransferModel{
  String DocId; String POrdNo; String V_Type; String POrdDate;

  FillTransferModel({
    this.V_Type, this.DocId, this.POrdDate, this.POrdNo
});

  factory FillTransferModel.fromJson(Map<String, dynamic> json) => FillTransferModel(
    V_Type: json["V_type"],
    DocId: json["DocId"],
    POrdDate: json["POrdDate"],
    POrdNo: json["POrdNo"]
  );

  Map<String, dynamic> toJson() => {
    "V_type": V_Type,
    "DocId": DocId,
    "POrdDate": POrdDate,
    "POrdNo": POrdNo
  };
}