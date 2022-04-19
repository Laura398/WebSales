// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:websales/main.dart';
import 'package:image_picker/image_picker.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => AddState();
}

class AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add bid',
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, top: 20, right: 10),
        child: AddPage(),
      ),
    );
  }
}

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  PickedFile? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          const Padding(padding: EdgeInsets.all(12)),
          imageProduct(),
          const Padding(padding: EdgeInsets.all(25)),
          TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(18),
              labelText: 'Title',
              labelStyle: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(12)),
          TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(18),
              labelText: 'Description',
              labelStyle: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(12)),
          TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(18),
              labelText: 'Date fin d\'enchère',
              labelStyle: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(children: <Widget>[
              Container(
                width: 150,
                margin: const EdgeInsets.only(left: 0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(18),
                    labelText: 'Price',
                    labelStyle: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Container(
              child: Row(children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/',
                );
              },
              child: const Icon(Icons.cancel),
              style: TextButton.styleFrom(
                elevation: 10,
                minimumSize: const Size(100, 50),
                primary: Colors.white,
                backgroundColor: colorNav,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 120, right: 170)),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/',
                );
              },
              child: const Icon(Icons.done),
              style: TextButton.styleFrom(
                elevation: 10,
                minimumSize: const Size(100, 50),
                primary: Colors.white,
                backgroundColor: colorNav,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          ]))
        ],
      ),
    );
  }

  Widget imageProduct() {
    return Center(
      child: Stack(
        children: <Widget>[
          _image == null
              ? const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/logo2.png'))
              : CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(File(_image!.path)),
                ),
          Positioned(
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet(context)),
                    );
                  },
                  child: const Icon(
                    Icons.camera_alt,
                    color: colorNav,
                    size: 30,
                  ))),
        ],
      ),
    );
  }

  Widget bottomSheet(context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(children: <Widget>[
        const Text(
          'Choisissez une image',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: const Icon(Icons.camera),
              label: const Text('Camera'),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
            ),
            FlatButton.icon(
              icon: const Icon(Icons.image),
              label: const Text('Gallery'),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
            ),
          ],
        )
      ]),
    );
  }

  void takePhoto([ImageSource? source]) async {
    final pickedFile = await _picker.getImage(
      source: source!,
    );
    setState(() {
      _image = pickedFile;
    });
  }
}
