import 'package:flutter/material.dart';
import 'package:flutter_sqflite/add_note_screen.dart';
import 'package:flutter_sqflite/edit_note_screen.dart';
import 'package:flutter_sqflite/sqldb.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  SqlDb sqlDb = SqlDb();

  List notes = [];
  bool isLoading = true;

  void readData() async {
    //List<Map> response = await sqlDb.readData("SELECT * FROM 'notes' ");
    List<Map> response = await sqlDb.read("notes");
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Home Screen"),
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text("${notes[index]['id']}"),
                  ),
                  title: Text("${notes[index]['title']}"),
                  subtitle: Text("${notes[index]['note']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EditNoteScreen(
                                id: notes[index]['id'],
                                title: notes[index]['title'],
                                note: notes[index]['note'],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () async {
                          // int response = await sqlDb.deleteData(
                          //     "DELETE FROM 'notes' WHERE id = ${notes[index]['id']} ");
                          int response = await sqlDb.delete("notes", "id = ${notes[index]['id']}");
                          debugPrint("Response $response");
                          if (response > 0) {
                            setState(() {
                              notes.removeWhere((element) =>
                                  element['id'] == notes[index]['id']);
                            });
                          }
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddNoteScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
