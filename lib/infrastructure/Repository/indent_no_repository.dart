
import 'dart:convert';

import 'package:http/http.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/indent_no_model.dart';

class IndentNoRepository{
  Client client = Client();

  Future<List<IndentNo>> getIndentNoBToBSendData() async{
    try{
  final response = await client.get(Uri.parse(ApiService.getIndentNoBToBSendnewURL));
  final items = (jsonDecode(response.body)as List)
  .map((e) => IndentNo.fromJson(e))
  .toList();
  return items;
    }catch(e) {
      rethrow;
    }
  }
}