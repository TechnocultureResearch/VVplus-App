

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/supplier_model.dart';
import 'package:vvplus_app/infrastructure/Repository/supplier_repository.dart';

class SupplierDropdownBloc{
 final supplierDropdownRepository = SupplierRepository();
 final supplierDropdownGetData = BehaviorSubject<Supplier>();

 Future<List<Supplier>> supplierDropdownData;

 Stream<Supplier> get selectedSupplierState => supplierDropdownGetData;
 void selectedSupplierStateEvent(Supplier state) => supplierDropdownGetData.add(state);

SupplierDropdownBloc(){
  supplierDropdownData = supplierDropdownRepository.getSupplierData();
}
void dispose(){
  supplierDropdownGetData.close();
}
}