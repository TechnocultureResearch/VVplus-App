
import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/stage_model.dart';
import 'package:vvplus_app/infrastructure/Repository/stage_repository.dart';

class StageDropdownBloc{
 final stageDropdownRepository = StageRepository();
 final stageDropdownGetData = BehaviorSubject<Stage>();

 Future<List<Stage>> stageDropdownData;
 Stream<Stage> get selectedStageState => stageDropdownGetData;
 void selectedStageStateEvent(Stage state) => stageDropdownGetData.add(state);

 StageDropdownBloc(){
   stageDropdownData = stageDropdownRepository.getStageData();
 }

 void dispose(){
   stageDropdownGetData.close();
 }
}