import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'dart:async';

import 'package:vvplus_app/infrastructure/Models/item_current_status_model.dart';

String firebaseUrl = "https://vvplus-app-default-rtdb.firebaseio.com/StrRecord.json";
class ItemCurrentStatusRepository {
  Client client = Client();

  Future<List<ItemCurrentStatus>> getData() async {
    try {
      final response = await client.get(Uri.parse(ApiService.getStockReceiveItemCurrentStatusewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => ItemCurrentStatus.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
  
  Future<List<ItemCurrentStatus>> getStockissueItemData() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getStockIssueItemCurrentStatusnewURL));
      final items = (jsonDecode(response.body) as List)
      .map((e) => ItemCurrentStatus.fromJson(e))
      .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
}
Future<List<ItemCurrentStatus>> createUser( String strItemName, double dblQty,String strUnit) async{
  final response = await http.post(Uri.parse(ApiService.getItemCurrentStatusURL), body: {
    "StrItemName": strItemName,
    "DblQty": dblQty,
    "StrUnit": strUnit,
  });

  if(response.statusCode == 200){
    final String responseString = response.body;
    return strRecordFromJson(responseString);
  }else{
    return null;
  }
}