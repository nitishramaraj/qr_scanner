import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_scanner/features/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_scanner/features/screens/scanner/scanner.dart';
import 'package:qr_scanner/features/screens/notes/notes.dart';
import 'package:qr_scanner/features/screens/photo/photo.dart';


class MainMenuScreen extends StatelessWidget {
  MainMenuScreen({Key? key});

  Future<void> _logout(BuildContext context) async {
    await clearUserData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
    );
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', '');
  }

  Future<String?> _getName() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName');
    return userName;
  }

  void _onCardPressed(BuildContext context, String cardTitle) {
    switch (cardTitle) {
      case "Photo":
      // Handle Photo card press
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const Photo()),
        );
        print("Photo card pressed");
        break;
      case "QR/Bar Code":
      // Handle QR Code card press
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const ScannerQR()),
        );
        print("QR Code card pressed");
        break;
      case "Quick Note":
      // Handle Bar Code card press
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  Notes()),
        );
        print("Bar Code card pressed");
        break;
      case "Log Out":
      // Handle Log Out card press
        clearUserData();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
        );
        break;
      default:
      // Default action or error handling
        print("Card not handled: $cardTitle");
        break;
    }
  }



  final List<CardData> cardsData = [
    CardData(
      title: "Photo",
      image: "assets/menu/photo-gallery-3.png",
      description: "Click picture",
    ),CardData(
      title: "QR/Bar Code",
      image: "assets/menu/scanner.png",
      description: "Scan and Upload",
    ),CardData(
      title: "Quick Note",
      image: "assets/menu/notes.png",
      description: "Upload Notes",
    ),CardData(
      title: "Log Out",
      image: "assets/menu/logout.png",
      description: "Reset Your Name",
    ),
    // Add more CardData objects for additional cards
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Container(
        decoration: const BoxDecoration(
    //     gradient: LinearGradient(
    //     begin: Alignment.center,
    //     end: Alignment.bottomRight,
    //     colors: [Colors.white,
    //         Color(0xFF00008B)],
    // ),
    ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String?>(
                    future: _getName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Hi, Loading...");
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        final userName = snapshot.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi,',
                              style: GoogleFonts.poppins(
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              userName ?? 'Guest',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  Image.asset(
                    "assets/logos/invenger_logo_final-menu.png",
                    width: 100,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // const Padding(
            //   padding: EdgeInsets.all(18.0),
            //   child: Text(
            //     "Dashboard Options",
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 28.0,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     textAlign: TextAlign.start,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: List.generate(
                    cardsData.length,
                        (index) => GestureDetector(
                      onTap: () => _onCardPressed(context, cardsData[index].title),
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Card(
                          color: const Color.fromARGB(255, 255 , 255, 255),
                          elevation: 5.0,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: const BorderSide(
                              color: Colors.black, // Choose the border color
                              width: 0.1, // Choose the border width
                            ),
                          ),

                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    cardsData[index].image,
                                    width: 70.0,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    cardsData[index].title,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                      // Add other font properties as needed
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                              Text(
                                cardsData[index].description,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13
                                  // Add other font properties as needed
                                ),
                              ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class CardData {
  final String title;
  final String image;
  final String description;

  CardData({
    required this.title,
    required this.image,
    required this.description,
  });
}
