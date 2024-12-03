import 'package:flutter/material.dart';
import 'sign_up_screen.dart'; // Ensure the SignUpScreen is correctly imported
import 'sign_in_screen.dart'; // Ensure the SignInScreen is correctly imported

class OnboardingPage4 extends StatelessWidget {
  final VoidCallback onBackPressed;

  // Constructor with required onBackPressed callback
  const OnboardingPage4({required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent AppBar background
        elevation: 0, // No shadow under the AppBar
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0), // Horizontal padding for the body content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between top and bottom sections
            children: [
              Column(
                children: [
                  const SizedBox(height: 40), // Space at the top
                  Image.asset(
                    'assets/assets/cultivation_tips.png', // Image asset for cultivation tips
                    height: 300,
                  ),
                  const SizedBox(height: 20), // Space between the image and the next element
                  const Text(
                    "Cultivation Tips", // Heading text for this onboarding page
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16), // Space between the heading and the description
                  Text(
                    "Receive farming advice about how to improve your yield.",
                    textAlign: TextAlign.center, // Center align the text
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600], // Text color for the description
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()), // Navigate to the SignUpScreen
                      );
                    },
                    child: const Text('Sign Up'), // Button text
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A310C), // Button background color
                      foregroundColor: Colors.white, // Button text color
                      minimumSize: const Size(double.infinity, 50), // Full width button with specified height
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // Space between the buttons
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()), // Navigate to the SignInScreen
                      );
                    },
                    child: const Text('Sign In'), // Button text
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF0A310C), // Text button color
                      minimumSize: const Size(double.infinity, 50), // Full width button with specified height
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Space at the bottom
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
