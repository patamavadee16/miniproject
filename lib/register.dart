import 'package:miniproject_1/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formstate = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    dynamic route;
    return Scaffold(
      appBar: 
        PreferredSize( //wrap with PreferredSize
          preferredSize: Size.fromHeight(70), //height of appbar
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                title:Text("Sign Up"), //appbar title
                backgroundColor: Color.fromARGB(255, 245, 	173,172 ) //appbar background color
              ),
            ],
          )
        ),
      body: Form(
        key: _formstate,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            // ignore: prefer_const_constructors
            Center(
              child: const Text('Information',
                      style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                      ),
                    ),
            ),
            ListTile(
              title: const Text('FirstName',style: TextStyle(
                fontWeight: FontWeight.bold
              )),
              subtitle: firstName(),
              ),
            ListTile(
              title: const Text('Lastname',style: TextStyle(
                fontWeight: FontWeight.bold
              )),
              subtitle: lastName(),
            ),
            ListTile(
              title: const Text('Email',style: TextStyle(
                fontWeight: FontWeight.bold
              )),
              subtitle: buildEmailField(),
            ),
            ListTile(
              title: const Text('Password',style: TextStyle(
                fontWeight: FontWeight.bold
              )),
              subtitle: buildPasswordField(),
            ),
            ListTile(
              title: const Text('Birthdate',style: TextStyle(
                fontWeight: FontWeight.bold
              )),
              subtitle: buildDateField(),
            ),
            // ignore: prefer_const_constructors
            ListTile(
              title: const Text('Gender',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                )
              ),
              subtitle: MyRadioGender(),
            ),
            buildRegisterButton(),
          ],
        ),
      )
    );
  }
//firstName
  TextFormField firstName() {
    return TextFormField(
      onSaved: (value) {
  
      },
      validator: (value) {
        // if (!validateEmail(value!))
        //   return 'Please fill in E-mail field';
        // else
        //   return null;
      },
      // keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: ('First Name'),
        // icon: const Icon(Icons.person),
        hintText: ('First Name'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        )
      ),
    );
  }

//lastName
  TextFormField lastName() {
    return TextFormField(
      onSaved: (value) {

      },
      validator: (value) {
        // if (!validateEmail(value!))
        //   return 'Please fill in E-mail field';
        // else
        //   return null;
      },
      // keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: ('last Name'),
        // icon: const Icon(Icons.person),
        hintText: ('last Name'),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        )
      ),
    );
  }

//RegisterButton
   ElevatedButton buildRegisterButton() {
    return ElevatedButton(
      child: const Text('Register'),
      onPressed: () async {
        print('Regis new Account');
        if (_formstate.currentState!.validate())
        print(email.text);
        print(password.text);
        final _user = await auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
        _user.user!.sendEmailVerification();
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            ModalRoute.withName('/'));
      },
    );
  }
  //  if (_formstate.currentState!.validate()) {
  //           print('Valid Form');
  //           _formstate.currentState!.save();
  //           try {
  //             await auth
  //                 .signInWithEmailAndPassword(
  //                     email: email!, password: password!)
  //                 .then((value) {
  //               if (value.user!.emailVerified) {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                     const SnackBar(content: Text("Login Pass")));
  //                     Navigator.pushNamed(context, '/homepage');
  //               } else {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                     const SnackBar(content: Text("Please verify email")));
  //               }
  //             }).catchError((reason) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(content: Text("Login or Password Invalid")));
  //             });
  //           } on FirebaseAuthException catch (e) {
  //             if (e.code == 'user-not-found') {
  //               print('No user found for that email.');
  //             } else if (e.code == 'wrong-password') {
  //               print('Wrong password provided for that user.');
  //             }
  //           }
  //         } else
  //           print('Invalid Form');
// Password
  TextFormField buildPasswordField() {
    return TextFormField(
      controller: password,
      validator: (value) {
        if (value!.length < 8)
          return 'Please Enter more than 8 Character';
        else
          return null;
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: ('Password'),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        )
      ),
      
    );
  }
// Email 
  TextFormField buildEmailField() {
    return TextFormField(
      controller: email,
      validator: (value) {
        if (value!.isEmpty)
          return 'Please fill in E-mail field';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'E-mail',
        // icon: Icon(Icons.email),
        hintText: 'x@x.com',
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

// Gender,Birth Date
class MyRadioGender extends StatefulWidget {
  const MyRadioGender({Key? key}) : super(key: key);

  @override
  _MyRadioGenderState createState() => _MyRadioGenderState();
}

class _MyRadioGenderState extends State<MyRadioGender> {
  dynamic route;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              Radio(
                value: 1,
                groupValue: route,
                onChanged: (value) {
                  setState(() {
                    route = value;
                  });
                },
              ),
              const Text('Male'),
              Radio(
                value: 0,
                groupValue: route,
                onChanged: (value) {
                  // _handleTapboxChanged(value);
                  setState(() {
                    route = value;
                  });
                },
              ),
              const Text('Female'),
              ]
            ),
            // Row(
            //   children: [
            //   Text('$route'),
            //   ]
            // ),
            

          ]
      ),
    );
  }
  // Birthdate
    
}
final _format = DateFormat('dd/MM/yyyy');
DateTimeField buildDateField() {
    return DateTimeField(
      decoration: InputDecoration(
        // labelText: 'Birth Date',
        hintText: ('Birth Date'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        )
      ),
      format: _format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
    );
  }