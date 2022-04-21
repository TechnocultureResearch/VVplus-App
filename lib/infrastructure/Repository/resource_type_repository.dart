
import 'dart:convert';
import 'package:vvplus_app/infrastructure/Models/resource_type_model.dart';
import 'package:http/http.dart' show Client;
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'dart:async';


class ResourceTypeRepository{
  Client client = Client();

  Future<List<ResourceType>> getResourceTypeData() async{
    try{
      final response = await client.get(Uri.parse(ApiService.getDailyManpowerResourceTypenewURL));
      final items = (jsonDecode(response.body) as List)
      .map((e) => ResourceType.fromJson(e))
      .toList();
      return items;
    }catch (e){
      rethrow;
    }
  }
}