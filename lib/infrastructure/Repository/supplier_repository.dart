
import 'dart:convert';

import 'package:http/http.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/supplier_model.dart';

class SupplierRepository{
  
  Client client = Client();
  Future<List<Supplier>> getSupplierData() async {
    try {
      final response = await client.get(
          Uri.parse(ApiService.getSuppliernewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => Supplier.fromJson(e))
          .toList();
      return items;
    }catch(e){
      rethrow;
    }
  }

  Future<List<Supplier>> getSupplierBToBReceiveData() async {
    try{
      final response = await client.get(Uri.parse(ApiService.getSupplierBToBReceivenewURL));
      final items = (jsonDecode(response.body)as List)
      .map((e) => Supplier.fromJson(e))
      .toList();
      return items;
    }catch(e){
    }
  }
}