import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/godown_model.dart';
import 'package:vvplus_app/infrastructure/Repository/godown_repository.dart';

class GodownDropdownBloc{
  final godownDropdownRepository = GodownRepository();
  final godownDropdownGetdata = BehaviorSubject<Godown>();
  final godownPhaseToPhaseFromGetdata = BehaviorSubject<Godown>();
  final godownPhaseToPhaseToGetData = BehaviorSubject<Godown>();
  final godownBranchToBranchSendFromGetData = BehaviorSubject<Godown>();

  Future<List<Godown>> godownDropDownData;
  Future<List<Godown>> godownPhaseToPhaseFromData;
  Future<List<Godown>> godownPhaseToPhaseToData;
  Future<List<Godown>> godownBranchToBranchSendFromData;

  Stream<Godown> get selectedState => godownDropdownGetdata;
  void selectedStateEvent(Godown state)=> godownDropdownGetdata.add(state);

  Stream<Godown> get selectedPhaseToPhaseFromState => godownPhaseToPhaseFromGetdata;
  void selectedPhaseToPhaseFromStateEvent(Godown state) => godownPhaseToPhaseFromGetdata.add(state);

  Stream<Godown> get selectedPhaseToPhaseToState => godownPhaseToPhaseFromGetdata;
  void selectedPhaseToPhaseToStateEvent(Godown state) => godownPhaseToPhaseFromGetdata.add(state);

  Stream<Godown> get selectedBranchToBranchSendFromState => godownBranchToBranchSendFromGetData;
  void selectedBranchToBranchSendFromStateEvent(Godown state) => godownBranchToBranchSendFromGetData.add(state);

  GodownDropdownBloc(){
    godownDropDownData = godownDropdownRepository.getData();
    godownPhaseToPhaseFromData = godownDropdownRepository.getPhaseToPhaseFromGodownData();
    godownPhaseToPhaseToData = godownDropdownRepository.getPhaseToPhaseToGodownData();
    godownBranchToBranchSendFromData = godownDropdownRepository.getBranchToBranchSendFromGodownData();
  }
  void dispose(){
    godownDropdownGetdata.close();
    godownPhaseToPhaseFromGetdata.close();
    godownPhaseToPhaseToGetData.close();
    godownBranchToBranchSendFromGetData.close();
  }
}
