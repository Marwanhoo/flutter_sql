import 'package:flutter/material.dart';
import 'package:flutter_sqflite/add_note_screen.dart';
import 'package:flutter_sqflite/sqldb.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  SqlDb sqlDb = SqlDb();

  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM 'notes' ");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Home Screen"),
      ),
      body: FutureBuilder(
        future: readData(),
        builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Something went wrong! ${snapshot.error} ${snapshot.hasError}",
              ),
            );
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text("${snapshot.data?[index]['id']}"),
                  ),
                  title: Text("${snapshot.data?[index]['title']}"),
                  subtitle: Text("${snapshot.data?[index]['note']}"),
                );
              },
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: FlutterLogo(size: 100,));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> AddNoteScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
