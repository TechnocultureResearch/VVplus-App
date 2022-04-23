
import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/credit_acc_model.dart';
import 'package:vvplus_app/infrastructure/Repository/credit_account_repository.dart';

class CreditAccountDropdownBloc{
final creditAccountDropdownRepository = CreditAccountRepository();
final creditAccountDropdownGetData = BehaviorSubject<CreditAccount>();

Future<List<CreditAccount>> creditAccountDropdownData;
Stream<CreditAccount> get selectedCreditAccountState => creditAccountDropdownGetData;
void selectedCreditAccountStateEvent(CreditAccount state) => creditAccountDropdownGetData.add(state);

CreditAccountDropdownBloc(){
  creditAccountDropdownData = creditAccountDropdownRepository.getCreditAccount();
}

void dispose(){
  creditAccountDropdownGetData.close();
}
}