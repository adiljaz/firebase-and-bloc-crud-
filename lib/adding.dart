import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firelearn/blocssss/imageadding/bloc/image_adding_bloc.dart';
import 'package:firelearn/blocssss/bloc/add_user_bloc.dart';
import 'package:firelearn/model.dart';
import 'package:firelearn/userimage.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text('Add User')),
      body: BlocBuilder<ImageAddingBloc, ImageAddingState>(
        builder: (context, state) {
          if (state is ImageSelectedState) {
            imageUrl = state.imageUrl; // Update imageUrl when state changes
          }
          return BlocConsumer<AddUserBloc, AddUserState>(
            listener: (context, state) {
              if (state is AddUserLOadingState) {
                // Show loading indicator
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Loading...')),
                );
              } else if (state is AddUserSuccesState) {
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User added successfully!')),
                );
                // Clear form and navigate away after success
                _clearForm();
                Navigator.of(context).pop();
              } else if (state is AddUserErrorState) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.errorMessage}')),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 60),
                        Userimage(onFileChange: (changingImage) {
                          BlocProvider.of<ImageAddingBloc>(context)
                              .add(ImageChangedEvent(changingImage));
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
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _ageController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter age';
                            }
                            return null;
                          },
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _classAController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter class';
                            }
                            return null;
                          },
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
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
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
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
                                    name: name,
                                  ),
                                );
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
              );
            },
          );
        },
      ),
    );
  }

  void _clearForm() {
    _nameController.clear();
    _ageController.clear();
    _classAController.clear();
    _fathernameController.clear();
    imageUrl = '';
  }
}
