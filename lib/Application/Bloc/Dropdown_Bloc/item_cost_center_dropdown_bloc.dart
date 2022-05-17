import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Repository/item_cost_center_repository.dart';

class ItemCostCenterDropdownBloc {
  final itemCostCenterRepository = ItemCostCenterRepository();
  final itemCostCenterGetData = BehaviorSubject<ItemCostCenter>();
  final itemCostCenterStockIssueEntryGetData = BehaviorSubject<ItemCostCenter>();
  final costCenterDailyManpowerGetData = BehaviorSubject<ItemCostCenter>();
  final fromCostCenterPhaseToPhaseTransferGetData = BehaviorSubject<ItemCostCenter>();
  final toCostCenterPhaseToPhaseTransferGetData = BehaviorSubject<ItemCostCenter>();
  final fromCostCenterBranchToBranchSendGetData = BehaviorSubject<ItemCostCenter>();
  
  Future<List<ItemCostCenter>> itemCostCenterData;
  Future<List<ItemCostCenter>> itemCostCenterStockIssueEntryData;
  Future<List<ItemCostCenter>> costCenterDailyManpowerData;
  Future<List<ItemCostCenter>> fromCostCenterPhaseToPhaseData;
  Future<List<ItemCostCenter>> toCostCenterPhaseToPhaseData;
  Future<List<ItemCostCenter>> fromcostCenterBranchToBranchSendData;

  Stream<ItemCostCenter> get selectedCostCenterState => itemCostCenterStockIssueEntryGetData;
  void selectedCostCenterStateEvent(ItemCostCenter state) => itemCostCenterStockIssueEntryGetData.add(state);

  Stream<ItemCostCenter> get selectedState => itemCostCenterGetData;
  void selectedStateEvent(ItemCostCenter state) => itemCostCenterGetData.add(state);

  Stream<ItemCostCenter> get selectedCostCenterDailyManpowerState => costCenterDailyManpowerGetData;
  void selectedCostCenterDailyManpowerStateEvent(ItemCostCenter state) => costCenterDailyManpowerGetData.add(state);

  Stream<ItemCostCenter> get selectedFromCostCenterPhaseToPhaseState => fromCostCenterPhaseToPhaseTransferGetData;
  void selectedFromCostCenterPhaseToPhaseStateEvent(ItemCostCenter state) => fromCostCenterPhaseToPhaseTransferGetData.add(state);

  Stream<ItemCostCenter> get selectedToCostCenterPhaseToPhaseState => toCostCenterPhaseToPhaseTransferGetData;
  void selectedToCOstCenterPhaseToPhaseStateEvent(ItemCostCenter state) => toCostCenterPhaseToPhaseTransferGetData.add(state);

  Stream<ItemCostCenter> get selectedFromBranchToBranchSendState => fromCostCenterBranchToBranchSendGetData;
  void selectedFromBranchToBranchSendStateEvent(ItemCostCenter state) => fromCostCenterBranchToBranchSendGetData.add(state);

  ItemCostCenterDropdownBloc() {
    itemCostCenterData = itemCostCenterRepository.getData();
    itemCostCenterStockIssueEntryData = itemCostCenterRepository.getStockIssueEntryCostCenterData();
    costCenterDailyManpowerData = itemCostCenterRepository.getDailyManpowerCostCenterData();
    fromCostCenterPhaseToPhaseData = itemCostCenterRepository.getPhaseToPhaseFromCostCenterData();
    toCostCenterPhaseToPhaseData = itemCostCenterRepository.getPhaseToPhaseToCostCenterData();
    fromcostCenterBranchToBranchSendData = itemCostCenterRepository.getBToBsendFromCostCenterData();
  }

  void dispose() {
    itemCostCenterGetData.close();
    itemCostCenterStockIssueEntryGetData.close();
    costCenterDailyManpowerGetData.close();
    toCostCenterPhaseToPhaseTransferGetData.close();
    fromCostCenterBranchToBranchSendGetData.close();
  }
}