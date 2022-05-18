

import 'dart:convert';

import 'package:http/http.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/site_to_model.dart';

class SiteToRepository{
  Client client = Client();

  Future<List<SiteTo>> getSiteToData() async{
    try {
      final response = await client.get(
          Uri.parse(ApiService.getSiteToBToBSendnewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => SiteTo.fromJson(e))
          .toList();
      return items;
    }catch(e){
      rethrow;
    }
  }
}