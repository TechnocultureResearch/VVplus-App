import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/item_current_status_model.dart';
import 'dart:async';

import 'package:vvplus_app/infrastructure/Repository/item_current_status_repository.dart';

class ItemCurrentStatusDropdownBloc {
  final itemCurrentStatusDropdownRepository = ItemCurrentStatusRepository();
  final itemCurrentStatusDropdownGetData = BehaviorSubject<ItemCurrentStatus>();
  final itemCurrentStatusStockIssueEntryDropdownGetData = BehaviorSubject<ItemCurrentStatus>();

  Future<List<ItemCurrentStatus>> itemCurrentStatusDropdowndata;
  Future<List<ItemCurrentStatus>> itemCurrentStatusStockIssueEntryDropdownData;

  Stream<ItemCurrentStatus> get selectedStateitemCurrentStatus => itemCurrentStatusStockIssueEntryDropdownGetData;
  void selectedStateitemCurrentStatusEvent(ItemCurrentStatus state) => itemCurrentStatusStockIssueEntryDropdownGetData.add(state);

  Stream<ItemCurrentStatus> get selectedState => itemCurrentStatusDropdownGetData;
  void selectedStateEvent(ItemCurrentStatus state) => itemCurrentStatusDropdownGetData.add(state);

  ItemCurrentStatusDropdownBloc() {
    itemCurrentStatusDropdowndata = itemCurrentStatusDropdownRepository.getData();
    itemCurrentStatusStockIssueEntryDropdownData = itemCurrentStatusDropdownRepository.getStockissueItemData();
  }

  void dispose() {
    itemCurrentStatusDropdownGetData.close();
    itemCurrentStatusStockIssueEntryDropdownGetData.close();
  }
}