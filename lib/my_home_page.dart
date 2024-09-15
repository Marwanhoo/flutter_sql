import 'package:flutter/material.dart';
import 'package:flutter_sqflite/sqldb.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SqlDb sqlDb = SqlDb();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQFLITE"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async{
                int response = await sqlDb.insertData("INSERT INTO 'notes' ('note') VALUES ('note four') ");
                debugPrint("Response $response");
              },
              child: const Text("Insert Data"),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async{
                List<Map> response = await sqlDb.readData("SELECT * FROM 'notes' ");
                debugPrint("Response $response");
              },
              child: const Text("Read Data"),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async{
                int response = await sqlDb.deleteData("DELETE FROM 'notes' WHERE id = 4 ");
                debugPrint("Response $response");
              },
              child: const Text("Delete Data"),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async{
                int response = await sqlDb.updateData("UPDATE 'notes' SET 'note' = 'notes six' WHERE id = 3   ");
                debugPrint("Response $response");
              },
              child: const Text("update Data"),
            ),
          ],
        ),
      ),
    );
  }
}
