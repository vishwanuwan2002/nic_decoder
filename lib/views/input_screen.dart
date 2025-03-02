import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nic_controller.dart';
import 'result_screen.dart';

/// InputScreen is responsible for getting the NIC number from the user and triggering the decoding process
class InputScreen extends StatelessWidget {
  final NICController nicController =
      Get.put(NICController()); // Instantiate NICController

  InputScreen({super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    TextEditingController nicInputController =
        TextEditingController(); // NIC Input Controller

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.all(10), // Add padding
          decoration: BoxDecoration(
            color: Colors.lightBlue[100], // Light blue background
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: const Text(
            "NIC Decoder",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Input Field inside a Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: nicInputController,
                  decoration: const InputDecoration(
                    labelText: "Enter NIC Number",
                    prefixIcon: Icon(Icons.perm_identity),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Decode Button
            ElevatedButton.icon(
              onPressed: () {
                String nic = nicInputController.text.trim(); // Get user input
                if (_validateNIC(nic)) {
                  // ✅ Fixed method call
                  nicController.decodeNIC(nic); // Decode NIC if valid
                  Get.to(ResultScreen()); // Navigate to Result Screen
                } else {
                  _showInvalidNICPopup(context); // Show popup if invalid
                }
              },
              icon: const Icon(Icons.search),
              label: const Text("Decode"),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Function to validate NIC format
  bool _validateNIC(String nic) {
    final RegExp oldNicPattern =
        RegExp(r'^\d{9}[vVxX]$'); // Old Format: 9 digits + V/X
    final RegExp newNicPattern =
        RegExp(r'^\d{12}$'); // New Format: 12 digits only
    return oldNicPattern.hasMatch(nic) || newNicPattern.hasMatch(nic);
  }

  /// Function to show an invalid NIC popup dialog
  void _showInvalidNICPopup(BuildContext context) {
    Get.defaultDialog(
      title: "Invalid NIC Number",
      titleStyle:
          const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      middleText:
          "Please enter a valid NIC number (Old: 9 digits + V/X, New: 12 digits).",
      middleTextStyle: const TextStyle(fontSize: 16),
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back(); // Close popup
      },
    );
  }
}
