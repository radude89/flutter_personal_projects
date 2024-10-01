import 'package:expense_tracker/bar_graph/bar_graph.dart';
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

  Future<Map<int, double>>? _monthlyTotalsFuture;

  @override
  void initState() {
    Provider.of<ExpenseDatabase>(
        context,
        listen: false
    ).readExpenses();
    refreshGraphData();
    super.initState();
  }

  void refreshGraphData() {
    _monthlyTotalsFuture = Provider.of<ExpenseDatabase>(
        context,
        listen: false
    )
      .calculateMonthlyTotals();
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

  void openDeleteBox(Expense expense) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete expense'),
          actions: [
            _cancelButton(),
            _deleteExpenseButton(expense.id),
          ],
        )
    );
  }

  void openEditBox(Expense expense) {
    String existingName = expense.name;
    String existingAmount = expense.amount.toString();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Edit expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: existingName),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(hintText: existingAmount),
              )
            ],
          ),
          actions: [
            _cancelButton(),
            _editExpenseButton(expense),
          ],
        )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseDatabase>(
      builder: (context, value, child) {
        int startMonth = value.getStartMonth();
        int startYear = value.getStartYear();
        int currentMonth = DateTime.now().month;
        int currentYear = DateTime.now().year;
        int monthCount = calculateMonthCount(
            startYear, startMonth, currentYear, currentMonth
        );
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: openNewExpenseBox,
            child: const Icon(Icons.add),
          ),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: FutureBuilder(
                      future: _monthlyTotalsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          final monthlyTotals = snapshot.data ?? {};
                          List<double> monthlySummary = List.generate(
                              monthCount,
                              (index) => monthlyTotals[startMonth + index] ?? 0.0
                          );
                          return MyBarGraph(
                              monthlySummary: monthlySummary,
                              startMonth: startMonth
                          );
                        } else {
                          return const Center(
                              child: Text("Loading.."),
                          );
                        }
                      }
                  ),
                ),
                
                Expanded(
                  child: ListView.builder(
                      itemCount: value.allExpenses.length,
                      itemBuilder: (context, index) {
                        Expense expense = value.allExpenses[index];
                        return MyListTile(
                          expense: expense,
                          onDeletePressed: (context) => openDeleteBox(expense),
                          onEditPressed: (context) => openEditBox(expense),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
        );
      }
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

  Widget _editExpenseButton(Expense expense) {
    return MaterialButton(
      onPressed: () async {
        if (nameController.text.isNotEmpty ||
            amountController.text.isNotEmpty) {
          Navigator.pop(context);
          Expense updatedExpense = Expense(
              name: nameController.text.isNotEmpty
                  ? nameController.text
                  : expense.name,
              amount: amountController.text.isNotEmpty
                  ? convertStringToDouble(amountController.text)
                  : expense.amount,
              date: DateTime.now(),
          );
          int existingId = expense.id;
          await context
              .read<ExpenseDatabase>()
              .updateExpense(existingId, updatedExpense);
        }
      },
      child: const Text('Save'),
    );
  }

  Widget _deleteExpenseButton(int id) {
    return MaterialButton(
      onPressed: () async {
        Navigator.pop(context);
        await context
          .read<ExpenseDatabase>()
          .deleteExpense(id);
      },
      child: const Text('Delete'),
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
