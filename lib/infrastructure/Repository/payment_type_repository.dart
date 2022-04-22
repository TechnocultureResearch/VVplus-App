
import 'dart:convert';

import 'package:http/http.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/payment_type_model.dart';

class PaymentTypeRepository{
  Client client = Client();

  Future<List<PaymentType>> getPaymentTypeData() async{
    try {
     final response = await client.get(Uri.parse(ApiService.getChequePaymentTypenewURL));
     final items = (jsonDecode(response.body) as List)
     .map((e) => PaymentType.fromJson(e))
     .toList();
     return items;
    } catch (e) {
      rethrow;
    }
    }
  }
