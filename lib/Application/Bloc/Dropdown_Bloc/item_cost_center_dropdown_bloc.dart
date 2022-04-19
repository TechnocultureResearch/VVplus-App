import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Repository/item_cost_center_repository.dart';

class ItemCostCenterDropdownBloc {
  final itemCostCenterRepository = ItemCostCenterRepository();
  final itemCostCenterGetData = BehaviorSubject<ItemCostCenter>();
  
  Future<List<ItemCostCenter>> itemCostCenterData;
  Stream<ItemCostCenter> get selectedState => itemCostCenterGetData;
  void selectedStateEvent(ItemCostCenter state) => itemCostCenterGetData.add(state);

  ItemCostCenterDropdownBloc() {
    itemCostCenterData = itemCostCenterRepository.getData();
  }

  void dispose() {
    itemCostCenterGetData.close();
  }
}