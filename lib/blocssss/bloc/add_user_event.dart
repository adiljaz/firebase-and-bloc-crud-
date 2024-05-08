part of 'add_user_bloc.dart';

@immutable
sealed class AddUserEvent {}

class AddUserClick extends AddUserEvent {
  final String name;
  final int classA;
 final  int age;
 final  String  fathername;
 final  String  imageUrl;

  AddUserClick({required this.name, required this.classA, required this.age, required this.fathername, required this.imageUrl});

  
}
