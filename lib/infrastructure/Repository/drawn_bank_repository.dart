
import 'dart:convert';

import 'package:http/http.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/drawn_bank_model.dart';

class DrawnBankRepository{
  Client client = Client();
  
  Future<List<DrawnBank>> getDrawnBank() async {
    try {
      final response = await client.get(Uri.parse(ApiService.getDrawnBanknewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => DrawnBank.fromJson(e))
          .toList();
      return items;
    }
    catch(e) {
      rethrow;
    }
  }
}