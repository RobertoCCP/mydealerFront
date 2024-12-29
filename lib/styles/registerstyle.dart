import 'package:flutter/material.dart';

class RegisterStyle {
  // Background color for the entire screen
  static const Color backgroundColor = Color(0xFFF2F2F2);

  // Form container styles
  static const double formWidth = 350.0;
  static const EdgeInsets formPadding = EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0);
  static final BoxDecoration formDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.grey.shade300),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8,
        offset: Offset(0, 3),
      ),
    ],
  );

  // Input field styles
  static const InputDecoration textFieldDecoration = InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
    labelStyle: TextStyle(
      fontSize: 12, // Reducido de 14 a 12
      color: Colors.black54,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orange, width: 2),
    ),
  );

  // Dropdown style
  static const TextStyle dropdownTextStyle = TextStyle(fontSize: 12, color: Colors.black);

  // Elevated button styles
  static final ButtonStyle registerButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 14), // Reducido de 16 a 14
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15), // Reducido el padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  );

  // Label style
  static const TextStyle labelStyle = TextStyle(
    fontSize: 12, // Reducido de 14 a 12
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  // App bar styles
  static const TextStyle appBarTextStyle = TextStyle(
    fontSize: 18, // Reducido de 20 a 18
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Divider styles
  static const Divider dividerStyle = Divider(
    color: Colors.grey,
    thickness: 1,
    indent: 10,
    endIndent: 10,
  );
}
