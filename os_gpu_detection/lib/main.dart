import "dart:io";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:os_gpu_detection/UserChoice.dart';
import "dart:ffi";
import "package:window_manager/window_manager.dart";
import "package:logger/logger.dart";
import "package:flutter_window_close/flutter_window_close.dart";
import "package:path/path.dart" as path;
import "gpu_info.dart";
import "dart:ui" as ui;
import "lib.dart";

int gpuoffest = 0;
int gpuCount = 0;
List<String> gpuList = [];
var logger = Logger(
  printer: PrettyPrinter(),
);
const appName = "Data Compression and Encryption using GPGPU";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WindowOptions windowOptions = const WindowOptions(
      size: ui.Size(1000, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      fullScreen: true,
      windowButtonVisibility: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });

    // Linux GPU Detection
    if (Platform.isLinux) {
      gpuInfoLibPath =
          path.join(Directory.current.path, "ffi_lib", "libGPUInfo.so");
      gpuInfoDynamicLib = DynamicLibrary.open(gpuInfoLibPath);
      final RunGPUScript runGPUScript = gpuInfoDynamicLib
          .lookup<NativeFunction<RunGPUScriptFunc>>("run_gpu_script")
          .asFunction();
      runGPUScript();
    }

    // DCAEUG CPU
    if (Platform.isWindows) {
      cpuLibPath = path.join(Directory.current.path, "ffi_lib", "DCAEUG.dll");
    } else if (Platform.isLinux) {
      cpuLibPath = path.join(Directory.current.path, "ffi_lib", "libDCAEUG.so");
    }

    cpuDynamicLib = DynamicLibrary.open(cpuLibPath);

    // DCAEUG Native Functions
    aesCPUEncrypt = cpuDynamicLib
        .lookupFunction<DartFunc, NativeFunc>('aes_cpu_encrypt_ffi');
    aesCPUDecrypt = cpuDynamicLib
        .lookupFunction<DartFunc, NativeFunc>('aes_cpu_decrypt_ffi');
    aesCPUHuffmanEncrypt = cpuDynamicLib
        .lookupFunction<DartFunc, NativeFunc>('aes_cpu_encrypt_huffman_ffi');
    aesCPUHuffmanDecrypt = cpuDynamicLib
        .lookupFunction<DartFunc, NativeFunc>('aes_cpu_decrypt_huffman_ffi');
  }

  FlutterWindowClose.setWindowShouldCloseHandler(() async {
    appExit();
    return true;
  });

  gpuCount = getGPUDetails();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    return MaterialApp(
        title: appName,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(appName),
            actions: <Widget>[
              TextButton(
                style: style,
                onPressed: () {
                  appExit();
                  exit(0);
                },
                child: const Text("Exit"),
              ),
            ],
          ),
          body: const GPUList(),
        ));
  }
}

class GPUList extends StatelessWidget {
  const GPUList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Select Your Preferred GPU",
              style: TextStyle(
                fontFamily: "Cascadia Code",
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < gpuList.length; i++)
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () {
                          print("Card Clicked!");
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              gpuList.elementAt(i),
                              style: const TextStyle(
                                fontFamily: "Cascadia Code",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (gpuList[i].contains("NVIDIA"))
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UserChoice(
                                        title: "Nvidia",
                                        imagePath: 'images/nvidia.png',
                                        gpuName: "Nvidia",
                                        gpuoffest: i,
                                      ),
                                    ),
                                  );
                                  print("Nvidia Clicked!");
                                },
                                child: Image.asset(
                                  'images/nvidia.png',
                                  height: 150,
                                  width: 150,
                                ),
                              ),
                            if (gpuList[i].contains("NVIDIA"))
                              const SizedBox(height: 10),
                            if (gpuList[i].contains("NVIDIA"))
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UserChoice(
                                        title: "Nvidia",
                                        imagePath: 'images/nvidia.png',
                                        gpuName: "You have Nvidia",
                                        gpuoffest: i,
                                      ),
                                    ),
                                  );
                                  print("Nvidia Clicked!");
                                },
                                child: const Text(
                                  "CUDA",
                                  style: TextStyle(
                                    fontFamily: "Cascadia Code",
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 118, 185, 0),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            if (gpuList[i].contains("AMD"))
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UserChoice(
                                          title: "AMD",
                                          imagePath: 'images/amd.png',
                                          gpuName: "You have AMD",
                                          gpuoffest: i),
                                    ),
                                  );
                                  print("AMD Clicked!");
                                },
                                child: Image.asset(
                                  'images/amd.png',
                                  height: 150,
                                  width: 150,
                                ),
                              ),
                            if (gpuList[i].contains("AMD"))
                              const SizedBox(height: 10),
                            if (gpuList[i].contains("AMD"))
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UserChoice(
                                          title: "AMD",
                                          imagePath: 'images/amd.png',
                                          gpuName: "You have AMD",
                                          gpuoffest: i),
                                    ),
                                  );
                                  print("AMD Clicked!");
                                },
                                child: const Text(
                                  "OpenCL",
                                  style: TextStyle(
                                    fontFamily: "Cascadia Code",
                                    fontSize: 20,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            if (gpuList[i].contains("Intel"))
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UserChoice(
                                          title: "Intel",
                                          imagePath: 'images/intel.png',
                                          gpuName: "You have Intel",
                                          gpuoffest: i),
                                    ),
                                  );
                                  print("Intel Clicked!");
                                },
                                child: Image.asset(
                                  'images/intel.png',
                                  height: 150,
                                  width: 150,
                                ),
                              ),
                            if (gpuList[i].contains("Intel"))
                              const SizedBox(height: 10),
                            if (gpuList[i].contains("Intel"))
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UserChoice(
                                          title: "Intel",
                                          imagePath: 'images/intel.png',
                                          gpuName: "You have Intel",
                                          gpuoffest: i),
                                    ),
                                  );
                                  print("Intel Clicked!");
                                },
                                child: const Text(
                                  "OpenCL",
                                  style: TextStyle(
                                    fontFamily: "Cascadia Code",
                                    fontSize: 20,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void appExit() {
  if (Platform.isLinux) {
    File("enum-gpu").deleteSync();
  }
}
