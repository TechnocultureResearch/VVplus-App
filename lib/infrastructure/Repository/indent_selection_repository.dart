import 'dart:convert';

import 'package:http/http.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';

import '../Models/indent_selection_model.dart';

class IndentSelectionRepositiry {
  Client client = Client();

  Future<List<IndentSelection>> getIndentSelectionData() async {
    try {
      final response = await client.get(
          Uri.parse(ApiService.getMaterialReqApprovalIndentSelectionnewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => IndentSelection.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<IndentSelection>> getBranchSendIndentSelectionData() async {
    try {
      final response = await client
          .get(Uri.parse(ApiService.getIndentSelectionBToBSendnewURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => IndentSelection.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
}
