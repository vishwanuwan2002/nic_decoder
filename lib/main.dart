import 'package:flutter/material.dart'; // Import Flutter Material package for UI components
import 'package:get/get.dart'; // Import GetX package for state management
import 'views/input_screen.dart'; // Import the InputScreen widget, which is the home screen

/// The main entry point of the Flutter application.
void main() {
  runApp(const MyApp()); // Run the MyApp widget
}

/// MyApp is the root widget of the application.
/// It initializes the GetMaterialApp, which supports GetX state management and routing.
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor for MyApp widget

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner:
          false, // Hide the debug banner in the top-right corner
      title: 'NIC Decoder', // The title of the app, visible in the taskbar
      home: InputScreen(), // Set the home screen to InputScreen
    );
  }
}
