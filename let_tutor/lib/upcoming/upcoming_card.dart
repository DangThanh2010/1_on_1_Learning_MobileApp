import 'package:flutter/material.dart';
import 'package:let_tutor/model/booking_dto.dart';
import 'package:let_tutor/model/list_booking_dto.dart';
import 'package:let_tutor/model/list_tutor_dto.dart';
import 'package:let_tutor/model/tutor_dto.dart';
import 'package:provider/provider.dart';

class UpcomingCard extends StatelessWidget {
  UpcomingCard(this.booking);

  final BookingDTO booking;

  @override
  Widget build(BuildContext context) {
    ListTutorDTO tutors = context.watch<ListTutorDTO>();
    TutorDTO? tutor = tutors.getTutor(booking.idTutor);
    ListBookingDTO bookings = context.watch<ListBookingDTO>();
    int hourDifference = booking.start.difference(DateTime.now()).inHours;

    return Card(
      margin: const EdgeInsets.only(top:10, left: 20, right: 20, bottom: 10),
      elevation: 4,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(tutor!.avatar),
                  )
                ),
              ),
                          
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tutor.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                    Row(
                      children: [ 
                        Text(booking.start.year.toString() + '-' + (booking.start.month < 10 ? ('0' + booking.start.month.toString()) : booking.start.month.toString()) + '-' + (booking.start.day < 10 ? ('0' + booking.start.day.toString()) : booking.start.day.toString())),
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          child: Text((booking.start.hour < 10 ? ('0' + booking.start.hour.toString()) : booking.start.hour.toString()) + ':' + (booking.start.minute < 10 ? ('0' + booking.start.minute.toString()) : booking.start.minute.toString()), style: const TextStyle(color: Colors.blue),),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                          
                        const Text('-'),
                              
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(left: 5,right: 5),
                          child: Text((booking.end.hour < 10 ? ('0' + booking.end.hour.toString()) : booking.end.hour.toString()) + ':' + (booking.end.minute < 10 ? ('0' + booking.end.minute.toString()) : booking.end.minute.toString()), style: const TextStyle(color: Colors.red),),
                          
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ],
                    )
                  ]
                )
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child:  GestureDetector(
                  onTap: hourDifference >= 2 ? () {bookings.setCancel(booking.id);} : null,
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      color: hourDifference >= 2 ? Colors.white : Colors.grey,
                      border: Border.all(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text (
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.bold, color: hourDifference >= 2 ? Colors.black : Colors.white),
                    ),
                  ),
                )
              ),

              Expanded(
                child:  GestureDetector(
                  onTap:  () { Navigator.pushNamed(context, "/video_conference");},
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text (
                      'Go to Meeting',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                )
              ),
            ],
          )
        ]
      )
    );
  }
}