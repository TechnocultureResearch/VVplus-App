import 'dart:async';
import 'dart:core';
import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/infrastructure/Repository/voucher_type_repository.dart';

class VoucherTypeDropdownBloc {
  final voucherTypeDropdownRepository = VoucherTypeRepository();
  final voucherTypeDropdownGetData = BehaviorSubject<VoucherType>();
  final voucherTypeStockIssueDropdownGetData = BehaviorSubject<VoucherType>();
  final voucherTypeChequeReceiveDropdownGetData = BehaviorSubject<VoucherType>();
  final voucherTypeExtraWorkEntryDropdownGetData = BehaviorSubject<VoucherType>();
  final voucherTypePhaseToPhaseDropdownGetData = BehaviorSubject<VoucherType>();

  Future<List<VoucherType>> voucherTypeDropdownData;
  Future<List<VoucherType>> voucherTypeStockIssueDropdownData;
  Future<List<VoucherType>> voucherTypeChequeReceiveDropdownData;
  Future<List<VoucherType>> voucherTypeExtraWorkEntryDropdownData;
  Future<List<VoucherType>> voucherTypePhaseToPhaseDropdownData;

  Stream<VoucherType> get selecteddState => voucherTypeStockIssueDropdownGetData;
  void selecteddStateEvent(VoucherType state) => voucherTypeStockIssueDropdownGetData.add(state);

  Stream<VoucherType> get selectedState => voucherTypeDropdownGetData;
  void selectedStateEvent(VoucherType state) => voucherTypeDropdownGetData.add(state);

  Stream<VoucherType> get selectedChequeReceiveState => voucherTypeChequeReceiveDropdownGetData;
  void selectedChequeReceiveStateEvent(VoucherType state) => voucherTypeChequeReceiveDropdownGetData.add(state);

  Stream<VoucherType> get selectedExtraEorkEntryState => voucherTypePhaseToPhaseDropdownGetData;
  void selectedExtraworkentryStateEvent(VoucherType state)  => voucherTypeExtraWorkEntryDropdownGetData.add(state);

  Stream<VoucherType> get selectedPhaseToPhaseState => voucherTypeExtraWorkEntryDropdownGetData;
  void selectedPhaseToPhaseStateEvent(VoucherType state) => voucherTypePhaseToPhaseDropdownGetData.add(state);

  VoucherTypeDropdownBloc() {
    voucherTypeDropdownData = voucherTypeDropdownRepository.getData();
    voucherTypeStockIssueDropdownData = voucherTypeDropdownRepository.getStockIssueVoucherData();
    voucherTypeChequeReceiveDropdownData = voucherTypeDropdownRepository.getChequeReceiveVoucherData();
    voucherTypeExtraWorkEntryDropdownData = voucherTypeDropdownRepository.getExtraworkEntryVoucherData();
    voucherTypePhaseToPhaseDropdownData = voucherTypeDropdownRepository.getPhaseToPhaseData();
  }

  void dispose() {
    voucherTypeDropdownGetData.close();
  }
}