

import 'dart:core';

class IndentSelection {
  String StrDocID; String StrRecId;
  String StrV_Date; String StrIndenter; String StrDepartment;

  IndentSelection({
   this.StrDepartment, this.StrDocID, this.StrIndenter,
   this.StrRecId, this.StrV_Date
});
  factory IndentSelection.fromJson(Map<String, dynamic> json) => IndentSelection(
    StrDepartment: json["StrDepartment"],
    StrDocID: json["StrDocID"],
    StrIndenter: json["StrIndenter"],
    StrRecId: json["StrRecId"],
    StrV_Date: json["StrV_Date"],
  );

  Map<String, dynamic> toJson() => {
     "StrV_Date" : StrV_Date,
    "StrDocID" : StrDocID, "StrIndenter" : StrIndenter, "StrRecId" : StrRecId, "StrV_Date" : StrV_Date
  };
}