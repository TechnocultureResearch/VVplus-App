import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Repository/indentor_name_repository.dart';

class IndentorNameDropdownBloc {
  final indentorNameDropdownRepository = IndentorNameRepository();
  final indentorNameDropdownGetData = BehaviorSubject<IndentorName>();

  Future<List<IndentorName>> indentorNameDropdownData;
  Stream<IndentorName> get selectedState => indentorNameDropdownGetData;
  void selectedStateEvent(IndentorName state) =>
      indentorNameDropdownGetData.add(state);

  IndentorNameDropdownBloc() {
    //indentorNameDropdownData = indentorNameDropdownRepository.getData();
  }

  void dispose() {
    indentorNameDropdownGetData.close();
  }
}
