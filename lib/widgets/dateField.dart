import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
      ref.read(dateProvider.notifier).state = pickedDate;

      dateController.text = DateFormat('d/M/yyyy').format(pickedDate);
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
