import 'package:flutter/material.dart';
import 'package:flutter_lesson_52/classwork/services/local_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final localDatabase = LocalDatabase();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    final db = localDatabase.database;
  }

  void addNote() async {
    setState(() {
      isLoading = true;
    });
   await localDatabase.addNote('Ertaga Juma!');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQFLITE"),
        actions: [
          IconButton(
            onPressed: addNote,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
          child: isLoading ? CircularProgressIndicator() : Text("Notes")),
    );
  }
}
