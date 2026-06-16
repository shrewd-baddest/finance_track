import 'package:flutter_riverpod/legacy.dart';

final expenseProvider = StateProvider<bool>((ref) => true);
final selectedCardProvider = StateProvider<String>((ref) => "food");
