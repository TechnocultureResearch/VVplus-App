import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';


class ItemCostCenterRepository {
  Client client = Client();

  Future<List<ItemCostCenter>> getData() async {
    try {
      final response = await client.get(Uri.parse(ApiService.getItemCostCenterMaterialReqEntrynewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => ItemCostCenter.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
  Future<List<ItemCostCenter>> getStockIssueEntryCostCenterData() async {
    try {
      final response = await client.get(Uri.parse(ApiService.getStockIssueCostCenternewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => ItemCostCenter.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ItemCostCenter>> getDailyManpowerCostCenterData() async {
    try {
      final response = await client.get(Uri.parse(ApiService.getDailyManpowerCostCenternewURL));
      final items = (jsonDecode(response.body) as List)
      .map((e) => ItemCostCenter.fromJson(e))
      .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
Future<List<ItemCostCenter>> getPhaseToPhaseFromCostCenterData() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getPhaseToPhaseFromCostCenternewURL));
      final items = (jsonDecode(response.body)as List)
      .map((e) => ItemCostCenter.fromJson(e)).toList();
      return items;
    }
    catch(e){
      rethrow;
    }
}
Future<List<ItemCostCenter>> getPhaseToPhaseToCostCenterData() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getPhaseToPhaseToCostCenternewURL));
      final items = (jsonDecode(response.body)as List)
      .map((e) => ItemCostCenter.fromJson(e)).toList();
      return items;
    }catch(e){
      rethrow;
    }
}
Future<List<ItemCostCenter>> getBToBsendFromCostCenterData() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getBToBSendFromCostCenter));
      final items = (jsonDecode(response.body)as List)
      .map((e) => ItemCostCenter.fromJson(e))
      .toList();
      return items;
    }catch(e){
      rethrow;
    }
}
Future<List<ItemCostCenter>> getBToBsendToCostCenter() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getBToBSendToCostCenter));
      final items = (jsonDecode(response.body)as List)
      .map((e) => ItemCostCenter.fromJson(e))
      .toList();
      return items;
    }catch(e){
      rethrow;
    }
}
}
Future<List<ItemCostCenter>> createUser(String strSubCode,String strName) async{
  final response = await http.post(Uri.parse(ApiService.getItemCostCenterURL), body: {
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