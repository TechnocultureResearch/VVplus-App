import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Repository/indentor_name_repository.dart';

class IndentorNameDropdownBloc {
  final indentorNameDropdownRepository = IndentorNameRepository();
  final indentorNameDropdownGetData = BehaviorSubject<IndentorName>();
  final indentorNameMaterialReqEntryDropdowngetData = BehaviorSubject<IndentorName>();

  Future<List<IndentorName>> indentorNameDropdownData;
  Future<List<IndentorName>> indentorNameMaterialReqEntryDropdownData;

  Stream<IndentorName> get selectedState => indentorNameDropdownGetData;
  BehaviorSubject<IndentorName> get selectedIndentorNameMaterialReqEntryState => indentorNameMaterialReqEntryDropdowngetData;

  void selectedStateEvent(IndentorName state) => indentorNameDropdownGetData.add(state);
  void selectedIndentorNameMaterialReqEntryStateEvent(IndentorName state) => indentorNameMaterialReqEntryDropdowngetData.add(state);

  IndentorNameDropdownBloc() {
    //indentorNameDropdownData = indentorNameDropdownRepository.getData();
  indentorNameDropdownData = indentorNameDropdownRepository.geIndenterMaterialReqEntrytData();
  }

  void dispose() {
    indentorNameDropdownGetData.close();
    indentorNameDropdownGetData.close();
  }
}
