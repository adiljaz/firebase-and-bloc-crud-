import 'package:bloc/bloc.dart';
import 'package:firelearn/model.dart';
import 'package:meta/meta.dart';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'add_user_event.dart';
part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  AddUserBloc() : super(AddUserInitial()) {
    on<AddUserClick>((event, emit) async {
      emit(AddUserLOadingState());

      final result = await _addData(
        name: event.name,
        age: event.age,
        classA: event.classA,
        fathername: event.fathername,
        imageUrl: event.imageUrl,
      );

      if (result) {
        emit(AddUserSuccesState());
      } else {
        emit(AddUserErrorState( 'Failed to add data.'));
      }
    });
  }

  Future<bool> _addData({required String name,required int age,required int classA, required String fathername,required String? imageUrl,}) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');

    final Map<String, dynamic> userData = {
      'name': name,
      'age': age,
      'classA': classA,
      'fathername': fathername,
      'imageUrl': imageUrl,
    };

    try {
      await userCollection.add(userData);
      print('Data added successfully!');
      return true; // Return true if data is added successfully
    } catch (error) {
      print('Error adding data: $error');
      return false; // Return false if an error occurs
    }
  } 
  /////////////
  


 
  
}
