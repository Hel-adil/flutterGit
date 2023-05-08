import 'package:flutter/material.dart';
import 'package:sqllite_app/sqldb.dart';
import 'package:sqflite/sqflite.dart';

sqldb db = sqldb();
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Future<List<Map>> getAllLivres() async {
  List<Map> rep = await  db.readData("SELECT * FROM livres");
  return rep;
}


class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('Home'),
    ),
    // body: Container(
    //   margin: EdgeInsets.all(20),
    //   child: Column(
    //     children: [
    //       Text('Home Page'),
    //       ElevatedButton(
    //         onPressed: () async{
    //           String sql = "INSERT INTO livres (titre, auteur, annee, image, description) VALUES ('titre1', 'auteur1', 2021, 'image1', 'description1')";
    //           int rep = await db.insertData(sql);
    //           print(rep);
    //         },

    //         child: Text('Insert'),
             
    //       ),
    //       ElevatedButton(
    //         onPressed: () async{
    //           String sql = "SELECT * FROM livres";
    //           List<Map<String, dynamic>> rep = await db.readData(sql);
    //           print(rep);
    //         },

    //         child: Text('Select'),
             
    //       ),
    //     ],
    //   ),
    // ),


    body: FutureBuilder (
      future: getAllLivres(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                title: Text(snapshot.data[index]['titre']),
                subtitle: Text(snapshot.data[index]['auteur']),
                trailing: Row (
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
                leading: Icon(Icons.book,color: Colors.blue,),

              );
            },
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
    );
  }
}