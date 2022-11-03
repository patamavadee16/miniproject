import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:miniproject_1/bottomNavi.dart';

class CreateReviewPost extends StatefulWidget {
  const CreateReviewPost({super.key});

  @override
  State<CreateReviewPost> createState() => _CreateReviewPostState();
}

class _CreateReviewPostState extends State<CreateReviewPost> {
  final _form = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController  description= TextEditingController();
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 245, 	173,172 ),
              title: const Text('Sodsai Shop',style: TextStyle(color: Color.fromARGB(255, 247, 247, 247),fontSize: 30,fontFamily: 'Mitr'))
            ),
    body:  Form(
      key: _form,
      child:ListView(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 70),
        children:[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text('New Post',style:  TextStyle(color: Color.fromARGB(255, 245, 	173,172 ),fontSize: 50,fontFamily: 'Mitr'),),          groupImage(),
                  const SizedBox(height: 30,),
                  titleTextFormField(),
                  const SizedBox(height: 30,),
                  descripTextFormField(),buildSaveButton()
                ],
              ),
          ]
        )
      )
    );
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
            child: file == null?
              Card(elevation: 5,color: const Color.fromARGB(255, 245, 244, 244),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                child:Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                  image:AssetImage('assets/face-scan.png'),
                  alignment: Alignment.center,
                  )
                  ),
                )
              ): Container( 
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
        TextFormField titleTextFormField() {
    return TextFormField(
      controller: title,
      validator: (value) {
        if (value!.isEmpty|| value.length > 100) {
          return 'Please fill in title field ';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.text,
      decoration:  InputDecoration(
        labelText: 'Name Item',
        icon: const Icon(Icons.title_rounded),
        hintText: ('ชื่อสินค้า'),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        )
      ),
    );
  }        
TextFormField descripTextFormField() {
    return TextFormField(
      minLines: 5,
      maxLines: null,
      controller: description,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill in title field ';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.text,
      decoration:  InputDecoration(
        labelText: 'Comment',
        icon: const Icon(Icons.text_snippet_sharp),
        hintText: ('Share your review'),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        )
      ),
    );
  }
ElevatedButton buildSaveButton() {
    return ElevatedButton(   
        onPressed: () async {
           print('save button press');
          if (_form.currentState!.validate()) {
            if(file!=null){
               uploadPost();
               }else{ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please choose picture')
                ),
              );
              }
            }

          } ,

     style: ElevatedButton.styleFrom(
        primary:const Color.fromARGB(255, 245, 	173,172 ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),),
      child: const Text('Save',style:TextStyle(color: Colors.white,fontSize: 20)
       ),);
  }
//upload image ไป firebase แล้ว get url
  Future uploadPost()async{
     Random random = Random();
    int i = random.nextInt(100);
    final path = 'ReviewPost/post$i.jpg';
   final ref =FirebaseStorage.instance.ref().child(path);
    final storageUploadTask = ref.putFile(file!);
    print('$path');
    print('post$i.jpg');
    final snapshot = await storageUploadTask.whenComplete(() {});

  final urlPicture = await snapshot.ref.getDownloadURL();
  print('$urlPicture');
  insertPost(urlPicture);
   
  }

  // insert
  Future<void> insertPost(String urlPicture)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;
    Map<String, dynamic> data = {
              "Email":currentUser!.email,
              "title": title.text,
              "desciption": description.text,
              "url_picture": urlPicture
    };
              CollectionReference collectionRef = FirebaseFirestore.instance.collection("users-review-post");
                return collectionRef.doc((FirebaseAuth.instance.currentUser!.email))
                .set(data)
                .then((value) =>
                Navigator.pushNamedAndRemoveUntil(context, '/reviewPage', ModalRoute.withName('/homepage')));
  }
}