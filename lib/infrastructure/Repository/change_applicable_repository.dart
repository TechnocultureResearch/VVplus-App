import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'dart:async';

import 'package:vvplus_app/infrastructure/Models/change_applicable_model.dart';

class ChangeApplicableRepository {
  Client client = Client();

  Future<List<ChangeApplicable>> getData() async {
    try {
      final response =
          await client.get(Uri.parse(ApiService.getChangeApplicableURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => ChangeApplicable.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ChangeApplicable>> createUser(
      String strSubCode, String strName) async {
    final response =
        await http.post(Uri.parse(ApiService.getChangeApplicableURL), body: {
      "StrSubCode": strSubCode,
      "StrName": strName,
    });

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return changeApplicableFromJson(responseString);
    } else {
      return null;
    }
  }
}
