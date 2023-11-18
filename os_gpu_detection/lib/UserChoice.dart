import 'package:flutter/material.dart';
import 'package:os_gpu_detection/FilePickLiveMode.dart';
import 'FilePickBenchMark.dart';

class UserChoice extends StatelessWidget {
  final String title;
  final String imagePath;
  final String gpuName;
  int gpuoffest;
  var black;

  UserChoice({
    required this.title,
    required this.imagePath,
    required this.gpuName,
    required this.gpuoffest,
  });

  @override
  Widget build(BuildContext context) {
    Color benchmarkingCardColor =
        gpuName.toLowerCase() == 'nvidia' ? Colors.green : Colors.deepOrange;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Choice'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Select Your Preferred Mode Of Operation',
              style: TextStyle(
                fontFamily: "Cascadia Code",
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
              ),
            ),
          ),
          
          SizedBox(height: 30),
          // Row of cards
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Secure File Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blue,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FilePickLive(
                          title: "Secure File",
                          gpu: this.title,
                          imagePath: this.imagePath,
                          description: this.gpuName,
                          gpuName: gpuName,
                          gpuoffest: gpuoffest
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 300,
                    padding: EdgeInsets.all(16),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.security, size: 100, color: Colors.black),
                        SizedBox(height: 30),
                        Text(
                          'Secure File',
                          style: TextStyle(
                            fontFamily: "Cascadia Code",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Benchmarking Card
              Card(
                color: benchmarkingCardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FilePickBench(
                          title: "Benchmarking",
                          gpu: this.title,
                          imagePath: this.imagePath,
                          description: this.gpuName,
                          gpuName: gpuName,
                          gpuoffest: gpuoffest
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 300,
                    padding: EdgeInsets.all(16),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.speed, size: 100, color: Colors.black),
                        SizedBox(height: 30),
                        Text(
                          'Benchmarking',
                          style: TextStyle(
                            fontFamily: "Cascadia Code",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
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
    );
  }
}
