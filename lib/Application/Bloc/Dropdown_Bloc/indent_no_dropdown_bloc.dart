

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/indent_no_model.dart';
import 'package:vvplus_app/infrastructure/Repository/indent_no_repository.dart';

class IndentNoDropdownBloc{
 final indentNoDropdownRepository = IndentNoRepository();
 final indentNoDropdownGetData = BehaviorSubject<IndentNo>();
final indentNoMaterialRequestApprovDropdownGetData = BehaviorSubject<IndentNo>();

 Future<List<IndentNo>> indentNoDropdownData;
 Future<List<IndentNo>> indentNoMaterialRequestApproveDropdowndata;

 Stream<IndentNo> get selectedIndentNoState => indentNoDropdownGetData;
 void selectedIndentNoStateEvent(IndentNo state) => indentNoDropdownGetData.add(state);

 Stream<IndentNo> get selectedIndentNoMaterialReqApprovState => indentNoMaterialRequestApprovDropdownGetData;
 void selectedIndentNoMaterialReqApprovStateEvent(IndentNo state) => indentNoMaterialRequestApprovDropdownGetData.add(state);

 IndentNoDropdownBloc(){
   indentNoDropdownData = indentNoDropdownRepository.getIndentNoBToBSendData();
   indentNoMaterialRequestApproveDropdowndata = indentNoDropdownRepository.getIndentNoMaterialReqApprovData();
 }
 void dispose(){
   indentNoDropdownGetData.close();
   indentNoMaterialRequestApprovDropdownGetData.close();
 }
}