// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class BenchMark_Results extends StatelessWidget {
  final String selectedFileName;
  final String fileExt;
  final String filePath;
  final String submittedKey;

  BenchMark_Results({
    required this.selectedFileName,
    required this.fileExt,
    required this.filePath,
    required this.submittedKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Selected File Name: $selectedFileName'),
            Text('File Extension: $fileExt'),
            Text('File Path: $filePath'),
            Text('Submitted Key: $submittedKey'),
          ],
        ),
      ),
    );
  }
}
