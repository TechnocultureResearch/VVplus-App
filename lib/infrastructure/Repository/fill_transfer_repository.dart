


import 'dart:convert';

import 'package:http/http.dart';
import 'package:vvplus_app/infrastructure/Models/fill_transfer_model.dart';

import '../../data_source/api/api_services.dart';
import '../Models/stage_model.dart';

class FillTransferRepository{
  Client client = Client();
  Future<List<FillTransferModel>> getFillTransferData() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getFillTransfernewURL));
      final items = (jsonDecode(response.body)as List)
          .map((e) => FillTransferModel.fromJson(e))
          .toList();
      return items;
    }catch(e){
      rethrow;
    }
  }
}