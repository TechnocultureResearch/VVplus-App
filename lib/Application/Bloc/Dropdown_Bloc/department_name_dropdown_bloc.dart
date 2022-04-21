import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/department_name_model.dart';
import 'package:vvplus_app/infrastructure/Repository/department_name_repository.dart';
import 'dart:async';

class DepartmentNameDropdownBloc {
  final departmentNameRepository = DepartmentNameRepository();
  final departmentNameGetData = BehaviorSubject<DepartmentName>();

  Future<List<DepartmentName>> departmentNameData;

  Stream<DepartmentName> get selectedState => departmentNameGetData;
  void selectedStateEvent(DepartmentName state) => departmentNameGetData.add(state);

  DepartmentNameDropdownBloc() {
    departmentNameData = departmentNameRepository.getData();
  }

  void dispose() {
    departmentNameGetData.close();
  }
}