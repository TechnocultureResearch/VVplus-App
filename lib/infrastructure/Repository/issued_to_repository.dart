

import 'dart:convert';


import 'package:http/http.dart';
import 'package:vvplus_app/infrastructure/Models/issued_to_model.dart';

import '../../data_source/api/api_services.dart';

class IssuedToRepository{
  Client client = Client();

  Future<List<IssuedTo>> getData() async {
    try {
      final response = await client.get(Uri.parse(ApiService.getIssuedTonewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => IssuedTo.fromJson(e)).toList();
      return items;
    }
    catch (e){
      rethrow;
    }
  }
}