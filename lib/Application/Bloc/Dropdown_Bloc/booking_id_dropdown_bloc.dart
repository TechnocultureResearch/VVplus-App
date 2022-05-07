
import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/booking_id_model.dart';
import 'package:vvplus_app/infrastructure/Repository/booking_id_repository.dart';

class BookingIdDropdownBloc{

  final bookingIdtDropdownRepository = BookingIdRepository();
  final bookingIdDropdownGetData = BehaviorSubject<BookingIdModel>();

  Future<List<BookingIdModel>> bookingIdDropdownData;
  Stream<BookingIdModel> get selectedBookingIdState => bookingIdDropdownGetData;
  void selectedBookingIdStateEvent(BookingIdModel state) => bookingIdDropdownGetData.add(state);

  BookingIdDropdownBloc(){
    bookingIdDropdownData = bookingIdtDropdownRepository.getBooingIdData();
  }

  void dispose(){
    bookingIdDropdownGetData.close();
  }
}