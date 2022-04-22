

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/payment_type_model.dart';
import 'package:vvplus_app/infrastructure/Repository/payment_type_repository.dart';

class PaymentTypeDropdownBloc{
  final paymentTypeDropdownRepository = PaymentTypeRepository();
  final paymentTyprDropdownGetData = BehaviorSubject<PaymentType>();

  Future<List<PaymentType>> paymentTypeDropdownData;
  Stream<PaymentType> get selectedPaymentTypeState => paymentTyprDropdownGetData;
  void selectedPaymentTypeStateEvent(PaymentType state) =>paymentTyprDropdownGetData.add(state);

  PaymentTypeDropdownBloc(){
    paymentTypeDropdownData = paymentTypeDropdownRepository.getPaymentTypeData();
  }
  void dispose(){
    paymentTyprDropdownGetData.close();
  }
}