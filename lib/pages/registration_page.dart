import 'package:flutter/material.dart';
import 'package:modernlogintute/components/my_button.dart';
import 'package:modernlogintute/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key});

  // text editing controllers
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void registerUser(BuildContext context) {
    // Get the entered email, username, and password
    String email = emailController.text;
    String username = usernameController.text;
    String password = passwordController.text;

    // Store the user's information in Firestore
    FirebaseFirestore.instance.collection('users').add({
      'email': email,
      'username': username,
      'password': password,
    });

    // Validate the input fields
    if (email.length < 5 || !email.contains('@')) {
      _showValidationDialog(
          context, 'Invalid Email', 'Please enter a valid email address.');
      return;
    }

    if (username.length < 5) {
      _showValidationDialog(context, 'Invalid Username',
          'Username must be at least 5 characters long.');
      return;
    }

    if (password.length < 5) {
      _showValidationDialog(context, 'Invalid Password',
          'Password must be at least 5 characters long.');
      return;
    }

    // Here, you can perform the registration logic
    // For demonstration purposes, let's assume the registration is successful
    // You can use the AuthService class to handle user registration

    // Show a success message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Registration successful!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // Navigate back to the login page
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showValidationDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // email textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              SizedBox(height: 10),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              SizedBox(height: 20),

              // register button
              MyButton(
                onTap: () => registerUser(context),
                text: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
