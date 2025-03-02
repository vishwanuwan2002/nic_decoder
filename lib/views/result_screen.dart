import 'package:flutter/material.dart'; // Import Flutter Material package for UI components
import 'package:get/get.dart'; // Import GetX package for state management
import '../controllers/nic_controller.dart'; // Import NICController to access decoded NIC details

/// ResultScreen displays the decoded NIC details, including birth year, date, gender, age, and weekday.
class ResultScreen extends StatelessWidget {
  final NICController nicController =
      Get.find(); // Find the instance of NICController using GetX

  ResultScreen({super.key}); // Constructor for ResultScreen widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NIC Details"), // AppBar title
        centerTitle: true, // Center align title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button in the AppBar
          onPressed: () {
            Get.back(); // Navigate back to the InputScreen using GetX
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text left
          children: [
            // Card for NIC details
            Card(
              elevation: 3, // Light shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: Column(
                children: [
                  _buildInfoTile("NIC Format", nicController.nicFormat.value,
                      Icons.credit_card),
                  _buildInfoTile(
                      "Birth Year", nicController.birthYear.value, Icons.cake),
                  _buildInfoTile("Date of Birth", nicController.birthDate.value,
                      Icons.calendar_today),
                  _buildInfoTile(
                      "Gender", nicController.gender.value, Icons.wc),
                  _buildInfoTile(
                      "Age", nicController.age.value, Icons.timeline),
                  _buildInfoTile(
                      "Weekday", nicController.weekDay.value, Icons.event),
                ],
              ),
            ),
            const SizedBox(height: 20), // Spacing

            // Back Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text("Back"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper function to create a ListTile for displaying information
  Widget _buildInfoTile(String title, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent), // Icon
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold)), // Title
      subtitle: Text(value, style: const TextStyle(fontSize: 16)), // Value
    );
  }
}
