
class Stage{
  String SearchCode;
  String Name;
  String Date;
  String DueDate;

  Stage({
    this.SearchCode,
    this.Name,
    this.Date,
    this.DueDate,
});

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
    SearchCode: json["SearchCode"],
    Name: json["Name"],
    Date: json["Date"],
    DueDate: json["DueDate"]
  );

  Map<String, dynamic> toJson() => {
    "SearchCode": SearchCode,
    "Name": Name,
    "Date": Date,
    "DueDate": DueDate
  };
}