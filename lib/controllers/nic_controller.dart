import 'package:get/get.dart'; // Import GetX package for state management
import 'package:intl/intl.dart'; // Import Intl package for date formatting

/// NICController is responsible for decoding and handling NIC data
class NICController extends GetxController {
  var nicNumber = "".obs; // Observable variable to store NIC number
  var birthYear = "".obs; // Observable variable to store birth year
  var birthDate =
      "".obs; // Observable variable to store birth date in MM-dd format
  var gender = "".obs; // Observable variable to store gender (Male/Female)
  var age = "".obs; // Observable variable to store calculated age
  var weekDay =
      "".obs; // Observable variable to store the weekday of birth date
  var nicFormat =
      "".obs; // Observable variable to store the NIC format (Old or New)

  /// This method decodes the NIC number based on its format
  /// It checks if the NIC is in old or new format, then extracts and calculates birth date, gender, etc.
  void decodeNIC(String nic) {
    if (nic.length == 10) {
      // If NIC is in old format
      nicFormat.value = "Old Format"; // Set NIC format as Old
      birthYear.value =
          "19${nic.substring(0, 2)}"; // Extract birth year from NIC
      int dayCode = int.parse(
          nic.substring(2, 5)); // Extract day code (340 in this example)
      gender.value = dayCode < 500
          ? "Male"
          : "Female"; // Determine gender based on day code
      if (dayCode > 500) dayCode -= 500; // Adjust day code for females
      birthDate.value = _getDateFromDayCode(
          int.parse(birthYear.value), dayCode); // Get the birth date
    } else if (nic.length == 12) {
      // If NIC is in new format
      nicFormat.value = "New Format"; // Set NIC format as New
      birthYear.value = nic.substring(0, 4); // Extract birth year from NIC
      int dayCode = int.parse(
          nic.substring(4, 7)); // Extract day code (340 in this example)
      gender.value = dayCode < 500
          ? "Male"
          : "Female"; // Determine gender based on day code
      if (dayCode > 500) dayCode -= 500; // Adjust day code for females
      birthDate.value = _getDateFromDayCode(
          int.parse(birthYear.value), dayCode); // Get the birth date
    }

    // Correct the birth date parsing for the weekday calculation and age calculation
    DateTime dob = DateFormat("yyyy-MM-dd").parse(
        "${birthYear.value}-${birthDate.value}"); // Create DateTime object from birth date
    _calculateAge(dob); // Calculate age considering the exact birth date
    weekDay.value = DateFormat('EEEE')
        .format(dob); // Get the correct weekday name (e.g., Monday)
  }

  /// This method calculates the date from the day code (1-365/366) in the given year
  String _getDateFromDayCode(int year, int dayCode) {
    DateTime date = DateTime(year, 1, 1)
        .add(Duration(days: dayCode - 1)); // Calculate the actual date
    return DateFormat("MM-dd").format(date); // Return the date in MM-dd format
  }

  /// This method calculates the age of the person based on their date of birth
  void _calculateAge(DateTime dob) {
    DateTime today = DateTime.now(); // Get today's date
    int calculatedAge =
        today.year - dob.year; // Initial age calculation by year difference

    // Adjust for whether the birthday has occurred this year yet
    if (today.month < dob.month || // If current month is before the birth month
        (today.month == dob.month && today.day < dob.day)) {
      // If it's the same month, check day
      calculatedAge--; // Subtract 1 if the birthday hasn't passed yet this year
    }

    age.value = calculatedAge.toString(); // Set the calculated age
  }
}
