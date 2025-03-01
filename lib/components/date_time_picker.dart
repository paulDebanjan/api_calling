import 'package:flutter/material.dart';

class DateTimePickerScreen extends StatefulWidget {
  @override
  _DateTimePickerScreenState createState() => _DateTimePickerScreenState();
}

class _DateTimePickerScreenState extends State<DateTimePickerScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // Function to pick Date
  Future<void> _pickDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: "Select a Date", // 🔹 Change the header text
      confirmText: "NEXT", // 🔹 Change "OK" button text
      cancelText: "CANCEL", 
    );

    if (pickedDate != null) {
      // After selecting a date, show the time picker
      _pickTime(context, pickedDate);
    }
  }

  // Function to pick Time
  Future<void> _pickTime(BuildContext context, DateTime pickedDate) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedDate = pickedDate;
        selectedTime = pickedTime;
      });

      // Combine Date & Time
      DateTime finalDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      print("Selected DateTime: $finalDateTime"); // You can store this in a variable
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Date & Time Picker")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _pickDateTime(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          child: Text(
            selectedDate == null || selectedTime == null
                ? "Select Date & Time"
                : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year} ${selectedTime!.format(context)}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
