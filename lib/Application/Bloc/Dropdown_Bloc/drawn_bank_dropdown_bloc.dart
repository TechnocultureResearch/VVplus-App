

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/drawn_bank_model.dart';
import 'package:vvplus_app/infrastructure/Repository/drawn_bank_repository.dart';

class DrawnBankDropdownBloc{
  final drawnBankDropdownRepository = DrawnBankRepository();
  final drawnBankDropdownGetData = BehaviorSubject<DrawnBank>();

  Future<List<DrawnBank>> drawnBankDropdownData;
  Stream<DrawnBank> get selectedDrawnBankState => drawnBankDropdownGetData;
  void selectedDrawnBankStateEvent(DrawnBank state) => drawnBankDropdownGetData.add(state);

  DrawnBankDropdownBloc(){
    drawnBankDropdownData = drawnBankDropdownRepository.getDrawnBank();
  }

  void dispose(){
    drawnBankDropdownGetData.close();
  }
}