import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('go to login screen'),
              trailing: IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Results'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          //to show image, you type like this.
                          File(image!.path),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                      ),
                    )
                  : const Text(
                      "No Image",
                      style: TextStyle(fontSize: 20),
                    ),
              const SizedBox(
                height: 100,
              ),
              //if image not null show the image
              //if image null show text
              Container(
                height: 100.0,
                width: 400.0,
                margin: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    // borderSide: const BorderSide(width: 4.0),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "Results : ",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),

              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  fixedSize: const MaterialStatePropertyAll(
                    Size(150.0, 40.0),
                  ),
                  elevation: const MaterialStatePropertyAll(10.0),
                ),
                onPressed: () {
                  //  File(image!.path);
                },
                icon: const Icon(Icons.print),
                label: const Text('Print Result'),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  fixedSize: const MaterialStatePropertyAll(
                    Size(150.0, 40.0),
                  ),
                  elevation: const MaterialStatePropertyAll(10.0),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/upload');
                },
                icon: const Icon(Icons.create_new_folder),
                label: const Text('New Image'),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
