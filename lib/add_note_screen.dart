import 'package:flutter/material.dart';
import 'package:flutter_sqflite/my_home_screen.dart';
import 'package:flutter_sqflite/sqldb.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Title"),
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Note",
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isEmpty ||
                    noteController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Fill Form")));
                } else {
                  // int response = await sqlDb.insertData('''
                  // INSERT INTO notes (title , note)
                  // VALUES ( "${titleController.text}" , "${noteController.text}" )
                  // ''');
                  int response = await sqlDb.insert("notes", {
                    "title": titleController.text,
                    "note": noteController.text,
                  });
                  debugPrint("Response $response");
                  if (response > 0) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => MyHomeScreen()),
                      (route) => false,
                    );
                  }
                }
              },
              child: const Text("SAVE"),
            ),
          ],
        ),
      ),
    );
  }
}
