
import 'package:firelearn/firebase.dart';
import 'package:firelearn/userimage.dart';
import 'package:flutter/material.dart';

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
                        await addData(
                          name: name,
                          age: age,
                          classA: classA,
                          fathername: fathername,
                          imageUrl: imageUrl,
                        );
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
    );
  }
}
