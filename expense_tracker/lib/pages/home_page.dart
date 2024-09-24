import 'package:expense_tracker/components/my_list_tile.dart';
import 'package:expense_tracker/helpers/helper_functions.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/expense_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    Provider.of<ExpenseDatabase>(context, listen: false).readExpenses();
    super.initState();
  }

  void openNewExpenseBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Name"),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(hintText: "Amount"),
            )
          ],
        ),
        actions: [
          _cancelButton(),
          _saveButton()
        ],
      )
    );
  }

  void openDeleteBox() {

  }

  void openEditBox() {

  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseDatabase>(
      builder: (context, value, chil) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: openNewExpenseBox,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.allExpenses.length,
          itemBuilder: (context, index) {
            Expense expense = value.allExpenses[index];
            return MyListTile(
              expense: expense,
              onDeletePressed: (context) => openDeleteBox,
              onEditPressed: (context) => openEditBox,
            );
          }
        ),
      )
    );
  }
  
  Widget _cancelButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.pop(context);
        clearControllers();
      },
      child: const Text('Cancel'),
    );
  }

  Widget _saveButton() {
    return MaterialButton(
      onPressed: () async {
        if (nameController.text.isNotEmpty &&
            amountController.text.isNotEmpty) {
          Navigator.pop(context);
          saveNewExpense();
          clearControllers();
        }
      },
      child: const Text('Save'),
    );
  }

  void saveNewExpense() async {
    Expense newExpense = Expense(
        name: nameController.text,
        amount: convertStringToDouble(amountController.text),
        date: DateTime.now()
    );
    await context.read<ExpenseDatabase>().createNewExpense(newExpense);
  }

  void clearControllers() {
    nameController.clear();
    amountController.clear();
  }
}
