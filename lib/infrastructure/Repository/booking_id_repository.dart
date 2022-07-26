import 'dart:convert';

import 'package:http/http.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/booking_id_model.dart';

class BookingIdRepository {
  Client client = Client();

  Future<List<BookingIdModel>> getBooingIdData() async {
    try {
      final response =
          await client.get(Uri.parse(ApiService.getBookingIdnewUrl));
      final items = (jsonDecode(response.body) as List)
          .map((e) => BookingIdModel.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BookingIdModel>> getUnitCancellationBooingIdData() async {
    try {
      final response =
          await client.get(Uri.parse(ApiService.getUnitCancelBookingIdnewUrl));
      final items = (jsonDecode(response.body) as List)
          .map((e) => BookingIdModel.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
}
