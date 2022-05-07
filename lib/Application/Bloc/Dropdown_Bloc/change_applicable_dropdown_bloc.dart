import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/change_applicable_model.dart';
import 'package:vvplus_app/infrastructure/Repository/change_applicable_repository.dart';

class ChangeApplicableDropdownBloc {
  final changeApplicableRepository = ChangeApplicableRepository();
  final changeApplicableGetData = BehaviorSubject<ChangeApplicable>();

  Future<List<ChangeApplicable>> changeApplicableData;

  Stream<ChangeApplicable> get selectedState => changeApplicableGetData;
  void selectedStateEvent(ChangeApplicable state) =>
      changeApplicableGetData.add(state);

  ChangeApplicableDropdownBloc() {
    changeApplicableData = ChangeApplicableRepository().getData();
  }

  void dispose() {
    changeApplicableGetData.close();
  }
}
