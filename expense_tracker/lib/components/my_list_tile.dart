import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../helpers/helper_functions.dart';

class MyListTile extends StatelessWidget {
  final Expense expense;
  final void Function(BuildContext)? onEditPressed;
  final void Function(BuildContext)? onDeletePressed;

  const MyListTile({
    super.key,
    required this.expense,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: onEditPressed,
            icon: Icons.settings,
          ),
          SlidableAction(
            onPressed: onDeletePressed,
            icon: Icons.delete,
          )
        ],
      ),
      child: ListTile(
        title: Text(expense.name),
        trailing: Text(formatAmount(expense.amount)),
      ),
    );
  }
}
