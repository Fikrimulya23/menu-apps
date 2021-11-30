import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_apps/const.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({Key? key}) : super(key: key);

  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  File imageFile = File("");
  final picker = ImagePicker();
  final String url = "$baseURL/api/upload";

  Future getImageFromGallery() async {
    /* var pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    ); */
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromCamera() async {
    var pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah menu"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  // controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "email",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                height: 200,
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  // controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "deskripsi",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  // controller: _emailController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "harga",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  // print("object");
                  getImageFromGallery();
                  /* Get.bottomSheet(
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          ListTile(
                            leading: Icon(Icons.camera),
                            title: Text("Kamera"),
                            onTap: () {
                              /* getImageFromCamera();
                              Get.back();
                              setState(() {}); */
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.image),
                            title: Text("Galeri"),
                            onTap: () {
                              /* getImageFromGallery();
                              Get.back();
                              setState(() {}); */
                            },
                          ),
                        ],
                      ),
                    ),
                  ); */
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 3,
                    ),
                  ),
                  child: Icon(Icons.add),
                  /* child: (imageFile == null)
                      ? Icon(Icons.add)
                      : Image.file(imageFile!) */
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Upload",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
