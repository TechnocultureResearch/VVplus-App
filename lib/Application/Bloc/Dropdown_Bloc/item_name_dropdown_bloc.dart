import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/item_name_model.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Repository/item_name_repository.dart';

class ItemNameDropdownBloc {
  final itemNameDropdownRepository = ItemNameRepository();
  final itemMaterialReqEntryDropdownGetData = BehaviorSubject<ItemName>();

  Future<List<ItemName>> itemMaterialReqEntryDropdownData;
  Stream<ItemName> get selecteditemMaterialReqEnrtyState => itemMaterialReqEntryDropdownGetData;
  void selecteditemMaterialReqEnrtyStateEvent(ItemName state) => itemMaterialReqEntryDropdownGetData.add(state);

  ItemNameDropdownBloc() {
    itemMaterialReqEntryDropdownData = itemNameDropdownRepository.getItemNameMaterialReqEntryData();
  }

  void dispose() {
    itemMaterialReqEntryDropdownGetData.close();
  }
}