import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/godown_model.dart';
import 'package:vvplus_app/infrastructure/Repository/godown_repository.dart';

class GodownDropdownBloc{
  final godownDropdownRepository = GodownRepository();
  final godownDropdownGetdata = BehaviorSubject<Godown>();

  Future<List<Godown>> godownDropDownData;
  Stream<Godown> get selectedState => godownDropdownGetdata;
  void selectedStateEvent(Godown state)=> godownDropdownGetdata.add(state);
  GodownDropdownBloc(){
    godownDropDownData = godownDropdownRepository.getData();
  }
  void dispose(){
    godownDropdownGetdata.close();
  }
}
