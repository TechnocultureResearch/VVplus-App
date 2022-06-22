import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/item_name_model.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Repository/item_name_repository.dart';


class ItemNameDropdownBloc {
  final itemNameDropdownRepository = ItemNameRepository();
  final itemNameStockReceiveDropdownGetData = BehaviorSubject<ItemNameModel>();
  final itemMaterialReqEntryDropdownGetData = BehaviorSubject<ItemNameModel>();
  final itemNameStatusStockIssueEntryDropdownGetData = BehaviorSubject<ItemNameModel>();
  final itemNamePhaseToPhaseDropdownGetData = BehaviorSubject<ItemNameModel>();
  // TODO: Phase to phase and branch to branch send item api need to be replaced here

  Future<List<ItemNameModel>> itemNameStockReceiveDropdowndata;
  Future<List<ItemNameModel>> itemMaterialReqEntryDropdownData;
  Future<List<ItemNameModel>> itemNameStockIssueEntryDropdownData;
  Future<List<ItemNameModel>> itemNamePhaseToPhaseDropdownData;

  Stream<ItemNameModel> get selectedItemStockReceiveState => itemNameStockReceiveDropdownGetData;
  void selectedItemStockReceiveStateEvent(ItemNameModel state) => itemNameStockReceiveDropdownGetData.add(state);

  Stream<ItemNameModel> get selectedStateitemName => itemNameStatusStockIssueEntryDropdownGetData;
  void selectedStateitemNameEvent(ItemNameModel state) => itemNameStatusStockIssueEntryDropdownGetData.add(state);

  Stream<ItemNameModel> get selecteditemMaterialReqEntryState => itemMaterialReqEntryDropdownGetData;
  void selecteditemMaterialReqEnrtyStateEvent(ItemNameModel state) => itemMaterialReqEntryDropdownGetData.add(state);

  Stream<ItemNameModel> get selecteditemPhaseToPhaseTransferState => itemNamePhaseToPhaseDropdownGetData;
  void selecteditemPhaseToPhaseTransferStateEvent(ItemNameModel state) => itemNamePhaseToPhaseDropdownGetData.add(state);

  ItemNameDropdownBloc() {
    itemNameStockReceiveDropdowndata = itemNameDropdownRepository.getItemStockReceiveEntryData();
    itemMaterialReqEntryDropdownData = itemNameDropdownRepository.getItemMaterialReqEntryData();
    itemNameStockIssueEntryDropdownData = itemNameDropdownRepository.getStockissueItemData();
    itemNamePhaseToPhaseDropdownData = itemNameDropdownRepository.getPhaseToPhaseTransferItemData();
  }

  void dispose() {
    itemNameStockReceiveDropdownGetData.close();
    itemMaterialReqEntryDropdownGetData.close();
    itemNameStatusStockIssueEntryDropdownGetData.close();
    itemNamePhaseToPhaseDropdownGetData.close();
  }
}