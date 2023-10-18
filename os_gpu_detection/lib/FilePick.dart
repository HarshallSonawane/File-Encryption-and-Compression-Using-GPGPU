import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


class FilePick extends StatefulWidget {
  
  final String title;
  final String imagePath;
  final String description;
  

  FilePick({
    required this.title,
    required this.imagePath,
    required this.description,
  });
  
  @override
  ChooseFile createState() => ChooseFile();
}



// ignore: must_be_immutable
class ChooseFile extends State<FilePick> {
  
  
  //We have the choice from previous menu here
  late String title;
  late String imagePath;
  late String description;

  
  @override
  void initState() {
    super.initState();
    title = widget.title;
    imagePath = widget.imagePath;
    description = widget.description;
  }

  String fileExt = "";
  String selectedFileName = "";
  TextEditingController keyController = TextEditingController();
  String submittedKey = "";



    void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        dialogTitle: 'Select a File you would like to Compress',
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'png',
          'pdf',
          'txt',
          'mp4',
          'mov',
          'docx',
          'heif',
          'jpeg'
        ]);

    if (result != null) {
      setState(() {
        selectedFileName = result.files.first.name ?? "";
        fileExt = result.files.first.extension ?? "";
      });
    }
  }

  void _submitKey() {
    setState(() {
      submittedKey = keyController.text;
    });
  }

  @override
  void dispose() {
    keyController.dispose();
    super.dispose();
  }
  
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPGPU Based File Encryption'), // Display the title passed from the previous screen
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _openFilePicker,
              child: Text('Choose File'),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(180, 60),
                textStyle: const TextStyle(
                    fontFamily: "Cascadia Code",
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            ),
            SizedBox(height: 20),
            Text(
              selectedFileName,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Extension: " + fileExt,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Enter your key:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: keyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your key:',
                  counterText: '', // To remove the character counter
                ),
                maxLength: 16, // Maximum length
                minLines: 1, // Minimum length
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _submitKey();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Key submitted'),
                  ),
                );
              },
              child: const Text('Submit Key'),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(180, 60),
                textStyle: const TextStyle(
                    fontFamily: "Cascadia Code",
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
              ),
            SizedBox(height: 20),
            Text(
              submittedKey,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}


