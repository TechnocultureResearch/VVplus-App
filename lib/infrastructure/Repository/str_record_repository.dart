import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'dart:async';

class Repository {
  Client client = new Client();
  final String url = "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"Indentor","StrSiteCode":"AS","StrV_Type":"IND","StrChkNonStockabl// e":"","StrItemCode":"","StrCostCenterCode":"","StrAllCostCenter":"","StrUPCostCenter":[{"StrCostC// enterCode":""},{"StrCostCenterCode":""}]}'}";

  Future<List<StrRecord>> getData() async {
    try {
      final response = await client.get(Uri.parse(url));
      final items = (jsonDecode(response.body) as List)
          .map((e) => StrRecord.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
}
/*
getData1()async{
  http.Response res = await http.get(Uri.parse(URL));
  xml2json.parse(res.body);
  var jsondata = xml2json.toGData();
  var data = json.decode(jsondata);
  //buildlists(data);
  print(data);
}

 */