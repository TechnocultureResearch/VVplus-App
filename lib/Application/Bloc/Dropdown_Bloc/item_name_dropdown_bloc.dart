import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/item_name_model.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Repository/item_name_repository.dart';

class ItemNameDropdownBloc {
  final itemNameDropdownRepository = ItemNameRepository();
  final itemMaterialReqEntryDropdownGetData = BehaviorSubject<ItemName>();
  final itemNameStatusStockIssueEntryDropdownGetData = BehaviorSubject<ItemName>();

  Future<List<ItemName>> itemMaterialReqEntryDropdownData;
  Future<List<ItemName>> itemNameStockIssueEntryDropdownData;

  Stream<ItemName> get selectedStateitemName => itemNameStatusStockIssueEntryDropdownGetData;
  void selectedStateitemNameEvent(ItemName state) => itemNameStatusStockIssueEntryDropdownGetData.add(state);

  Stream<ItemName> get selecteditemMaterialReqEnrtyState => itemMaterialReqEntryDropdownGetData;
  void selecteditemMaterialReqEnrtyStateEvent(ItemName state) => itemMaterialReqEntryDropdownGetData.add(state);

  ItemNameDropdownBloc() {
    itemMaterialReqEntryDropdownData = itemNameDropdownRepository.getItemNameMaterialReqEntryData();
    itemNameStockIssueEntryDropdownData = itemNameDropdownRepository.getStockissueItemData();
  }

  void dispose() {
    itemMaterialReqEntryDropdownGetData.close();
    itemNameStatusStockIssueEntryDropdownGetData.close();
  }
}