import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'hours.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final db = DatabaseHelper.instance;

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text(
                'insert',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _insert,
            ),
            ElevatedButton(
              child: const Text(
                'query',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _query,
            ),
            ElevatedButton(
              child: const Text(
                'update',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _update,
            ),
            ElevatedButton(
              child: const Text(
                'delete',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _delete,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _insert() async {
    var hours = Hours(1, 2, 'c');
    final id = await db.insert(hours);
    debugPrint('inserted row id: $id; ' + hours.toString());
  }

  void _query() async {
    final allRows = await db.queryAllRows();
    print('query all rows:');
    //debugPrint(allRows.toString());
    allRows?.forEach(print);
  }

  void _update() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnDesc: 'Client',
      DatabaseHelper.columnHours: 9,
      DatabaseHelper.columnOvertime: 1
    };
    final rowsAffected = await db.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    final id = await db.queryRowCount();
    final rowsDeleted = await db.delete(id!);
    print('deleted $rowsDeleted row(s): row $id');
  }
}
