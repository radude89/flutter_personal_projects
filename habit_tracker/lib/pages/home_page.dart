import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_drawer.dart';
import 'package:habit_tracker/components/my_habit_tile.dart';
import 'package:habit_tracker/components/my_heat_map.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

import '../util/habit_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          _buildHeatMap(),
          _buildHabitList(),
        ],
      ),
    );
  }

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
              hintText: "Create a new habit"
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: onSave,
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: onCancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void checkHabitOnOff(bool? value, Habit habit) {
    if (value != null) {
      context
          .read<HabitDatabase>()
          .updateHabitCompletion(habit.id, value);
    }
  }

  void editHabitBox(Habit habit) {
    textController.text = habit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              onUpdate(habit.id);
            },
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: onCancel,
            child: const Text('Cancel'),
          ),
        ],
      )
    );
  }

  void deleteHabitBox(Habit habit) {
    textController.text = habit.name;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Are you sure you want to delete?"),
          actions: [
            MaterialButton(
              onPressed: () {
                onDelete(habit.id);
              },
              child: const Text('Delete'),
            ),
            MaterialButton(
              onPressed: onCancel,
              child: const Text('Cancel'),
            ),
          ],
        )
    );
  }

  void onSave() {
    String newHabitName = textController.text;
    context.read<HabitDatabase>().addHabit(newHabitName);
    Navigator.pop(context);
    textController.clear();
  }

  void onUpdate(Id habitID) {
    String newHabitName = textController.text;
    context.read<HabitDatabase>().updateHabitName(habitID, newHabitName);
    Navigator.pop(context);
    textController.clear();
  }

  void onCancel() {
    Navigator.pop(context);
    textController.clear();
  }

  void onDelete(Id habitID) {
    context.read<HabitDatabase>().deleteHabit(habitID);
    Navigator.pop(context);
    textController.clear();
  }

  Widget _buildHeatMap() {
    final habitDatabase = context.watch<HabitDatabase>();
    List<Habit> currentHabits = habitDatabase.currentHabits;
    return FutureBuilder<DateTime?>(
      future: habitDatabase.getFirstLaunchDate(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MyHeatMap(
            datasets: datasets,
            startDate: snapshot.data!
          );
        } else {
          return Container();
        }
      }
    );
  }

  Widget _buildHabitList() {
    final habitDatabase = context.watch<HabitDatabase>();
    List<Habit> currentHabits = habitDatabase.currentHabits;
    return ListView.builder(
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        final habit = currentHabits[index];
        bool isCompletedToday = isHabitCompletedToday(
          habit.completedDays
        );
        return MyHabitTile(
          text: habit.name,
          isCompleted: isCompletedToday,
          onChanged: (value) => checkHabitOnOff(value, habit),
          editHabit: (context) => editHabitBox(habit),
          deleteHabit: (context) => deleteHabitBox(habit),
        );
      }
    );
  }
}
