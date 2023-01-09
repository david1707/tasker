import 'dart:io';

import 'package:flutter/material.dart';

import 'package:basic_utils/basic_utils.dart' show StringUtils;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../models/todo_item.dart';
import '../constants/colours.dart';

class CustomFAB extends StatefulWidget {
  final Function addNewToDo;
  const CustomFAB({Key? key, required this.addNewToDo}) : super(key: key);

  @override
  State<CustomFAB> createState() => CustomFABState();
}

class CustomFABState extends State<CustomFAB> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _body = '';
  Priorities _priorities = Priorities.medium;
  File? _image;

  Future _getImage() async {
    try {
      final imageSelected =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageSelected != null) {
        final imageTemporary = File(imageSelected.path);
        await _saveImageToApp(imageSelected.path);

        setState(() {
          _image = imageTemporary;
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> _saveImageToApp(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = basename(imagePath);
    final image = File("${directory.path}/$fileName");
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colours.kTeal,
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          //ToDo Add a StatefulBuilder to the AlertDialog so it may be refreshed on setState (when we pick a new image) https://stackoverflow.com/questions/51962272/how-to-refresh-an-alertdialog-in-flutter
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Create a new ToDo'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(
                              color: Colours.kTeal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please, enter a title';
                            } else {
                              return null;
                            }
                          }),
                          onSaved: (value) {
                            _title = value.toString();
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Body',
                            labelStyle: TextStyle(
                              color: Colours.kTeal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please, enter a body';
                            } else if (value.length > 100) {
                              return 'The body is too long';
                            } else {
                              return null;
                            }
                          }),
                          onSaved: (value) {
                            _body = value.toString();
                          },
                        ),
                        const SizedBox(height: 20),
                        if (_image != null)
                          Image.file(
                            _image!,
                            height: 250,
                            fit: BoxFit.fill,
                          ),
                        ElevatedButton(
                          onPressed: _getImage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colours.kTeal,
                          ),
                          child: const Text(
                            'Pick an image',
                          ),
                        ),
                        DropdownButtonFormField<Priorities>(
                          value: _priorities,
                          items: Priorities.values.map((Priorities priorities) {
                            return DropdownMenuItem<Priorities>(
                              value: priorities,
                              child: Text(
                                StringUtils.capitalize(
                                  priorities.toString().split('.')[1],
                                ),
                              ),
                            );
                          }).toList(),
                          onSaved: (value) {
                            _priorities = value!;
                          },
                          onChanged: (_) {},
                        ),
                      ]),
                    )
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.kTeal,
                  ),
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      TodoItem todo = TodoItem(
                          id: DateTime.now().toString(),
                          title: _title,
                          body: _body,
                          priorities: _priorities,
                          isFinished: false);
                      widget.addNewToDo(todo);
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.kTeal,
                  ),
                  child: const Text('Create'),
                ),
              ],
              actionsAlignment: MainAxisAlignment.spaceAround,
            );
          },
        );
      },
    );
  }
}
