import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  final VoidCallback onPressed; // Callback to handle when the button is pressed

  // Constructor to pass the onPressed function to the widget
  OnboardingPage1({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Container widget to hold the body content
        decoration: BoxDecoration(
          
          gradient: LinearGradient(
            // Creates a gradient background with two colors
            colors: [Colors.white, Colors.grey.shade300],
            begin: Alignment.topCenter, // Gradient starts from the top
            end: Alignment.bottomCenter, // Gradient ends at the bottom
          ),
        ),
        child: Center(
          // Center widget centers its child within the available space
          child: Padding(
            // Padding widget to give space inside the container
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // Column widget to arrange the child widgets vertically
              mainAxisAlignment: MainAxisAlignment.center, // Centers the widgets vertically
              children: [
                const SizedBox(height: 40), // Adds space at the top before the image
                // Image height is set to 60% of the screen height for responsiveness
                Image.asset(
                  'assets/assets/onboarding1.png',
                  height: MediaQuery.of(context).size.height * 0.6, // Dynamic height based on screen size
                ),
                const SizedBox(height: 80), 
                ElevatedButton(
                  onPressed: onPressed, // Calls the function passed from the parent when pressed
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 15), // Custom padding for button
                    backgroundColor: Color.fromRGBO(10, 49, 12, 1), // Dark green background color
                    foregroundColor: Colors.white, // White text color
                    shape: RoundedRectangleBorder(
                      // Rounded corners for the button
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5, // Shadow effect to give depth to the button
                  ),
                  child: const Text(
                    'Get Started', // Text inside the button
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Styling for the button text
                  ),
                ),
                const SizedBox(height: 90), // Adds space between the button and the footer text
                // Footer text at the bottom of the screen
                const Text(
                  "Powered By JACP Solutions Lanka (pvt) LTD", // Small footer text for branding
                  style: TextStyle(
                    fontSize: 12, // Smaller font size for the footer text
                    color: Color(0xEE898686), // Subtle color for the footer text
                    fontWeight: FontWeight.w500, // Medium weight for the footer text
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
