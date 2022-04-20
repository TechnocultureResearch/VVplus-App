import 'dart:async';
import 'dart:core';
import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/infrastructure/Repository/voucher_type_repository.dart';

class VoucherTypeDropdownBloc {
  final voucherTypeDropdownRepository = VoucherTypeRepository();
  final voucherTypeDropdownGetData = BehaviorSubject<VoucherType>();
  final voucherTypeStockIssueDropdownGetData = BehaviorSubject<VoucherType>();

  Future<List<VoucherType>> voucherTypeDropdownData;
  Future<List<VoucherType>> voucherTypeStockIssueDropdownData;

  Stream<VoucherType> get selecteddState => voucherTypeStockIssueDropdownGetData;
  void selecteddStateEvent(VoucherType state) => voucherTypeStockIssueDropdownGetData.add(state);

  Stream<VoucherType> get selectedState => voucherTypeDropdownGetData;
  void selectedStateEvent(VoucherType state) => voucherTypeDropdownGetData.add(state);

  VoucherTypeDropdownBloc() {
    voucherTypeDropdownData = voucherTypeDropdownRepository.getData();
    voucherTypeStockIssueDropdownData = voucherTypeDropdownRepository.getStockIssueVoucherData();
  }

  void dispose() {
    voucherTypeDropdownGetData.close();
  }
}