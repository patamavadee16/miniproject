// ignore_for_file: avoid_print, deprecated_member_use, unused_field
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miniproject_1/login_Page.dart';


class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _dateOfbirth = TextEditingController();
  final TextEditingController _age = TextEditingController();
 var  choosSex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(     
      body: Form(
        key: _form,
        child: ListView(
          padding: EdgeInsets.only(left: 40,right: 40,top:100),
          children: <Widget>[           
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                image: DecorationImage(
                image:AssetImage('assets/icons-edit-profile.png'),
                alignment: Alignment.center,
                fit: BoxFit.fitHeight
                )
              ),
            ), 
            const Center(
              child: Text('Create your profile.',
                      style: TextStyle(color: Color.fromARGB(255, 245, 	173,172 ),
                        fontSize: 25,
                        fontFamily: 'FuzzyBubbles',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ), 
            const SizedBox(height: 20,),
            firstNameTextFormField(), 
            SizedBox(height: 20,),
            lastNameTextFormField(), 
            SizedBox(height: 20,),
            phoneNumberTextFormField(), 
            SizedBox(height: 20,),
            dateOfBirth(), 
            SizedBox(height: 20,),
            ageTextFormField(), 
             const Text('  Gender',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 20,),),
            Gender(), 
            SizedBox(height: 20,),
            buildSaveButton()
          ],
        ),
      ),
    );
  }
 
 ElevatedButton buildSaveButton() {
    return ElevatedButton(    
        onPressed: () async {
          if (_form.currentState!.validate()) {
            print('save button press');
            Map<String, dynamic> data = {
              // "name":_nameController.text,
               "firstname":_firstname.text,
               "lastname":_lastname.text,
               "phone":_phone.text,
               "dateOfbirth":_dateOfbirth.text,
               "gender":choosSex.toString(),
               "age":_age.text,
               'url_picture':"",
               "email":FirebaseAuth.instance.currentUser!.email
            };
            try {
              final FirebaseAuth _auth = FirebaseAuth.instance;
              var  currentUser = _auth.currentUser;
              CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
             print(_firstname.toString());
                return _collectionRef.doc(currentUser!.email)
                      .set(data)
                      .then((value) =>
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage())));
            } catch (e) {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error $e'),
                ),
              );
            }
          } else {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please validate value'),
              ),
            );
          }
        },
      style: ElevatedButton.styleFrom(primary:const Color.fromARGB(255, 245, 	173,172 ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),),
      child: const Text('Save',style:TextStyle(color: Colors.white,fontSize: 20)),
      );
  }
  TextFormField firstNameTextFormField() {
    return TextFormField(
      controller:_firstname,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill in firstname field';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: ('Firstname'),
        hintText: ('enter your firstname '),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        )
      ),
    );
  }
  TextFormField lastNameTextFormField() {
    return TextFormField(
      controller:_lastname,
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
        hintText: ('enter your lastname '),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        )
      ),
    );
  }
  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null) {
      setState(() {
        _dateOfbirth.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
    }
  }
  
  TextFormField phoneNumberTextFormField() {
    return TextFormField(
      controller:_phone,
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
        hintText: ('enter your phone number '),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        )
      ),
    );
  }
  TextFormField dateOfBirth() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill in date Of Birth field';
        } else {
          return null;
        }
      },
      controller: _dateOfbirth,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Date of Birth",
                    suffixIcon: IconButton(onPressed: () => _selectDateFromPicker(context),icon: Icon(Icons.calendar_today_outlined),),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      )
                ),
    );
  }
  TextFormField ageTextFormField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill in age field';
        } else {
          return null;
        }
      },
      controller: _age,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: ('Age'),
        hintText: ('enter your age '),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        )
      ),
    );
  }
  Widget Gender() {
    return 
            Row(children: <Widget> [
              Radio(
                value: 'Male',
                groupValue: choosSex,
                onChanged: (value) {
                  setState(() {
                    choosSex = value;
                  });
                },
              ),
              const Text('Male'),
              Radio(
                value: 'Female',
                groupValue: choosSex,
                onChanged: (value) {
                  setState(() {
                    choosSex = value;
                  });
                },
              ),
              const Text('Female'),
              ]

    );
  }

}
