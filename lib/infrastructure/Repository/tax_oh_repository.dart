
import 'dart:convert';

import 'package:http/http.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/Tax_oh_model.dart';

class TAXOHRepository{
  Client client = Client();

  Future<List<TAXOH>> getTaxOH() async {
    try {
      final response = await client.get(Uri.parse(ApiService.getTaxOHnewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => TAXOH.fromJson(e))
          .toList();
      return items;
    }catch(e){
      rethrow;
    }
  }
Future<List<TAXOH>> getTAXOHUnitCancelationData() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getTaxOHUnitCancelationnewUrl));
      final items = (jsonDecode(response.body) as List)
      .map((e) => TAXOH.fromJson(e))
      .toList();
      return items;
    }catch(e){
      rethrow;
    }
}
}