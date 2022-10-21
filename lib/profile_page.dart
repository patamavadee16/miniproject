

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Profile extends StatefulWidget {
  const Profile ( {Key? key});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
 TextEditingController ?_firstname ;
  TextEditingController ?_lastname ;
  TextEditingController ?_phone ;
  TextEditingController ?_dateOfbirth ;
  TextEditingController ?_gender;
  TextEditingController ?_age ;
File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            var data = snapshot.data;
            if(data==null){
              return Center(child: CircularProgressIndicator(),);
            }
            return  Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () => chooseImage(ImageSource.camera),
          ),
                    Container(
              width: 70,
              height: 70,
              child: file==null?Image.asset('assets/icons-account.png'):Container(child: Image.file(file!),width: 30,),
            ),IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: () => chooseImage(ImageSource.gallery),
          ),
                  ],
                ),  
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Profile',
                        style: TextStyle(color: Color.fromARGB(255, 245, 	173,172 ),
                          fontSize: 50,
                          fontFamily: 'FuzzyBubbles'
                        ),
                      ),
                    IconButton(onPressed: (){Navigator.pushNamed(context, '/editProfile_page');}, icon: Icon(Icons.edit_outlined),)     
                ],
              ),
                Card(
                  margin: EdgeInsets.only(left: 40,right: 40,top:20),
                  elevation: 5,
                  color: Color.fromARGB(255, 245, 244, 244),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  ),child :Column(
                  children: [
                    ListTile(
                      leading: Text("First Name"),
                      trailing: Text(data['firstname']),
                    ),
                    ListTile(
                      leading: Text("Last Name"),
                      trailing: Text(data['lastname']),
                       
                    ),ListTile(
                      leading: Text("Phone"),
                      trailing: Text(data['phone']),
                    ),ListTile(
                      leading: Text("Age"),
                      trailing: Text(data['age']),
                    ),ListTile(
                      leading: Text("Gender"),
                      trailing: Text(data['gender']),
                    ),ListTile(
                      leading: Text("Date Of Birth"),
                      trailing: Text(data['dateOfbirth']),
                    ),
                  ],
                ),),
              ],
            );
          },

        ),
      )),
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
}