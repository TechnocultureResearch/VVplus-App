
import 'dart:convert';
import 'dart:math';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/booking_id_model.dart';
import 'package:vvplus_app/infrastructure/Models/fill_transfer_model.dart';
import 'package:vvplus_app/infrastructure/Repository/booking_id_repository.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/store%20page/Branch%20to%20Branch%20Receive/branch_to_branch_receive_body.dart';

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