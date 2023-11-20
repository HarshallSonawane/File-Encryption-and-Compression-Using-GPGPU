import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'benchmark_results.dart';
import "lib.dart";

// late int isClicked = 0;
// late String btnTxt = "Select File";

class FilePickLive extends StatefulWidget {
  final String title;
  final String imagePath;
  final String description;
  final String gpu;

  FilePickLive({
    required this.title,
    required this.imagePath,
    required this.description,
    required this.gpu,
    required String gpuName,
    required int gpuoffest,
  });

  @override
  ChooseFile createState() => ChooseFile();
}

class ChooseFile extends State<FilePickLive> {
  late String title;
  late String imagePath;
  late String description;
  late String gpu;
  

  @override
  void initState() {
    super.initState();
    title = widget.title;
    imagePath = widget.imagePath;
    description = widget.description;
    gpu = widget.gpu;
  }

  List<String> allowedExtensions = [
    'jpg',
    'png',
    'pdf',
    'txt',
    'mp4',
    'mov',
    'docx',
    'heif',
    'jpeg',
    'enc'
  ];
  String fileExt = "";
  String selectedFileName = "";
  TextEditingController keyController = TextEditingController();
  String submittedKey = "";
  String filePath = "";

  String outputFilePath = "";
  String trimmedPath = "";

  void _selectPath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      dialogTitle: 'Select Output Path',
      type: FileType.custom,
      allowedExtensions: [
        'enc',
        'jpg',
        'png',
        'pdf',
        'txt',
        'mp4',
        'mov',
        'docx',
        'heif',
        'jpeg'
      ],
    );

    if (result != null) {
      String selectedExtension =
          result.files.first.extension?.toLowerCase() ?? "";

      if (allowedExtensions.contains(selectedExtension)) {
        setState(() {
          // Store the selected path in the new variable
          outputFilePath = result.files.first.path ?? "";
        });
      } else {
        // Show an alert dialog for inappropriate file extension
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("ERROR ⚠️"),
              content: Text("Please select an appropriate file."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }

    
    _trimPath(outputFilePath);
  }

  void _trimPath(String fullPath) {
    String pathWithoutPrefix = fullPath.replaceFirst("file:///", "");
    String directory = path.dirname(pathWithoutPrefix);
    String fileName = path.basename(pathWithoutPrefix);

    trimmedPath = path.join(directory, "");
    print(trimmedPath);
  }

  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        dialogTitle: 'Select A File You Would Like to Secure',
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
          'jpeg',
          'enc'
        ]);

    if (result != null) {
      String selectedExtension =
          result.files.first.extension?.toLowerCase() ?? "";

      if (allowedExtensions.contains(selectedExtension)) {
        setState(() {
          selectedFileName = result.files.first.name ?? "";
          fileExt = selectedExtension;
          filePath = result.files.first.path ?? "";
        });
      } else {
        // Show an alert dialog for inappropriate file extension
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("ERROR ⚠️"),
              content: Text("Please select an appropriate file."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }

    // isClicked = 1;
    // if(isClicked == 1){
    //   btnTxt = "Output Path";
    //   isClicked = 0;
    // }
    // if(isClicked == 0){
    //   btnTxt = "Select File";
    // }
  }

  void _submitKey() {
    if (keyController.text.isNotEmpty) {
      setState(() {
        submittedKey = keyController.text;
      });

      // final inputPath = filePath.toNativeUtf8();
      // final outputPath = trimmedPath.toNativeUtf8();
      // final password = submittedKey.toNativeUtf8();

      // if (fileExt != "txt" && fileExt != "enc") {
      //   aesCPUEncryptTime = double.parse(
      //       aesCPUEncrypt(inputPath, outputPath, password).toStringAsFixed(2));
      //   print("AES Encryption Time = $aesCPUEncryptTime ms");
      // } else if (fileExt == "txt") {
      //   aesCPUHuffmanEncryptTime = double.parse(
      //       aesCPUHuffmanEncrypt(inputPath, outputPath, password)
      //           .toStringAsFixed(2));
      //   print("AES + Huffman Encryption Time = $aesCPUHuffmanEncryptTime ms");
      // } else if (fileExt == "enc" && !selectedFileName.contains("txt.enc")) {
      //   aesCPUDecryptTime = double.parse(
      //       aesCPUDecrypt(inputPath, outputPath, password).toStringAsFixed(2));
      //   print("AES Decryption Time = $aesCPUEncryptTime ms");
      // } else if (fileExt == "enc" && selectedFileName.contains("txt.enc")) {
      //   aesCPUHuffmanDecryptTime = double.parse(
      //       aesCPUHuffmanDecrypt(inputPath, outputPath, password)
      //           .toStringAsFixed(2));
      //   print("AES + Huffman Decryption Time = $aesCPUHuffmanDecryptTime ms");
      // }

      // calloc.free(password);
      // calloc.free(outputPath);
      // calloc.free(inputPath);

      // //FOR BENCHMARKING MODE ONLY!!!!!!!
      //   if(title == "Benchmarking"){
      //     Navigator.of(context).push(
      //               MaterialPageRoute(
      //                 builder: (context) => BenchMark_Results(
      //                   selectedFileName: selectedFileName,
      //                   fileExt: fileExt,
      //                   filePath: filePath,
      //                   submittedKey: submittedKey,
      //                   outputFilePath: trimmedPath,
      //                 ),
      //               ),
      //     );
      //   }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("⚠️"),
            content: Text("Password cannot be empty"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
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
        title: Text('GPGPU Based File Encryption'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _openFilePicker,
                  child: Text('Select File'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(180, 60),
                    textStyle: const TextStyle(
                      fontFamily: "Cascadia Code",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _selectPath,
                  child: Text('Output Path'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(180, 60),
                    textStyle: const TextStyle(
                      fontFamily: "Cascadia Code",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),

            //  DEBUGGING
            // ------------------------------------------------------------------
            //SizedBox(height: 20),
            // Text(
            //   "Output Path: " + trimmedPath,
            //   style: TextStyle(fontSize: 18),
            // ),
            // Text(
            //   "Mode: " + title,
            //   style: TextStyle(fontSize: 18),
            // ),
            // Text(
            //   selectedFileName,
            //   style: TextStyle(fontSize: 18),
            // ),
            // Text(
            //   "Extension: " + fileExt,
            //   style: TextStyle(fontSize: 18),
            // ),
            // Text(
            //   "Path: " + filePath,
            //   style: TextStyle(fontSize: 18),
            // ),
            SizedBox(height: 20),
            Text(
              'Enter Password:',
              style: TextStyle(fontSize: 18),
            ),
            // SizedBox(height: 10),
            // ------------------------------------------------------------------

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 300, vertical: 20),
              child: TextField(
                controller: keyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Password:',
                  counterText: '',
                ),
                maxLength: 16,
                minLines: 1,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _submitKey();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password Entered'),
                  ),
                );
              },
              child: const Text('Submit Password'),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(180, 60),
                textStyle: const TextStyle(
                  fontFamily: "Cascadia Code",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            
            
            //DEBUG
            // Text(
            //   submittedKey,
            //   style: TextStyle(fontSize: 18),
            // ),
          ],
        ),
      ),
    );
  }
}
