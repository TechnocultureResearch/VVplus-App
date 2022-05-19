

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/indent_no_model.dart';
import 'package:vvplus_app/infrastructure/Repository/indent_no_repository.dart';

class IndentNoDropdownBloc{
 final indentNoDropdownRepository = IndentNoRepository();
 final indentNoDropdownGetData = BehaviorSubject<IndentNo>();

 Future<List<IndentNo>> indentNoDropdownData;
 Stream<IndentNo> get selectedIndentNoState => indentNoDropdownGetData;
 void selectedIndentNoStateEvent(IndentNo state) => indentNoDropdownGetData.add(state);

 IndentNoDropdownBloc(){
   indentNoDropdownData = indentNoDropdownRepository.getIndentNoBToBSendData();
 }
 void dispose(){
   indentNoDropdownGetData.close();
 }
}