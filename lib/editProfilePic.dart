import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:miniproject_1/reviewPage.dart';

class EditProfilePic extends StatefulWidget {
  const EditProfilePic({super.key});

  @override
  State<EditProfilePic> createState() => _EditProfilePicState();
}

class _EditProfilePicState extends State<EditProfilePic> {
  final _form = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController  description= TextEditingController();
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 245, 	173,172 ),
              title: const Text('Edit Profile Picture',
                        style: TextStyle(color: Color.fromARGB(255, 247, 247, 247),
                          fontSize: 25,
                          fontFamily: 'Mitr'
                        ),
                      ),
            ),
      body:  Column(
        children: [
          groupImage(), buildSaveButton()
        ],
      ));
    
  }
Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      setState(() {
        file = File(object!.path);
      });
    } catch (e) {}
  }
    Widget groupImage() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () => chooseImage(ImageSource.camera),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: 250.0,
            height: 250,
            child: file == null
                ?Card(elevation: 5,
                    color: const Color.fromARGB(255, 245, 244, 244),
                    shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),child:Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                image: DecorationImage(
                image:AssetImage('assets/face-scan.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
                )
              ),
            ))
                : Container( 
                  width: 70,
                  height: 70,
                  child: Image.file(file!))
          ),
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: () => chooseImage(ImageSource.gallery),
          ),
        ],
      );
   ElevatedButton buildSaveButton() {
    return ElevatedButton(
        
        onPressed: () async {
           print('save button press');
           uploadPic();
          } ,

     style: ElevatedButton.styleFrom(
        primary:Color.fromARGB(255, 245, 	173,172 ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),),
      child: const Text('Save',style:TextStyle(color: Colors.white,fontSize: 20)
       ),);
  }
  Future uploadPic()async{
     Random random = Random();
    int i = random.nextInt(100);
    final path = 'ProfilePicture/$i.jpg';
   final ref =FirebaseStorage.instance.ref().child(path);
    final storageUploadTask = ref.putFile(file!);
    print('$path');
    print('pic$i.jpg');
    final snapshot = await storageUploadTask.whenComplete(() {});

  final urlPicture = await snapshot.ref.getDownloadURL();
  print('$urlPicture');
  updateData(urlPicture);
   
  }
  
    updateData(String urlPicture){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "url_picture": urlPicture
        }
        ).then((value) => print("Updated Successfully"));
  }
}