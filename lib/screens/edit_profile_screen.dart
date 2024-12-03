import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

// EditProfileScreen allows the user to edit their profile information
class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>(); // Key to manage form validation
  late String _name; // Name field to store the updated name
  late String _email; // Email field to store the updated email
  bool _isLoading =
      false; // Loading state to show a progress indicator during updates

  @override
  Widget build(BuildContext context) {
    final authService =
        Provider.of<AuthService>(context); // Get AuthService from provider
    final user = authService.currentUser; // Get the current user information

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Edit Profile',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: _isLoading // Show loading indicator while updating the profile
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey, // Form key to handle validation and saving
              child: ListView(
                padding: EdgeInsets.all(16.0), // Add padding around the form
                children: [
                  // Name field with validation
                  TextFormField(
                    initialValue:
                        user?.displayName, // Pre-fill with current name
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                          color: Colors.black87, // Set label color
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    validator: (value) => value!.isEmpty
                        ? 'Please enter a name'
                        : null, // Validation for empty name
                    onSaved: (value) => _name = value!, // Save the entered name
                  ),
                  SizedBox(height: 20),
                  // Email field with validation
                  TextFormField(
                    initialValue: user?.email, // Pre-fill with current email
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Colors.black87, // Set label color
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    validator: (value) => value!.isEmpty
                        ? 'Please enter an email'
                        : null, // Validation for empty email
                    onSaved: (value) =>
                        _email = value!, // Save the entered email
                  ),
                  const SizedBox(height: 40),
                  // Save button to submit the form
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromARGB(255, 10, 49, 12), // Button color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      'Save Changes', // Button text
                      style: TextStyle(
                        color: Color.fromARGB(255, 236, 239, 236),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => _updateProfile(
                        context, authService, user!), // Call to update profile
                  ),
                ],
              ),
            ),
    );
  }

  // Function to update the user's profile
  Future<void> _updateProfile(
      BuildContext context, AuthService authService, User user) async {
    if (_formKey.currentState!.validate()) {
      // Check if the form is valid
      _formKey.currentState!.save(); // Save the form fields
      setState(() => _isLoading = true); // Show loading spinner
      try {
        // Call the updateUserProfile method from AuthService to update the user's data
        await authService.updateUserProfile(user.uid, {
          'name': _name,
          'email': _email,
        });
        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      } catch (e) {
        // Handle errors and show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      } finally {
        // Hide the loading spinner once the update is complete
        setState(() => _isLoading = false);
      }
    }
  }
}
