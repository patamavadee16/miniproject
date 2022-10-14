import 'package:miniproject_1/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPage createState() => _ForgetPasswordPage();
}

class _ForgetPasswordPage extends State<ForgetPasswordPage> {
  final _formstate = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();


  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        PreferredSize( //wrap with PreferredSize
          preferredSize: Size.fromHeight(70), //height of appbar
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                title:Text("Forget Password"), //appbar title
                backgroundColor: Color.fromARGB(255, 245, 	173,172 ) //appbar background color
              ),
            ],
          )
        ),
      body: Form(
        // key: _formstate,
        child: ListView(
          
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
             
            Container(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('RESET YOUR PASSWORD',
              style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold
              ),
            ),
                SizedBox(height: 10),
                enterEmailField(),
            // ignore: prefer_const_constructors
            Text('*Please enter your email address',
              style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold
              ),
            ),
           
              ],
            ),
            ),
             submitButton(),
            Center(
              child: Container(
                //  width:5,
                height: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                  image:AssetImage('assets/kitty.gif'),
                  // fit: BoxFit.cover,
                  alignment: Alignment.center,
                  )
                ),
              ),
            ),
           Center(
              child:Text('Check the text in your email inbox to  reset password.',
              style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold
              ),
            ),)
           
          ],
        ),
      )
    );
  }


//RegisterButton
   RaisedButton submitButton() {
    return RaisedButton(
      
      onPressed: () async {
        print('Reset Password');
        print(email.text);
        sendPasswordResetEmail(email.text);
        
        // ignore: use_build_context_synchronously
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => const LoginPage()),
        //     ModalRoute.withName('/'));
      },
      color: Color.fromARGB(255, 245, 	173,172 ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Text(
            'submit',
            style: TextStyle(color: Colors.white),
          ),
    );
  }


// Email 
  TextFormField enterEmailField() {
    return TextFormField(
      controller: email,
      onSaved: (value) {
        email = value!.trim() as TextEditingController;
      },
      validator: (value) {
        if (!validateEmail(value!))
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
Future sendPasswordResetEmail(String email) async {
    return auth.sendPasswordResetEmail(email: email);
  }
}

// Gender,Birth Date
bool validateEmail(String value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return (!regex.hasMatch(value)) ? false : true;
  }
