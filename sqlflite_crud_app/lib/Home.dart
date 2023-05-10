import 'package:flutter/material.dart';
import 'package:sqlflite_crud_app/EditBook.dart';
import 'package:sqlflite_crud_app/sqldb.dart';
import 'package:sqflite/sqflite.dart';

import 'sqldb.dart';

sqldb db = sqldb();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Map>> getAllLivres() async {
    List<Map> rep = await db.readData("SELECT * FROM Books");
    return rep;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addbook");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 11,
              child: Container(
                child: FutureBuilder(
                    future: getAllLivres(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Map> listeDesLivres = snapshot.data!;
                        return ListView.builder(
                            itemCount: listeDesLivres.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                    leading: Icon(
                                      Icons.book,
                                      color: Colors.pink,
                                      size: 30,
                                    ),
                                    title: Text(
                                      "${listeDesLivres[index]["titre"]}",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.pink),
                                    ),
                                    subtitle: Text(
                                      "${listeDesLivres[index]["auteur"]}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.purple),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) => EditBook(
                                                                id: listeDesLivres[
                                                                        index]
                                                                    ["id"],
                                                                titre: listeDesLivres[
                                                                        index]
                                                                    ["titre"],
                                                                auteur: listeDesLivres[
                                                                        index]
                                                                    ["auteur"],
                                                                annee: listeDesLivres[
                                                                        index]
                                                                    ["annee"],
                                                                description:
                                                                    listeDesLivres[
                                                                            index]
                                                                        [
                                                                        "description"],
                                                              )));
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.green,
                                              size: 30,
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title: Text(
                                                            "Voulez-vous vraiment supprimer ${listeDesLivres[index]["titre"]} ?"),
                                                        actions: [
                                                          ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                int rep = await db
                                                                    .deleteData(
                                                                        "DELETE FROM Books WHERE id = ${listeDesLivres[index]['id']}");
                                                                if (rep > 0) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  setState(
                                                                      () {});
                                                                }
                                                              },
                                                              child:
                                                                  Text("Oui")),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                setState(() {});
                                                              },
                                                              child: Text(
                                                                  "Annuler")),
                                                        ],
                                                      ));
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 30,
                                            )),
                                      ],
                                    )),
                              );
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
            Expanded(flex: 1, child: Container())
          ],
        ),
      ),
    );
  }
}
