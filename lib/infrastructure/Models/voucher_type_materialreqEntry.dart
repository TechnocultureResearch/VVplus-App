

class VoucherTypeMaterialReqEntryModel{

  String StrSubCode; String StrName;

  VoucherTypeMaterialReqEntryModel({
   this.StrSubCode, this.StrName
});

  factory VoucherTypeMaterialReqEntryModel.fromJson(Map<String, dynamic> json) => VoucherTypeMaterialReqEntryModel(
    StrSubCode: json['StrSubCode'],
    StrName: json['StrName']
  );

  Map<String, dynamic>toJson() => {
    'StrSubCode': StrSubCode,
    'StrName': StrName
  };
}