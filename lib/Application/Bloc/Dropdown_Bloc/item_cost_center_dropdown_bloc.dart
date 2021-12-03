import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Repository/item_cost_center_repository.dart';

class ItemCostCenterDropdownBloc {
  final _repository = ItemCostCenterRepository();
  final _selectedData$ = BehaviorSubject<StrRecord>();

  Future<List<StrRecord>> data;
  Stream<StrRecord> get selectedState => _selectedData$;
  void selectedStateEvent(StrRecord state) => _selectedData$.add(state);

  ItemCostCenterDropdownBloc() {
    data = _repository.getData();
  }

  void dispose() {
    _selectedData$.close();
  }
}