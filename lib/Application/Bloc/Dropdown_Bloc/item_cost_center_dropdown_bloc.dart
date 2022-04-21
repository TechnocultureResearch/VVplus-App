import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Repository/item_cost_center_repository.dart';

class ItemCostCenterDropdownBloc {
  final itemCostCenterRepository = ItemCostCenterRepository();
  final itemCostCenterGetData = BehaviorSubject<ItemCostCenter>();
  final itemCostCenterStockIssueEntryGetData = BehaviorSubject<ItemCostCenter>();
  final costCenterDailyManpowerGetData = BehaviorSubject<ItemCostCenter>();
  
  Future<List<ItemCostCenter>> itemCostCenterData;
  Future<List<ItemCostCenter>> itemCostCenterStockIssueEntryData;
  Future<List<ItemCostCenter>> costCenterDailyManpowerData;

  Stream<ItemCostCenter> get selectedCostCenterState => itemCostCenterStockIssueEntryGetData;
  void selectedCostCenterStateEvent(ItemCostCenter state) => itemCostCenterStockIssueEntryGetData.add(state);

  Stream<ItemCostCenter> get selectedState => itemCostCenterGetData;
  void selectedStateEvent(ItemCostCenter state) => itemCostCenterGetData.add(state);

  Stream<ItemCostCenter> get selectedCostCenterDailyManpowerState => costCenterDailyManpowerGetData;
  void selectedCostCenterDailyManpowerStateEvent(ItemCostCenter state) => costCenterDailyManpowerGetData.add(state);

  ItemCostCenterDropdownBloc() {
    itemCostCenterData = itemCostCenterRepository.getData();
    itemCostCenterStockIssueEntryData = itemCostCenterRepository.getStockIssueEntryCostCenterData();
    costCenterDailyManpowerData = itemCostCenterRepository.getDailyManpowerCostCenterData();
  }

  void dispose() {
    itemCostCenterGetData.close();
    itemCostCenterStockIssueEntryGetData.close();
    costCenterDailyManpowerGetData.close();
  }
}