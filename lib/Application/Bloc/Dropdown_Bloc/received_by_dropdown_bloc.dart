

import 'package:find_dropdown/rxdart/behavior_subject.dart';

import '../../../infrastructure/Models/received_by_model.dart';
import '../../../infrastructure/Repository/received_by_repository.dart';

class ReceivedByDropdownBloc{
  final receivedByDropdownRepository = ReceivedByRepository();
  final receivedByDropDownGetData = BehaviorSubject<ReceivedBy>();

  Future<List<ReceivedBy>> receivedByDropDownData;
  Stream<ReceivedBy> get selectedState => receivedByDropDownGetData;
  void selectedStateEvent(ReceivedBy state)=> receivedByDropDownGetData.add(state);

  ReceivedByDropdownBloc(){
    receivedByDropDownData = receivedByDropdownRepository.getData();
  }
  void dispose(){
    receivedByDropDownGetData.close();
  }
}