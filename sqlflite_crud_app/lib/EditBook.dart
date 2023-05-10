import 'package:sqlflite_crud_app/Home.dart';
import 'package:flutter/material.dart';
import 'package:sqlflite_crud_app/sqldb.dart';

class EditBook extends StatefulWidget {
  final int id;
  final String titre;
  final String auteur;
  final int annee;
  final String description;
  const EditBook(
      {super.key,
      required this.id,
      required this.titre,
      required this.auteur,
      required this.annee,
      required this.description});

  @override
  _EditBookState createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  TextEditingController _titre = TextEditingController();
  TextEditingController _auteur = TextEditingController();
  TextEditingController _annee = TextEditingController();
  TextEditingController _description = TextEditingController();

  sqldb db = sqldb();

  @override
  void initState() {
    _titre.text = widget.titre;
    _auteur.text = widget.auteur;
    _annee.text = widget.annee.toString();
    _description.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Book"),
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
              decoration: InputDecoration(
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
              decoration: InputDecoration(
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
              decoration: InputDecoration(
                labelText: "Annee",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _description,
              style: TextStyle(fontSize: 20, color: Colors.purple),
              decoration: InputDecoration(
                labelText: "description",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  int rep = await db.updateData(
                      '''UPDATE Books SET titre = "${_titre.text}", auteur = "${_auteur.text}", annee = "${_annee.text}", description = "${_description.text}" WHERE id = ${widget.id}''');
                  if (rep > 0) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Home()),
                        (route) => false);
                  }
                },
                child: Text("Modifier"))
          ],
        ),
      ),
    );
  }
}
