import 'dart:convert';

import 'package:http/http.dart';

import '../../data_source/api/api_services.dart';
import '../Models/stage_model.dart';

class StageRepository {
  Client client = Client();
  Future<List<Stage>> getStageData() async {
    try {
      final response =
          await client.get(Uri.parse(ApiService.getReceivedBynewUrl));
      //final response = await client.get(Uri.parse(ApiService.getStagenewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => Stage.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
}
