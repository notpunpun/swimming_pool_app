// MyDatePage.dart

import 'package:flutter/material.dart';
import 'HomePage.dart';

class MyDatePage extends StatefulWidget {

  
  final List<DateTime> selectedDates;
  final TimeOfDay selectedTime;

  const MyDatePage({
    Key? key,
    required this.selectedDates,
    required this.selectedTime,
  }) : super(key: key);

  @override
  _MyDatePageState createState() => _MyDatePageState();
}

class _MyDatePageState extends State<MyDatePage> {
  bool _bookingConfirmed = false;

  // Remove date from the selected dates
  void _removeSelectedDate(DateTime date) {
    setState(() {
      widget.selectedDates.remove(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Date'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              const Color.fromRGBO(44, 62, 80, 1),
              const Color.fromRGBO(52, 152, 219, 1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          )),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://i.pinimg.com/564x/d8/05/1b/d8051b0dceeab5d542651540cd97b62b.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My Booking',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: _bookingConfirmed
                    ? Column(
                        key: Key('confirmedKey'),
                        children: [
                          Text(
                            'Thank you for confirming!',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            },
                            child: IconButton(
                              icon: Icon(Icons.favorite),
                              iconSize: 40,
                              color: Colors.red,
                              onPressed: () {
                                // Handle IconButton press
                              },
                            ),
                          ),
                        ],
                      )
                    : widget.selectedDates.isEmpty
                        ? Column(
                            key: Key('chooseDateKey'),
                            children: [
                              Text(
                                'Choose a date first!',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )
                        : DataTable(
                            headingTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            dataTextStyle: TextStyle(
                              fontSize: 16,
                            ),
                            columns: [
                              DataColumn(label: Text('Selected Dates')),
                              DataColumn(label: Text('Selected Time')),
                            ],
                            rows: widget.selectedDates
                                .map(
                                  (date) => DataRow(
                                    cells: [
                                      DataCell(
                                        Text(date
                                            .toLocal()
                                            .toString()
                                            .split(' ')[0]),
                                      ),
                                      DataCell(
                                        Text(
                                            '${widget.selectedTime.hour}:${widget.selectedTime.minute}'),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
              ),
              SizedBox(height: 20),
              if (!_bookingConfirmed && widget.selectedDates.isNotEmpty)
                Column(
                  children: [
                    Text(
                      'Confirm Booking?',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle Yes button press
                            setState(() {
                              _bookingConfirmed = true;
                            });
                          },
                          child: Text('Yes'),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            _removeSelectedDate(widget.selectedDates.first);
                          },
                          child: Text('No'),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
