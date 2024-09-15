import 'package:flutter/material.dart';
import 'package:flutter_sqflite/my_home_screen.dart';
import 'package:flutter_sqflite/sqldb.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    super.key,
    required this.id,
    required this.title,
    required this.note,
  });

  final int id;
  final String title;
  final String note;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  SqlDb sqlDb = SqlDb();

  @override
  void initState() {
    titleController.text = widget.title;
    noteController.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
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
                  // int response = await sqlDb.updateData('''
                  // UPDATE notes SET
                  // title ="${titleController.text}" ,
                  // note = "${noteController.text}"
                  // WHERE id = ${widget.id}
                  // ''');
                  int response = await sqlDb.update("notes", {
                    "title" : titleController.text ,
                    "note" : noteController.text
                  }, "id = ${widget.id}");
                  debugPrint("Response $response");
                  if (response > 0) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const MyHomeScreen()),
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
