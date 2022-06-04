import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/indent_selection_model.dart';
import 'package:vvplus_app/infrastructure/Repository/indent_selection_repository.dart';

class IndentSelectionDropdownBloc {
  final indentSelectionRepository = IndentSelectionRepositiry();
  final indentSelectionDropdownGetData = BehaviorSubject<IndentSelection>();
  final indentSelectionBtoBGetData = BehaviorSubject<IndentSelection>();
  final indentSelectionPlacePoGetData = BehaviorSubject<IndentSelection>();

  Future<List<IndentSelection>> indentSelectionDropdownData;
  Future<List<IndentSelection>> indentSelectionBtoBDropdownData;
  Future<List<IndentSelection>> indentSelectionPlacePoDropdownData;

  Stream<IndentSelection> get selectedIndentSelectionState =>
      indentSelectionDropdownGetData;
  void selectedIndentSelectionStateEvent(IndentSelection state) =>
      indentSelectionDropdownGetData.add(state);

  Stream<IndentSelection> get selectedIndentSelectionBtoBState =>
      indentSelectionBtoBGetData;
  void selectedIndentSelectionBtoBStateEvent(IndentSelection state) =>
      indentSelectionBtoBGetData.add(state);

  Stream<IndentSelection> get selectedIndentSelectionPlacePoState =>
      indentSelectionPlacePoGetData;
  void selectedIndentSelectionPlacePoStateEvent(IndentSelection state) =>
      indentSelectionPlacePoGetData.add(state);

  IndentSelectionDropdownBloc() {
    indentSelectionDropdownData =
        indentSelectionRepository.getIndentSelectionData();
    indentSelectionBtoBDropdownData =
        indentSelectionRepository.getBranchSendIndentSelectionData();
    indentSelectionPlacePoDropdownData =
        indentSelectionRepository.getPlacePoIndentSelectionData();
  }
  void dispose() {
    indentSelectionDropdownGetData.close();
    indentSelectionBtoBGetData.close();
    indentSelectionPlacePoGetData.close();
  }
}
