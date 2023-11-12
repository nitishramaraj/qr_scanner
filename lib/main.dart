import 'package:flutter/material.dart';
import 'features/screens/login/login.dart';
import 'features/screens/main_menu//main_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, Key? key1});

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName');
    if(userName == "" || userName == null){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invenger QR Scanner',
      home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while checking login status
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              // Handle errors if any
              return Scaffold(
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            } else {
              // If the user is logged in, navigate to the main menu
              // Otherwise, show the login screen
              return snapshot.data! ?  MainMenuScreen() : LoginScreen();
            }
          }
        },
      ),
    );
  }
}




