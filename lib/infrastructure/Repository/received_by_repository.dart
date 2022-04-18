

import 'dart:convert';

import 'package:http/http.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';

import '../Models/received_by_model.dart';

class ReceivedByRepository{
Client client = Client();

Future<List<ReceivedBy>> getData() async {
  try {
      final response = await client.get(Uri.parse(ApiService.getReceivedBynewUrl));
      final items = (jsonDecode(response.body) as List)
      .map((e) => ReceivedBy.fromJson(e)).toList();
      return items;
      }
      catch (e){
    rethrow;
      }
}
}