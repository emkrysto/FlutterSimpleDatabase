import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'hours.dart';
import 'hours_widget.dart';

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
            Expanded(
              flex: 1,
              child: SafeArea(child: hoursWidget()),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _insert() async {
    var d1 = DateTime.now();
    var row = Hours(d1, 1, 2, 'c');
    final id = await db.insert(row);
    debugPrint('inserted row id: $id; ' + row.toString());
  }

  void _query() async {
    final allRows = await db.queryAllRows();
    print('query all rows:');
    //debugPrint(allRows.toString());
    allRows?.forEach(print);
  }

  void _update() async {
    var d1 = DateTime.now();
    var row = Hours(d1, 2, 3, 'ce');
    final id = 2;

    final rowsAffected = await db.update(row, id);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    final id = await db.queryRowCount();
    final rowsDeleted = await db.delete(id!);
    print('deleted $rowsDeleted row(s): row $id');
  }
}
