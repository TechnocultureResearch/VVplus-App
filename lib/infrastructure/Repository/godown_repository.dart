import 'dart:convert';

import 'package:http/http.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/godown_model.dart';

class GodownRepository{
  Client client = Client();

  Future<List<Godown>> getData() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getGoDownnewURL));
      final items = (jsonDecode(response.body)as List)
      .map((e) => Godown.fromJson(e)).toList();
      return items;
    }
    catch(e){
      rethrow;
    }
  }
}