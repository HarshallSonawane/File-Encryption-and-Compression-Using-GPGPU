import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:file_selector/file_selector.dart';
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
    required int gpuOffset,
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

  TextEditingController _passwordController = TextEditingController();
  bool hide = true;

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
  final bool _isIOS = !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;


  Future<void> _getDirectoryPath() async {
    const String confirmButtonText = 'Choose';
    final String? directoryPath = await getDirectoryPath(
      confirmButtonText: confirmButtonText,
    );
    if (directoryPath == null) {
      // Operation was canceled by the user.
      return;
    }
    logger.i("Output Path --> $directoryPath");
    
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
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("ERROR ⚠️"),
              content: const Text("Please select an appropriate file."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
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
            title: const Text("⚠️"),
            content: const Text("Password cannot be empty"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
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

  bool _isObscured = true;
    void _toggle() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPGPU Based File Encryption'),
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
                  child: const Text('Select File'),
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
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isIOS ? null : () => _getDirectoryPath(),
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
                  child: const Text('Output Path'),
                ),
              ],
            ),

            //  DEBUGGING
            // ------------------------------------------------------------------
            // SizedBox(height: 20),
            // Text(
            //   "Output Path: " +outputP ,
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
            const SizedBox(height: 20),
            
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 300, vertical: 20),
              child: TextField(
                controller: keyController,
                obscureText: _isObscured,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Password:',
                  hintText: 'Enter Pasword',
                  counterText: '',
                //   suffixIcon: IconButton(icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
                  // onPressed: (){
                  //   setState(() {
                  //     _isObscured = !_isObscured;
                  //   });
                  // },
                // ),
                ),
                maxLength: 16,
                minLines: 1,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _submitKey();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password Entered'),
                  ),
                );
              },
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
              child: const Text('Enter Password'),
            ),
            const SizedBox(height: 20),

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
