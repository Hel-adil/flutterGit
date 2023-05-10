import 'package:sqlflite_crud_app/Home.dart';
import 'package:flutter/material.dart';
import 'package:sqlflite_crud_app/sqldb.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  TextEditingController _titre = TextEditingController();
  TextEditingController _auteur = TextEditingController();
  TextEditingController _annee = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _titre,
              style: TextStyle(fontSize: 20, color: Colors.purple),
              decoration: const InputDecoration(
                labelText: "Titre",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _auteur,
              style: TextStyle(fontSize: 20, color: Colors.purple),
              decoration: const InputDecoration(
                labelText: "Auteur",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _annee,
              style: TextStyle(fontSize: 20, color: Colors.purple),
              decoration: const InputDecoration(
                labelText: "Annee",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _description,
              style: TextStyle(fontSize: 20, color: Colors.purple),
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  sqldb db = sqldb();
                  int rep = await db.insertData(
                      "INSERT INTO Books (titre, auteur, annee, description) VALUES ('${_titre.text}', '${_auteur.text}', '${_annee.text}', '${_description.text}')");
                  if (rep > 0) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Home()),
                        (route) => false);
                  }
                },
                child: Container(
                  child: Icon(
                    Icons.add,
                    size: 30,
                  ),
                  width: double.infinity,
                ))
          ],
        ),
      ),
    );
  }
}
