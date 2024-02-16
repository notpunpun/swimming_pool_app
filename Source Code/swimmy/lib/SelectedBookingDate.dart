// SelectedBookingDate.dart
import 'package:flutter/material.dart';

class SelectedBookingDate extends StatelessWidget {
  final List<DateTime> selectedDates;

  const SelectedBookingDate({Key? key, required this.selectedDates})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Selected Booking Dates',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: selectedDates.map((date) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  date.toLocal().toString().split(' ')[0],
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
