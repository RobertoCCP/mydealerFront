import 'package:flutter/material.dart';

class LoginStyle {
  // Background color for the entire screen
  static const Color backgroundColor = Color(0xFFF2F2F2);

  // Logo and header styles
  static const double logoHeight = 100.0;
  static const EdgeInsets headerPadding = EdgeInsets.symmetric(vertical: 10.0);
  static const TextStyle welcomeTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.orange,
  );

  // Form container styles
  static const double formWidth = 350.0;
  static const EdgeInsets formPadding = EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0);
  static final BoxDecoration formDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.grey.shade300),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  );

  // Input decoration styles
  static const InputDecoration emailInputDecoration = InputDecoration(
    labelText: 'Usuario',
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
  );

  static const InputDecoration passwordInputDecoration = InputDecoration(
    labelText: 'Contraseña',
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
  );

  // Button styles with hover and pressed colors
  static final ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    foregroundColor: Colors.white, // Text color
    textStyle: const TextStyle(fontSize: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  ).copyWith(
    // Hover and pressed color changes
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) return Colors.orange.shade300; // Hover color
        if (states.contains(WidgetState.pressed)) return Colors.orange.shade600; // Pressed color
        return null; // Default
      },
    ),
  );

  // Style for text-based buttons (e.g., links like "Forgot Password" or "Register")
  static final TextStyle linkTextStyle = TextStyle(
    fontSize: 14,
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  // Footer styles
  static const Color footerBackgroundColor = Color(0xFF707070);
  static const EdgeInsets footerPadding = EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0);
  static const TextStyle footerTextStyle = TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
}
