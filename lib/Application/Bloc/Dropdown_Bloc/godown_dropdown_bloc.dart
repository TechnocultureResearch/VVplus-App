import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/godown_model.dart';
import 'package:vvplus_app/infrastructure/Repository/godown_repository.dart';

class GodownDropdownBloc{
  final godownDropdownRepository = GodownRepository();
  final godownDropdownGetdata = BehaviorSubject<Godown>();
  final godownPhaseToPhaseFromGetdata = BehaviorSubject<Godown>();

  Future<List<Godown>> godownDropDownData;
  Future<List<Godown>> godownPhaseToPhaseFromData;

  Stream<Godown> get selectedState => godownDropdownGetdata;
  void selectedStateEvent(Godown state)=> godownDropdownGetdata.add(state);

  Stream<Godown> get selectedPhaseToPhaseFromState => godownPhaseToPhaseFromGetdata;
  void selectedPhaseToPhaseFromStateEvent(Godown state) => godownPhaseToPhaseFromGetdata.add(state);

  GodownDropdownBloc(){
    godownDropDownData = godownDropdownRepository.getData();
    godownPhaseToPhaseFromData = godownDropdownRepository.getPhaseToPhaseFromGodownData();
  }
  void dispose(){
    godownDropdownGetdata.close();
  }
}
