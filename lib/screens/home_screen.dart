import 'package:cassava_healthy_finder/screens/CommunityScreen.dart';
import 'package:cassava_healthy_finder/screens/dashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cassava_healthy_finder/screens/detection_screen.dart';
import 'package:cassava_healthy_finder/screens/notifications.dart';
import 'package:cassava_healthy_finder/screens/profile_screen.dart';
import 'package:cassava_healthy_finder/screens/feedback_screen.dart';
import 'package:cassava_healthy_finder/screens/sign_in_screen.dart';
import '../services/auth_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    DashboardScreen(), // New Dashboard screen as the first item
    ProfileScreen(),
    PredictionScreen(),
    FeedbackScreen(),
    NotificationsScreen(),
    CommunityScreen(),
   
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 32, 11),
      appBar: AppBar(
        title: const Text(
          'CassavaGuard AI',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 10, 49, 12),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 218, 227, 219),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: () async {
              await authService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex], // Display the currently selected screen

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 218, 227, 219),
        selectedItemColor: Colors.green.shade900,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard', // New Dashboard item
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            label: 'Predict',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Feedback',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Community',
          ),
           
        ],
      ),
    );
  }
}
