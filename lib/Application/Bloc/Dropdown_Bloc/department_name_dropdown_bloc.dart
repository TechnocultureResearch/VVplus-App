import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/department_name_model.dart';
import 'package:vvplus_app/infrastructure/Repository/department_name_repository.dart';
import 'dart:async';

class DepartmentNameDropdownBloc {
  final departmentNameRepository = DepartmentNameRepository();
  final departmentNameGetData = BehaviorSubject<DepartmentName>();
  final departmentMaterialReqEntryGetData = BehaviorSubject<DepartmentName>();

  Future<List<DepartmentName>> departmentNameData;
  Future<List<DepartmentName>> departmentMaterialReqEntryData;

  Stream<DepartmentName> get selectedState => departmentNameGetData;
  void selectedStateEvent(DepartmentName state) => departmentNameGetData.add(state);

  Stream<DepartmentName> get selectedDepartmentMaterialReqEntryState => departmentMaterialReqEntryGetData;
void selectedDepartmentMaterialReqEntryStateEvent(DepartmentName state) => departmentMaterialReqEntryGetData.add(state);

  DepartmentNameDropdownBloc() {
    departmentNameData = departmentNameRepository.getData();
    departmentMaterialReqEntryData = departmentNameRepository.getDepartmentMaterialReqEntryData();
  }

  void dispose() {
    departmentNameGetData.close();
    departmentMaterialReqEntryGetData.close();
  }
}