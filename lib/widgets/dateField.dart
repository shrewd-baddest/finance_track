import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/providers/state_providers.dart';

class Datefield extends ConsumerStatefulWidget {
  const Datefield({super.key});

  @override
  ConsumerState<Datefield> createState() => _DatefieldState();
}

class _DatefieldState extends ConsumerState<Datefield> {
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
      ref.read(dateProvider.notifier).state = dateController.text;
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
