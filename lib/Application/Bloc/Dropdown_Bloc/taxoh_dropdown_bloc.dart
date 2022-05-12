
import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/Tax_oh_model.dart';
import 'package:vvplus_app/infrastructure/Repository/tax_oh_repository.dart';

class TAXOHDropdownBloc{
  final taxOHDropdownRepository = TAXOHRepository();
  final taxOHDropdownGetData = BehaviorSubject<TAXOH>();
  final taxOHUnitCanclationDropdownGetData = BehaviorSubject<TAXOH>();

  Future<List<TAXOH>> taxOHDropdownData;
  Stream<TAXOH> get selectedTAXOHState => taxOHDropdownGetData;
  void selectedTAXOHStateEvent(TAXOH state) => taxOHDropdownGetData.add(state);

  Future<List<TAXOH>> taxOHUnitCancelationDropdownData;
  Stream<TAXOH> get selectedTAXOHUniCancelationState => taxOHUnitCanclationDropdownGetData;
  void selectedTAXOHUniCancelationStateEvent(TAXOH state) => taxOHUnitCanclationDropdownGetData.add(state);

  TAXOHDropdownBloc(){
    taxOHDropdownData = taxOHDropdownRepository.getTaxOH();
    taxOHUnitCancelationDropdownData= taxOHDropdownRepository.getTAXOHUnitCancelationData();
  }
  void dispose(){
    taxOHDropdownGetData.close();
    taxOHUnitCanclationDropdownGetData.close();
  }
}