import 'package:flutter/material.dart';

class Datefield extends StatefulWidget {
  const Datefield({super.key});

  @override
  State<Datefield> createState() => _DatefieldState();
}

class _DatefieldState extends State<Datefield> {
  final TextEditingController dateController = TextEditingController();

  Future<void> selectedDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      dateController.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateController,
      readOnly: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "Select Date",
        suffixIcon: Icon(Icons.calendar_month),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      onTap: selectedDate,
    );
  }
}
