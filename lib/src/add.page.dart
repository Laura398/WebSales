// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:websales/main.dart';
import 'package:image_picker/image_picker.dart';

import 'home.page.dart';

import 'package:flutter/services.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => AddState();
}

DateTime dateToShow = DateTime.now();

class AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add auction',
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
          const Padding(padding: EdgeInsets.all(10)),
          imageProduct(),
          const Padding(padding: EdgeInsets.all(20)),
          TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(18),
              labelText: 'Titre',
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
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(children: <Widget>[
              Container(
                width: 150,
                margin: const EdgeInsets.only(left: 0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(18),
                    labelText: 'Prix',
                    labelStyle: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
              const Tab(icon: Icon(Icons.euro_symbol)),
            ]),
          ),
          const Padding(padding: EdgeInsets.all(12)),
          InkWell(
            onTap: () async {
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: dateToShow,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (newDate == null) return;
              setState(() {
                dateToShow = newDate;
              });
            },
            child: Column(
              children: [
                Text(
                  'Choisir une date de fin d\'enchère :',
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '${dateToShow.day.toString().padLeft(2, '0')}/${dateToShow.month.toString().padLeft(2, '0')}/${dateToShow.year}',
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Row(children: <Widget>[
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
                    borderRadius: BorderRadius.circular(1)),
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 100, right: 140)),
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
                    borderRadius: BorderRadius.circular(1)),
              ),
            )
          ])
        ],
      ),
    );
  }

  Widget imageProduct() {
    return Center(
      child: Stack(
        children: <Widget>[
          _image == null
              ? Container(
                  padding: const EdgeInsets.only(left: 0),
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 4,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.only(left: 0),
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      image: DecorationImage(
                        image: FileImage(File(_image!.path)),
                        fit: BoxFit.cover,
                      )),
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
                    size: 32,
                  ))),
        ],
      ),
    );
  }

  Widget bottomSheet(context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(children: <Widget>[
        const Text(
          'Choisissez une image',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
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
