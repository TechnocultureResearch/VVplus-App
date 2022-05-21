

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/fill_transfer_model.dart';
import 'package:vvplus_app/infrastructure/Models/stage_model.dart';
import 'package:vvplus_app/infrastructure/Repository/fill_transfer_repository.dart';
import 'package:vvplus_app/infrastructure/Repository/stage_repository.dart';

class FillTransferDropdownBloc{
  final fillTransferDropdownRepository = FillTransferRepository();
  final fillTransferDropdownGetData = BehaviorSubject<FillTransferModel>();

  Future<List<FillTransferModel>> fillTransferDropdownData;
  Stream<FillTransferModel> get selectedFillTransferState => fillTransferDropdownGetData;
  void selectedFillTransferStateEvent(FillTransferModel state) => fillTransferDropdownGetData.add(state);

  FillTransferDropdownBloc(){
    fillTransferDropdownData = fillTransferDropdownRepository.getFillTransferData();
  }

  void dispose(){
    fillTransferDropdownGetData.close();
  }
}