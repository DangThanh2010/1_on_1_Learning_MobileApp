// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListBooking _$ListBookingFromJson(Map<String, dynamic> json) => ListBooking(
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => BookingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListBookingToJson(ListBooking instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows,
    };
