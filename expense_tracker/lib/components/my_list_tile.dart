import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

import '../helpers/helper_functions.dart';

class MyListTile extends StatelessWidget {
  final Expense expense;

  const MyListTile({
    super.key,
    required this.expense
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.name),
      trailing: Text(formatAmount(expense.amount)),
    );
  }
}
