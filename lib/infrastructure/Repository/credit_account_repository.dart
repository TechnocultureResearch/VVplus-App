

import 'dart:convert';

import 'package:http/http.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/credit_acc_model.dart';

class CreditAccountRepository{
  Client client = Client();
  
  Future<List<CreditAccount>> getCreditAccount() async{
   try{
     final response = await client.get(Uri.parse(ApiService.getCreditAccontnewURL));
     final items = (jsonDecode(response.body) as List)
     .map((e) => CreditAccount.fromJson(e))
     .toList();
     return items;
   }
   catch(e){
     rethrow;
   }
  }
}