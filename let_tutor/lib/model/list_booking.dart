import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/model/booking_info.dart';

part 'list_booking.g.dart';

@JsonSerializable()
class ListBooking {
  int? count;
  List<BookingInfo>? rows;

  ListBooking({this.count, this.rows});

  factory ListBooking.fromJson(Map<String, dynamic> json) => _$ListBookingFromJson(json);

  Map<String, dynamic> toJson() => _$ListBookingToJson(this);
}