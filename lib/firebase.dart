
import 'dart:typed_data';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage ;

Future<void> addData({

  required String name,
  required int age,
  required int classA,
  required String fathername,
  required String?imageUrl,
}) async {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final Map<String, dynamic> userData = {
    'name': name,
    'age': age,
    'classA': classA, // Use classA instead of 'class'
    'fathername': fathername,
    'imageUrl':imageUrl,

  };

  try {
    await userCollection.add(userData);
    print('Data added successfully!'); // Add a success message
  } catch (error) {
    print('Error adding data: $error'); // Log the error for debugging
  }
}

/// reed data

// delete

Future<void> deleteDocument(String documentId) async {
  try {
    FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .delete()
        .then((value) {});

    print('Document deleted successfully!');
  } catch (e) {
    print('Error deleting document: $e');
  }
}

Future<void> editStudentClicked(documentid, data) async {
  final CollectionReference user =
      FirebaseFirestore.instance.collection('users');

  user.doc(documentid).update(data);
}



///// image storage conecting to firebase users 



    

 Future<String?> uploadImage(Uint8List imageData, String fileName) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref('user')
          .child(fileName);
      final metadata =
          firebase_storage.SettableMetadata(contentType: 'images/jpeg');
      await ref.putData(imageData, metadata);

      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return null;
    }
  }




