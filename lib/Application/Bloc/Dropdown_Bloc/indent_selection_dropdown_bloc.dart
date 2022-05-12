

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/indent_selection_model.dart';
import 'package:vvplus_app/infrastructure/Repository/indent_selection_repository.dart';

class IndentSelectionDropdownBloc {
  final indentSelectionRepository = IndentSelectionRepositiry();
  final indentSelectionDropdownGetData = BehaviorSubject<IndentSelection>();

  Future<List<IndentSelection>> indentSelectionDropdownData;
  Stream<IndentSelection> get selectedIndentSelectionState => indentSelectionDropdownGetData;
  void selectedIndentSelectionStateEvent(IndentSelection state) => indentSelectionDropdownGetData.add(state);

  IndentSelectionDropdownBloc() {
    indentSelectionDropdownData = indentSelectionRepository.getIndentSelectionData();
  }
  void dispose() {
    indentSelectionDropdownGetData.close();
  }
}