import 'package:flutter/material.dart';

class OnboardingPage2 extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback backPressed;

  // Constructor with required onPressed callback
  OnboardingPage2(
      {required this.onPressed,
      required this.backPressed,
      required Null Function() onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the structure for the page
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      // backgroundColor:Color.fromARGB(255, 79, 80, 79), // Uncomment to set a specific background color

      body: Center(
        // Center the Column within the available space
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the Column
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the contents vertically
            children: [
              // Image displaying the second onboarding illustration
              Image.asset('assets/assets/onboarding2.png', height: 300),
              const SizedBox(
                  height: 20), // Space between the image and the next element
              const Text(
                "Health Check", // Heading text for this onboarding page
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                  height: 20), // Space between the heading and the description
              const Text(
                "Take picture of your crop or upload image to detect disease ",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center, // Center align the text
              ),
              const SizedBox(
                  height: 20), // Space between the description and the button
              ElevatedButton(
                onPressed: onPressed, // Trigger the callback when pressed
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromRGBO(10, 49, 12, 1), // Button background color
                  foregroundColor: Colors.white, // Button text color
                ),
                child: const Text('Next'), // Label for the button
              ),
           
              
            ],
          ),
        ),
      ),
    );
  }
}
