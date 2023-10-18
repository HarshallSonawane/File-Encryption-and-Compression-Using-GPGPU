import 'package:flutter/material.dart';
import 'package:os_gpu_detection/FilePick.dart';


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
                      builder: (context) => FilePick(
                       title: "Benchmarking",
                       gpu: this.title,
                       imagePath: this.imagePath,
                       description: this.description,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 200,
                  height: 100,
                  child: Card(
                    color: Colors.blue,
                    child: Center(child: Text('Benchmarking')),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FilePick(
                       title: "Live Work",
                       gpu: this.title,
                       imagePath: this.imagePath,
                       description: this.description,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 200,
                  height: 100,
                  child: Card(
                    color: Colors.green,
                    child: Center(child: Text('Live Work')),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    
  }
}
