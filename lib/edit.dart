import 'package:firelearn/editimageclic.dart';
import 'package:firelearn/firebase.dart';
import 'package:firelearn/userimage.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  EditPage(
      {required this.name,
      required this.age,
      required this.classA,
      required this.fathername,
      required this.id,
      required this.image});

  final String name;
  final int age;
  final int classA;
  final String fathername;
  final String id;

  final String image;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {


  late String updateimagepath;

  @override
  void initState() {
    _nameController.text = widget.name;
    _ageController.text = widget.age.toString();
    _classAController.text = widget.classA.toString();
    _FathernameController.text = widget.fathername;

    updateimagepath = widget.image;

    super.initState();
  }

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _classAController = TextEditingController();

  final TextEditingController _FathernameController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EditUserimage( networkImageUrl: widget.image,     onFileChange: (changeimage) {
                  setState(() {
                    updateimagepath = changeimage;
                  });
                }),
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                  controller: _nameController,
                  validator: (vlaue) {
                    if (vlaue == null || vlaue.isEmpty) {
                      return 'Enter name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _ageController,
                  validator: (vlaue) {
                    if (vlaue == null || vlaue.isEmpty) {
                      return 'Enter age';
                    }
                    return null;
                  },
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _classAController,
                  validator: (vlaue) {
                    if (vlaue == null || vlaue.isEmpty) {
                      return 'Enter class';
                    }
                    return null;
                  },
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _FathernameController,
                  validator: (vlaue) {
                    if (vlaue == null || vlaue.isEmpty) {
                      return 'Enter fathername';
                    }

                    return null;
                  },
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        final name = _nameController.text;
                        final age = int.parse(_ageController.text);
                        final classA = int.parse(_classAController.text);
                        final fathername = _FathernameController.text;

                        final data = {
                          'name': name,
                          'age': age,
                          'classA': classA,
                          'fathername': fathername,
                          'imageUrl': updateimagepath,
                        };
                        editStudentClicked(widget.id, data);
                      }

                      Navigator.of(context).pop();
                    },
                    child: Text('save edited'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
