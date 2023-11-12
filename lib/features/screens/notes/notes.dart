import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:qr_scanner/features/screens/main_menu/main_menu.dart';
import 'package:google_fonts/google_fonts.dart';


class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  double rating = 0.0;
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Add a home button
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainMenuScreen()),
                        );
                      },
                      icon: const Icon(
                        Icons.home,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    Image.asset(
                      "assets/logos/invenger_logo_final-menu.png",
                      width: 100,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Add label for multiline textbox
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Your Notes:',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              // Add multiline textbox
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                  ),
                  controller: notesController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: 'Write your notes here...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Add star rating
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Priority:',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: RatingBar.builder(
                  initialRating: rating,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  },
                ),
              ),
              const SizedBox(height: 22),
              // Add submit button
              Padding(padding: const EdgeInsets.all(22),
              child: SizedBox(width: double.infinity, child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF00008B)),
                ),
                onPressed: () {
                  // Retrieve values and perform actions
                  String notes = notesController.text;
                  print('Notes: $notes');
                  print('Rating: $rating');
                },
                child: const Text('Submit'),
              ))
                ,)
              ,
              // Add your additional widgets here
            ],
          ),
        ),
      ),
    );
  }
}
