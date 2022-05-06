

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/issued_to_model.dart';
import 'package:vvplus_app/infrastructure/Repository/issued_to_repository.dart';

import '../../../infrastructure/Models/received_by_model.dart';
import '../../../infrastructure/Repository/received_by_repository.dart';

class IssuedToDropdownBloc{
  final issuedToDropdownRepository = IssuedToRepository();
  final issuedToDropDownGetData = BehaviorSubject<IssuedTo>();
  final issuedToPhaseToPhaseDropDownGetData = BehaviorSubject<IssuedTo>();

  Future<List<IssuedTo>> issuedToDropDownData;
  Future<List<IssuedTo>> issuedToPhaseToPhaseDropDownData;

  Stream<IssuedTo> get selectedState => issuedToDropDownGetData;
  void selectedStateEvent(IssuedTo state)=> issuedToDropDownGetData.add(state);

  Stream<IssuedTo> get selectedPhaseToPhaseState => issuedToPhaseToPhaseDropDownGetData;
  void selectedPhaseToPhaseStateEvent(IssuedTo state) => issuedToPhaseToPhaseDropDownGetData.add(state);

  IssuedToDropdownBloc(){
    issuedToDropDownData = issuedToDropdownRepository.getData();
    issuedToPhaseToPhaseDropDownData = issuedToDropdownRepository.getPhaseToPhaseData();
  }
  void dispose(){
    issuedToDropDownGetData.close();
  }
}