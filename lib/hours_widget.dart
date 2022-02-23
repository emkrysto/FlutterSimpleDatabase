import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'hours.dart';

Widget hoursWidget() {
  final db = DatabaseHelper.instance;

  return FutureBuilder(
    future: db.retrieveUsers(),
    builder: (BuildContext context, AsyncSnapshot<List<Hours>> snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, position) {
              return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Icon(Icons.delete_forever),
                  ),
                  key: UniqueKey(),
                  onDismissed: (DismissDirection direction) async {
                    final id = snapshot.data![position].id;
                    final rowsDeleted =
                        await db.delete(snapshot.data![position].id!);
                    print('deleted $rowsDeleted row(s): row $id');
                  },
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => populateFields(snapshot.data![position]),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 12.0, 12.0, 6.0),
                                  child: Text(
                                    snapshot.data![position].t1.toString(),
                                    style: const TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 6.0, 12.0, 12.0),
                                  child: Text(
                                    snapshot.data![position].t2.toString(),
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data![position].desc,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 2.0,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ));
            });
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
  );
}

void populateFields(Hours hours) {}
