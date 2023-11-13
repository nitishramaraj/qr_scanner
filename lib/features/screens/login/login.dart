import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_scanner/features/screens/main_menu/main_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  Future<void> _setName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
  }

  Future<String?> _getName() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName');
    return userName;
  }

  @override
  Widget build(BuildContext context) {
    String enteredName = '';
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 80.0,
            left: 24.0,
            bottom: 24.0,
            right: 24.0,
          ),
          child: Form(
            key: _formKey, // Add a key to the Form widget
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/logos/invenger-logo-login.png"),
                    const SizedBox(height: 70),
                    Text(
                      "Welcome",
                      style: GoogleFonts.poppins(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Please enter your name to use the app",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    TextFormField(
                      key: const Key('name'), // Add a key to the TextFormField
                      style: const TextStyle(fontSize: 20),
                      onChanged: (value) {
                        enteredName = value; // Capture the entered name
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.assignment_ind_outlined),
                        labelText: "Enter your name",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          // Change the font weight
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _setName(enteredName);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainMenuScreen()),
                            );

                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF00008B)),
                        ),
                        child: Text(
                          "Enter",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
