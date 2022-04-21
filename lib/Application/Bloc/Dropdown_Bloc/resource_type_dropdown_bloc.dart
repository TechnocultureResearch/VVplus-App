

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/resource_type_model.dart';
import 'package:vvplus_app/infrastructure/Repository/resource_type_repository.dart';

class ResourceTypeDropdownBloc{
  final resourceTypeRepository =ResourceTypeRepository();
  final resourceTypeGetData = BehaviorSubject<ResourceType>();

  Future<List<ResourceType>> resourceTypeData;

  Stream<ResourceType> get selectedResourceTypeState => resourceTypeGetData;
  void secletedTrsourceTypeStateEvent(ResourceType state) => resourceTypeGetData.add(state);

  ResourceTypeDropdownBloc(){
    resourceTypeData = ResourceTypeRepository().getResourceTypeData();
  }
  void dispose(){
    resourceTypeGetData.close();
  }

}