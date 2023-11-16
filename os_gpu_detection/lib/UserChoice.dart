import 'package:flutter/material.dart';
import 'package:os_gpu_detection/FilePickLiveMode.dart';

import 'FilePickBenchMark.dart';


class UserChoice extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;

  UserChoice({
    required this.title,
    required this.imagePath,
    required this.description,
  });

 @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
                  width: 300,
                  height: 100,
            
                  child: Card(
                    color: Colors.blue,
                    child: Center(child: Text('Secure File',
                                  style: const TextStyle(
                                    fontFamily: "Cascadia Code",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  )
                                  )),
                  ),
    );
    return Scaffold(
        appBar: AppBar(title: Text('User Choice')
        
        ),
       
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FilePickBench(
                       title: "Benchmarking",
                       gpu: this.title,
                       imagePath: this.imagePath,
                       description: this.description,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: Card(
                    color: Colors.green,
                    child: Center(child: Text('Benchmarking',
                     style: const TextStyle(
                                    fontFamily: "Cascadia Code",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  )
                    )
                    
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FilePickLive(
                       title: "Secure File",
                       gpu: this.title,
                       imagePath: this.imagePath,
                       description: this.description,
                      ),
                    ),
                  );
                },
                child: sizedBox,
              ),
            ],
          ),
        ),
      );
    
  }
}
