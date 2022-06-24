import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/item_current_status_model.dart';
import 'dart:async';

import 'package:vvplus_app/infrastructure/Repository/item_current_status_repository.dart';

class ItemCurrentStatusDropdownBloc {
  final itemCurrentStatusDropdownRepository = ItemCurrentStatusRepository();
  final itemCurrentStatusDropdownGetData = BehaviorSubject<ItemCurrentStatus>();

  final itemCurrentStatusMaterialRequestEntryDropdownData = BehaviorSubject<ItemCurrentStatus>();


  Future<List<ItemCurrentStatus>> itemCurrentStatusDropdowndata;
  Future<List<ItemCurrentStatus>> itemCurrentStatusStockIssueEntryDropdownData;
  Future<List<ItemCurrentStatus>> itemCurrenStatusPhaseToPhaseDropdownData;

  Stream<ItemCurrentStatus> get selectedState => itemCurrentStatusDropdownGetData;
  void selectedStateEvent(ItemCurrentStatus state) => itemCurrentStatusDropdownGetData.add(state);

  ItemCurrentStatusDropdownBloc() {
    itemCurrentStatusDropdowndata = itemCurrentStatusDropdownRepository.getData();
   // itemCurrentStatusStockIssueEntryDropdownData = itemCurrentStatusDropdownRepository.getStockissueItemData();
   //  itemCurrenStatusPhaseToPhaseDropdownData = itemCurrentStatusDropdownRepository.getPhaseToPhaseTransferItemData();
  }

  void dispose() {
    itemCurrentStatusDropdownGetData.close();
    //itemCurrentStatusStockIssueEntryDropdownGetData.close();
  }
}