import 'package:flutter/material.dart';
import 'package:cassava_healthy_finder/screens/Onboarding4.dart'; // Importing the OnboardingPage4 screen

// Importing the other onboarding pages
import 'OnboardingPage1.dart';
import 'OnboardingPage2.dart';
import 'OnboardingPage3.dart';

// Main widget for the onboarding screen
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

// State class for OnboardingScreen
class _OnboardingScreenState extends State<OnboardingScreen> {
  // PageController to control the PageView
  final PageController _pageController = PageController();
  int _currentPage = 0; // To keep track of the current page index

  // Callback function to handle page changes
  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  // Function to navigate to the next page
  void _onNextPage() {
    if (_currentPage < 3) {
      // Check if not on the last page
      _pageController.nextPage(
        duration: Duration(milliseconds: 300), // Duration of page transition
        curve: Curves.easeInOut, // Animation curve for the transition
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(
          255, 79, 80, 79), // Background color for the onboarding screen
      body: PageView(
        controller: _pageController, // Assign the PageController
        onPageChanged: _onPageChanged, // Set the callback for page changes
        children: [
          // List of onboarding pages
          OnboardingPage1(onPressed: _onNextPage),
          OnboardingPage2(
            onPressed: _onNextPage,
            backPressed: () {},
            onBackPressed: () {

            },
          ),
          OnboardingPage3(
            onPressed: _onNextPage,
            backPressed: () {},
            onBackPressed: () {},
          ),
          OnboardingPage4(onBackPressed: () {
            // Navigate to the previous page when back button is pressed
            _pageController.previousPage(
              duration:
                  Duration(milliseconds: 300), // Duration of page transition
              curve: Curves.easeInOut, // Animation curve for the transition
            );
          }),
        ],
      ),
    );
  }
}
