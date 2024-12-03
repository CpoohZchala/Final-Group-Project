import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cassava_healthy_finder/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ChangePasswordScreen widget allows the user to change their password
class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // Form key for validating the form inputs
  final _formKey = GlobalKey<FormState>();

  // Controllers for each text field (current password, new password, confirm password)
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Flags to control visibility of password fields (obscure text)
  bool _currentPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  // Dispose controllers when the screen is disposed
  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the AuthService instance from the provider
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      // AppBar with title and background color
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 232, 238, 232),
      ),
      // Padding for the form and its inputs
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Key for validating the form
          child: Column(
            children: [
              // Current Password TextFormField
              TextFormField(
                controller: _currentPasswordController, // Controller to handle text input
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(), // Style the border of the input
                  suffixIcon: IconButton( // Icon button for password visibility toggle
                    icon: Icon(
                      _currentPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentPasswordVisible = !_currentPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_currentPasswordVisible, // Toggle the visibility
                validator: (value) {
                  // Ensure the user enters the current password
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // New Password TextFormField
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _newPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _newPasswordVisible = !_newPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_newPasswordVisible, // Toggle visibility of new password
                validator: (value) {
                  // Ensure the user enters a new password
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Confirm New Password TextFormField
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_confirmPasswordVisible, // Toggle visibility of confirm password
                validator: (value) {
                  // Ensure the confirm password matches the new password
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              // Change Password Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 10, 49, 12), // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () async {
                  // Validate form before proceeding with password change
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      // Call the changePassword method from AuthService
                      await authService.changePassword(
                        _currentPasswordController.text,
                        _newPasswordController.text,
                      );
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Password changed successfully')),
                      );
                      Navigator.of(context).pop(); // Pop the screen to go back
                    } on FirebaseAuthException catch (e) {
                      // If there is an error from Firebase (e.g., wrong current password)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Failed to change password: ${e.message}')),
                      );
                    } catch (e) {
                      // If there is an unknown error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('An unknown error occurred')),
                      );
                    }
                  }
                },
                child: const Text('Change Password',
                    style: TextStyle(color: Colors.white)), // Button label
              ),
            ],
          ),
        ),
      ),
    );
  }
}
