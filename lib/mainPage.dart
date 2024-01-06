// MainPage.dart
import 'package:flutter/material.dart';
import 'HomePage.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/aur.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ' Welcome to the UMT Swimming Pool Booking App! ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            /*     Text(
              'Dive into convenience with our user-friendly app designed to make your swimming experience a splash! 🏊‍♂️',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
           
              textAlign: TextAlign.center,
            ), */
            SizedBox(height: 20),
            // Button to HomePage
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Book Now',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
