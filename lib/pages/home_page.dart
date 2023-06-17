import 'package:flutter/material.dart';
import 'package:modernlogintute/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({required this.username, required String email});

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      // Sign out from Google if the user signed in with Google
      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Error signing out: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred while signing out.'),
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
  }

  @override
  Widget build(BuildContext context) {
    String greeting = getGreeting();
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome $username'),
        backgroundColor: Colors.lightBlue, // Customizing the app bar color
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _signOut(context), // Call the sign-out function
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'lib/images/doodle.png'), // Replace with the path to your doodle.png image
            fit: BoxFit.cover,
          ),
        ),
        // Setting the container background color
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  greeting,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue, // Customizing the text color
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Start Exploring',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    primary: Colors.lightBlue, // Customizing the button color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getGreeting() {
    DateTime now = DateTime.now();
    String greeting;

    if (now.hour >= 5 && now.hour < 12) {
      greeting = 'Good morning';
    } else if (now.hour >= 12 && now.hour < 18) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    return '$greeting, $username!';
  }
}
