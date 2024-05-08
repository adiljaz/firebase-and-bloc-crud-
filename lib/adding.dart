import 'package:firelearn/blocssss/bloc/add_user_bloc.dart';
import 'package:firelearn/model.dart';
import 'package:firelearn/userimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Adding extends StatefulWidget {
  Adding({Key? key}) : super(key: key);

  @override
  State<Adding> createState() => _AddingState();
}

class _AddingState extends State<Adding> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _classAController = TextEditingController();
  TextEditingController _fathernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddUserBloc, AddUserState>(
      listener: (context, state) {
        if (state is AddUserLOadingState) {
          Center(child: CircularProgressIndicator());
        }

        if (state is AddUserSuccesState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              margin: EdgeInsets.all(5),
              behavior: SnackBarBehavior.floating,
              content: Center(
                child: Text(
                  'Enter correct email and password',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(
                        255,
                        255,
                        255,
                        255,
                      )),
                ),
              ),
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
            ),
          );
        }

        if (state is AddUserErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              margin: EdgeInsets.all(5),
              behavior: SnackBarBehavior.floating,
              content: Center(
                child: Text(
                  'EErrorrrrrrrrrrrrrrrrrrrrrrrrrrrr',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 221, 9, 9)),
                ),
              ),
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
            ),
          );
        }

        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Add User')),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  Userimage(onFileChange: (changingimage) {
                    setState(() {
                      imageUrl = changingimage;
                    });
                  }),
                  // Show selected image if available
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _ageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter age';
                      }
                      return null;
                    },
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _classAController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter class';
                      }
                      return null;
                    },
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _fathernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter father name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final name = _nameController.text;
                        final age = int.parse(_ageController.text);
                        final classA = int.parse(_classAController.text);
                        final fathername = _fathernameController.text;

                        if (imageUrl.isNotEmpty) {

                          BlocProvider.of<AddUserBloc>(context).add(
                              AddUserClick(
                                  age: age,
                                  classA: classA,
                                  fathername: fathername,
                                  imageUrl: imageUrl,
                                  name: name));


                               

                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Failed to upload image. Please try again.'),
                            ),
                          );
                        }
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
