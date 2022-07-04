import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Demo Media',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  // FilePickerResult? image;

  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],

      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Image Picker Test', style: TextStyle(color: Color(0xFF303F9F), fontSize: 28, fontWeight: FontWeight.w500)),

              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(12),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF6),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4,
                      spreadRadius: 4,
                      offset: const Offset(0, 1)
                    )
                  ]
                ),
                child: image != null ? 
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    image: DecorationImage(image: NetworkImage(image!.path), fit: BoxFit.cover)
                  ),
                ) 
                : const FlutterLogo(size: 100)
              ),
      
              const SizedBox(height: 20),
      
              SizedBox(
                height: 40,
                width: 200,
                child: ElevatedButton(
                  onPressed: pickImage, 
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    )
                  ),
                  child: const Text('Add image', style: TextStyle(color: Colors.white))
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}