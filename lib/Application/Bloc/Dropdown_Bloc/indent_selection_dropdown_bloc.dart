import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/indent_selection_model.dart';
import 'package:vvplus_app/infrastructure/Repository/indent_selection_repository.dart';

class IndentSelectionDropdownBloc {
  final indentSelectionRepository = IndentSelectionRepositiry();
  final indentSelectionDropdownGetData = BehaviorSubject<IndentSelection>();
  final indentSelectionBtoBGetData = BehaviorSubject<IndentSelection>();

  Future<List<IndentSelection>> indentSelectionDropdownData;
  Future<List<IndentSelection>> indentSelectionBtoBDropdownData;

  Stream<IndentSelection> get selectedIndentSelectionState =>
      indentSelectionDropdownGetData;
  void selectedIndentSelectionStateEvent(IndentSelection state) =>
      indentSelectionDropdownGetData.add(state);

  Stream<IndentSelection> get selectedIndentSelectionBtoBState =>
      indentSelectionBtoBGetData;
  void selectedIndentSelectionBtoBStateEvent(IndentSelection state) =>
      indentSelectionBtoBGetData.add(state);

  IndentSelectionDropdownBloc() {
    indentSelectionDropdownData =
        indentSelectionRepository.getIndentSelectionData();
    indentSelectionBtoBDropdownData =
        indentSelectionRepository.getBranchSendIndentSelectionData();
  }
  void dispose() {
    indentSelectionDropdownGetData.close();
    indentSelectionBtoBGetData.close();
  }
}
