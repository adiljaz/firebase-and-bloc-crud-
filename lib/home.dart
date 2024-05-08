import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firelearn/edit.dart';
import 'package:flutter/material.dart';
import 'package:firelearn/adding.dart'; // Assuming Adding widget is imported correctly
import 'package:firelearn/firebase.dart'; // Assuming FirestoreService is imported correctly

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

final CollectionReference user = FirebaseFirestore.instance.collection('users');

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: user.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot student = snapshot.data!.docs[index];

                return ListTile(
                  leading: Container(
                    child: Image.network(student['imageUrl']),
                  ),
                  title: Text(student['name']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => deleteDocument(student.id),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditPage(
                              age: student['age'],
                              name: student['name'],
                              classA: student['classA'],
                              fathername: student['fathername'],
                              image: student['imageUrl'],
                              id: student.id,
                            ),
                          ));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Adding()));
        },
      ),
    );
  }
}
