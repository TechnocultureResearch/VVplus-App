// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';


class VoucherTypeRepository {
  Client client = Client();

  Future<List<VoucherType>> getData() async {
    try {
      final response = await client.get(Uri.parse(ApiService.getVoucherTypenewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => VoucherType.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
  Future<List<VoucherType>> getStockIssueVoucherData() async {
    try {
      final response = await client.get(Uri.parse(ApiService.getVouchertypeStockIssuenewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => VoucherType.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
  Future<List<VoucherType>> getChequeReceiveVoucherData() async{
    try{
      final response = await client.get(Uri.parse(ApiService.getChequeReceiveVoucherTypenewURL));
      final items = (jsonDecode(response.body) as List)
      .map((e) => VoucherType.fromJson(e))
      .toList();
      return items;
    }
    catch (e){
      rethrow;
    }
  }
  Future<List<VoucherType>> getExtraworkEntryVoucherData() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getExtraWorkVouchernewURL));
    final items = (jsonDecode(response.body) as List)
      .map((e) => VoucherType.fromJson(e))
      .toList();
    return items;
  }catch(e) {
rethrow;
    }
  }
  Future<List<VoucherType>> getPhaseToPhaseData() async {
   try {
     final response = await client.get(
         Uri.parse(ApiService.getPhasetoPhaseVoucherTypenewURL));
     final items = (jsonDecode(response.body) as List)
         .map((e) => VoucherType.fromJson(e))
         .toList();
     return items;
   }catch(e) {
     rethrow;
   }
  }
Future<List<VoucherType>> getPOData() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getPOVoucherTypenewURL));
      final items = (jsonDecode(response.body)as List)
      .map((e) => VoucherType.fromJson(e))
      .toList();
      return items;
    }catch(e){
      rethrow;
    }
}
Future<List<VoucherType>> getBToBsendData() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getBToBSendnewURl));
      final items = (jsonDecode(response.body)as List)
      .map((e) => VoucherType.fromJson(e))
      .toList();
      return items;
    }catch(e){
      rethrow;
    }
}
}

Future<List<VoucherType>> createUser(String strSubCode,String strName,String Godown) async{
  final response = await http.post(Uri.parse(ApiService.getVoucherTypeURL), body: {
    "StrSubCode": strSubCode,
    "StrName": strName,
    "Godown": Godown,
  });

  if(response.statusCode == 200){
    final String responseString = response.body;
    return strRecordFromJson(responseString);
  }else{
    return null;
  }
}