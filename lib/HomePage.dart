import 'dart:async';
import 'package:flutter/material.dart';
import 'MyDatePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now(); // Added for date picker
  int _currentIndex = 0;
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _nextImage();
    });
  }

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % imagePaths.length;
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromRGBO(44, 62, 80, 1),
                const Color.fromRGBO(52, 152, 219, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/woter.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${selectedTime.hour} : ${selectedTime.minute}"),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(95, 44, 130, 1),
                      const Color.fromRGBO(73, 160, 157, 1),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  child: const Text("Choose Time",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    final TimeOfDay? timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                      initialEntryMode: TimePickerEntryMode.dial,
                    );
                    if (timeOfDay != null) {
                      setState(() {
                        selectedTime = timeOfDay;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.all(15),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shadowColor: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Selected Date: ${selectedDate.toLocal()}"),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(95, 44, 130, 1),
                      const Color.fromRGBO(73, 160, 157, 1),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  child: const Text("Choose Date",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    _showDatePicker();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.all(15),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shadowColor: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  height: 200.0,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: imagePaths.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imagePaths[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(95, 44, 130, 1),
                      const Color.fromRGBO(73, 160, 157, 1),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToMyDatePage();
                  },
                  child: Text("My Booking Date",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.all(15),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shadowColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime _dateTime = DateTime.now();
  bool _isPoolAvailable = true;
  List<DateTime> bookedDates = [];

  // image
  List<String> imagePaths = [
    'assets/images/pool.jpg',
    'assets/images/pool2.jpg',
    'assets/images/pool3.jpg',
  ];

  void _addBookedDate(DateTime selectedDate) {
    DateTime dateToAdd =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    if (!bookedDates.contains(dateToAdd)) {
      setState(() {
        bookedDates.add(dateToAdd);
      });
    }
  }

  void _removeBookedDate(DateTime selectedDate) {
    DateTime dateToRemove =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    if (bookedDates.contains(dateToRemove)) {
      setState(() {
        bookedDates.remove(dateToRemove);
      });
    }
  }

  bool _checkPoolAvailability(DateTime selectedDate) {
    return !(selectedDate.weekday == DateTime.wednesday ||
        selectedDate.weekday == DateTime.wednesday ||
        bookedDates.contains(selectedDate));
  }

  Widget _buildBookedDateTable() {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Booked Dates',
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
            children: bookedDates.isNotEmpty
                ? bookedDates
                    .map(
                      (date) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              date.toLocal().toString().split(' ')[0],
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_circle),
                              onPressed: () => _removeBookedDate(date),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList()
                : [Text('No booked dates')],
          ),
        ),
      ],
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedDate = value;
          _isPoolAvailable = _checkPoolAvailability(value);
          _addBookedDate(value);
        });
      }
    });
  }

  void _navigateToMyDatePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyDatePage(
          selectedDates: bookedDates,
          selectedTime: selectedTime,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
