//profile_screen.dart
import 'package:cassava_healthy_finder/screens/change_password_screen.dart';
import 'package:cassava_healthy_finder/screens/edit_profile_screen.dart';
import 'package:cassava_healthy_finder/screens/sign_in_screen.dart';
import 'package:cassava_healthy_finder/screens/sign_up_screen.dart';
import 'package:cassava_healthy_finder/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Existing code...

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    return Scaffold(
      
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found.'));
          }
          var userData = snapshot.data!;
          return Column(
            children: [
              Container(
                color: Color(0xFF0A310C),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      'CassavaGuard\n AI',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Spacer(),
                    Image.asset('assets/assets/onboarding11.png', height: 50),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/assets/user_02.png'),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData['name'] ?? 'No Name',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 160, 135, 8),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                userData['email'] ?? 'No Email',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 70, 68, 68),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfileScreen(),
                                  ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 48),
                    buildProfileButton(
                      context,
                      Icons.lock,
                      'Change Password',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen()),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    buildProfileButton(
                      context,
                      Icons.delete,
                      'Delete Account',
                      onPressed: () =>
                          _showDeleteAccountDialog(context, authService),
                    ),
                    SizedBox(height: 16),
                    buildProfileButton(
                      context,
                      Icons.exit_to_app,
                      'Logout',
                      onPressed: () async {
                        await authService.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                    ),
                    
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildProfileButton(BuildContext context, IconData icon, String text,
      {VoidCallback? onPressed}) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[100],
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: TextStyle(fontSize: 18, color: Colors.black),
        ),
        onPressed: onPressed ??
            () {
              // Implement functionality for other buttons
            },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.black),
            SizedBox(width: 16),
            Text(text, style: TextStyle(color: Colors.black)),
            Spacer(),
            Icon(Icons.chevron_right, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

void _showDeleteAccountDialog(BuildContext context, AuthService authService) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Account'),
        content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () async {
              Navigator.of(context).pop(); // Close the dialog
              try {
                await authService.deleteAccount();
                // Account deleted successfully, navigate to sign-in screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              } catch (e) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Failed to delete account. Please try again.')),
                );
              }
            },
          ),
        ],
      );
    },
  );
}
