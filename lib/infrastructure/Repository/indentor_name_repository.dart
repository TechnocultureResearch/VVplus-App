import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'dart:async';

import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';

class IndentorNameRepository {
  Client client = Client();

  // Future<List<IndentorName>> getData() async {
  //   try {
  //     final response =
  //         await client.get(Uri.parse(ApiService.getPOIndentNonewURL));
  //     final items = (jsonDecode(response.body) as List)
  //         .map((e) => IndentorName.fromJson(e))
  //         .toList();
  //     return items;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  //
  // Future<List<IndentorName>> getIndentData() async {
  //   try {
  //     final response =
  //         await client.get(Uri.parse(ApiService.getPOIndentNonewURL));
  //     final items = (jsonDecode(response.body) as List)
  //         .map((e) => IndentorName.fromJson(e))
  //         .toList();
  //     return items;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}

Future<List<IndentorName>> createUser(String strSubCode, String strName) async {
  const String uRL1 =
      "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostIndent?StrRecord=${'{"StrIndTypeCode":"IND","StrSiteCode":"AD","StrIndNo":"11","StrIndDate":"10/11/2021","StrDepartmentCode":"AD2","StrIndentorCode":"SG344","StrPreparedByCode":"SA","StrIndGrid":[{"StrItemCode":"PN1","DblQuantity":"100","StrCostCenterCode":"AD1","StrRequiredDate":"10/11/2021","StrRemark":"remark1"}]}'}";
  // final String url = "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"Indentor","StrSiteCode":"AS","StrV_Type":"IND","StrChkNonStockabl// e":"","StrItemCode":"","StrCostCenterCode":"","StrAllCostCenter":"","StrUPCostCenter":[{"StrCostC// enterCode":""},{"StrCostCenterCode":""}]}'}";
  final response = await http.post(Uri.parse(uRL1), body: {
    "StrSubCode": strSubCode,
    "StrName": strName,
  });

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return strRecordFromJson(responseString);
  } else {
    return null;
  }
}
