import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/supplier_model.dart';
import 'package:vvplus_app/infrastructure/Repository/supplier_repository.dart';

class SupplierDropdownBloc {
  final supplierDropdownRepository = SupplierRepository();
  final supplierDropdownGetData = BehaviorSubject<Supplier>();
  final supplierBToBReceiveDropdownGetData = BehaviorSubject<Supplier>();
  final supplierGoodReceiptDropdownGetData = BehaviorSubject<Supplier>();

  Future<List<Supplier>> supplierDropdownData;
  Future<List<Supplier>> supplierBToBReceiveDropdownData;
  Future<List<Supplier>> supplierGoodReceiptDropdownData;

  Stream<Supplier> get selectedSupplierState => supplierDropdownGetData;
  void selectedSupplierStateEvent(Supplier state) =>
      supplierDropdownGetData.add(state);

  Stream<Supplier> get selectedSupplierBToBReceiveState =>
      supplierBToBReceiveDropdownGetData;
  void selectedSupplierBToBReceiveStateEvent(Supplier state) =>
      supplierBToBReceiveDropdownGetData.add(state);

  Stream<Supplier> get selectedSupplierGoodReceiptState =>
      supplierGoodReceiptDropdownGetData;
  void selectedSupplierGoodReceiptStateEvent(Supplier state) =>
      supplierGoodReceiptDropdownGetData.add(state);

  SupplierDropdownBloc() {
    supplierDropdownData = supplierDropdownRepository.getSupplierData();
    supplierBToBReceiveDropdownData =
        supplierDropdownRepository.getSupplierBToBReceiveData();
    supplierGoodReceiptDropdownData =
        supplierDropdownRepository.getSupplierGoodReceiptData();
  }
  void dispose() {
    supplierDropdownGetData.close();
    supplierBToBReceiveDropdownGetData.close();
    supplierGoodReceiptDropdownGetData.close();
  }
}
