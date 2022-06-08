

class VoucherTypeMaterialReqEntryModel{

  String SubCode; String Name;

  VoucherTypeMaterialReqEntryModel({
   this.SubCode, this.Name
});

  factory VoucherTypeMaterialReqEntryModel.fromJson(Map<String, dynamic> json) => VoucherTypeMaterialReqEntryModel(
    SubCode: json['SubCode'],
    Name: json['Name']
  );

  Map<String, dynamic>toJson() => {
    'SubCode': SubCode,
    'Name': Name
  };
}