import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'dart:async';

import 'package:vvplus_app/infrastructure/Models/item_name_model.dart';



class ItemNameRepository {
  Client client = Client();

  Future<List<ItemNameModel>> getItemStockReceiveEntryData() async {
    try {
      final response = await client.get(Uri.parse(ApiService.getItemNameStockReceiveEntrynewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => ItemNameModel.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
  Future<List<ItemNameModel>> getStockissueItemData() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getStockIssueItemCurrentStatusnewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => ItemNameModel.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ItemNameModel>> getPhaseToPhaseTransferItemData() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getPhaseToPhaseItemnewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => ItemNameModel.fromJson(e))
          .toList();
      return items;
    }catch(e){
      rethrow;
    }
  }

  Future<List<ItemNameModel>> getItemMaterialReqEntryData() async{
    try{
final response = await client.get(Uri.parse(ApiService.getItemMaterialReqEntrynewURL));
final items = (jsonDecode(response.body) as List)
.map((e) => ItemNameModel.fromJson(e))
.toList();
return items;
    }catch(e){
      rethrow;
    }
  }
}


Future<List<ItemNameModel>> createUser(String strSubCode,String strName) async{
  final response = await http.post(Uri.parse(ApiService.getItemNameURL), body: {
    "StrSubCode": strSubCode,
    "StrName": strName,
  });

  if(response.statusCode == 200){
    final String responseString = response.body;
    return strRecordFromJson(responseString);
  }else{
    return null;
  }
}