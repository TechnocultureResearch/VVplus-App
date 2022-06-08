import 'dart:convert';

//StrRecord strRecordFromJson(String str) => StrRecord.fromJson(json.decode(str));
//String strRecordToJson(StrRecord data) => json.encode(data.toJson());

List<IndentorName> strRecordFromJson(String str) =>
    List<IndentorName>.from(json.decode(str).map((x) => IndentorName.fromJson(x)));

String strRecordToJson(List<IndentorName> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class IndentorName {
  IndentorName({
    this.strSubCode,
    this.SubCode, this.Name,
    this.strName, this.Remark, this.ReOrder, this.MaxStock, this.MinStock, this.ApprovedBy,
    this.ApprovedDateTime, this.Aprqty, this.AprRemark, this.AssignedTo, this.ATName,
    this.Closed, this.CostCenter, this.CostCenterCode, this.Dept, this.icode, this.IndDocid,
    this.inddt, this.Indentor, this.Indno, this.indqty, this.IndSno, this.Item, this.Itemcode,
    this.MaintaintockValue, this.ReqDate, this.SiteName, this.Sku, this.V_sno
  });

  String strSubCode;
  String SubCode; String Name;
  String strName; String IndDocid; String IndSno; String Itemcode; String Item;
  String icode; String V_sno; String MinStock; String MaxStock; String ReOrder;
  String indqty; String Aprqty; String CostCenterCode; String Sku; String CostCenter;
  String Remark; String Closed; String Indentor; String Dept; String Indno; String inddt;
  String ReqDate; String AssignedTo; String ATName; String MaintaintockValue;
  String AprRemark; String SiteName; String ApprovedBy; String ApprovedDateTime;


    factory IndentorName.fromJson(Map<String, dynamic> json) => IndentorName(
    strSubCode: json["StrSubCode"],
    SubCode: json["SubCode"], Name: json["Name"],
    strName: json["StrName"], IndDocid: json["IndDocid"], ReOrder: json["Reorder"],
        MaxStock: json["MaxStock"], MinStock: json["MinStock"], ApprovedBy: json["ApprovedBy"],
      ApprovedDateTime: json["ApprovedDateTime"], Aprqty: json["Aprqty"], AprRemark: json["AprRemark"],
      AssignedTo: json["AssignedTo"], ATName: json["ATName"], Closed: json["Closed"], CostCenter: json["CostCenter"],
      CostCenterCode: json["CostCenterCode"], Dept: json["Dept"], icode: json["icode"],
      inddt: json["inddt"], Indentor: json["Indentor"], Indno: json["Indno"], indqty: json["indqty"],
      IndSno: json["IndSno"], Item: json["Item"], Itemcode: json["Itemcode"], MaintaintockValue: json["MaintaintockValue"],
      Remark: json["Remark"], ReqDate: json["ReqDate"], SiteName: json["SiteName"],
        Sku: json["Sku"], V_sno: json["V_sno"]
  );

  Map<String, dynamic> toJson() => {
    "StrSubCode": strSubCode,
    "SubCode": SubCode,"Name": Name,
    "StrName": strName, "ReqDate": ReqDate, "MaintaintockValue": MaintaintockValue, "Itemcode": Itemcode,
    "Item": Item, "IndDocid": IndDocid, "ReOrder": ReOrder, "MaxStock": MaxStock, "MinStock": MinStock,
    "ApprovedBy": ApprovedBy, "ApprovedDateTime": ApprovedDateTime, "Aprqty": Aprqty,
    "AprRemark": AprRemark, "AssignedTo": AssignedTo, "ATName": ATName, "Closed": Closed,
    "CostCenter": CostCenter, "CostCenterCode": CostCenterCode, "Dept": Dept, "icode": icode,
    "inddt": inddt, "Indentor": Indentor, "Indno": Indno, "indqty": indqty, "IndSno": IndSno,
     "Remark": Remark, "SiteName": SiteName, "Sku": Sku, "V_sno": V_sno
  };
}
