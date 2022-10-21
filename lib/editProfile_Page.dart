import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formstate = GlobalKey<FormState>();
  TextEditingController ?_firstName;
  TextEditingController ?_lastName;
  TextEditingController ?_phone;
  TextEditingController ?_age;
  File? file;
  setDataToTextField(data){
    return  Form(
      key: _formstate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        firstNameField(data),
        lastNameField(data),
        phoneField(data),
        ageField(data),
        Row(
          children: [
            Expanded(
              child: updateButton(),),
          ],
        )
      ],
    ),);
  }

  ElevatedButton updateButton() {
    return ElevatedButton(
            onPressed: (){
            updateData();},
            style: ElevatedButton.styleFrom(
          primary:const Color.fromARGB(255, 245, 	173,172 ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),),
     child: Text("Update"));
  }

  TextFormField phoneField(data) {
    return TextFormField(
        controller: _phone = TextEditingController(text: data['phone']),
        validator: (value) {
      if (value!.isEmpty) {
        return 'Please fill in phone number field';
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      labelText: ('Phone Number'),
      // icon: const Icon(Icons.phone_enabled_outlined),
      hintText: ('enter your phone number '),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      )
    ),
      );
  }

  TextFormField ageField(data) {
    return TextFormField(
        controller: _age = TextEditingController(text: data['age']),
        validator: (value) {
      if (value!.isEmpty) {
        return 'Please fill in age field';
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      labelText: ('Age'),
      // icon: const Icon(Icons.number),
      hintText: ('enter your age '),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      )
    ),
      );
  }

  TextFormField lastNameField(data) {
    return TextFormField(
        controller: _lastName = TextEditingController(text: data['lastname']),
        validator: (value) {
      if (value!.isEmpty)
        return 'Please fill in lastname field';
      else
        return null;
    },
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      labelText: ('Last name'),
      // icon: const Icon(Icons.email),
      hintText: ('enter your lastname '),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      )
    ),
      );
  }

  TextFormField firstNameField(data) {
    return TextFormField(
        controller: _firstName = TextEditingController(text: data['firstname']),
        validator: (value) {
      if (value!.isEmpty) {
        return 'Please fill in lastname field';
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      labelText: ('Last name'),
      // icon: const Icon(Icons.email),
      hintText: ('enter your lastname '),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      )
    ),
      );
  }

  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "firststname":_firstName!.text,
          "lastname":_lastName!.text,
          "phone":_phone!.text,
          "age":_age!.text,
        }
        ).then((value) => print("Updated Successfully"));
  }


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
            return setDataToTextField(data);
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