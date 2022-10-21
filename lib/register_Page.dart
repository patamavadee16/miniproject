import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formstate = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obscureText = true;
  final auth = FirebaseAuth.instance;

  
  @override
  Widget build(BuildContext context) {
    dynamic route;
    return Scaffold(
      body: Form(
        key: _formstate,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            const SizedBox(height: 100,),
                // ignore: prefer_const_constructors
                  Text('Register Account',
                    style: const TextStyle(color: Color.fromARGB(255, 245, 	173,172 ),
                      fontSize: 30,
                      fontFamily: 'Mitr',
                      fontWeight: FontWeight.bold,
                    ),
                  ), const SizedBox(height: 20,),
                  const Text('Hello! Welcome to Sodsai Shop.',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Mitr'
                    ),
                  ), const SizedBox(height: 20,),
            Card(
              elevation: 5,
              color: Color.fromARGB(255, 245, 244, 244),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              ),
              
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
             buildEmailField(),
             const SizedBox(height: 20,),
             buildPasswordField(),
            
                  ],
                ),
              ),
            
            ),
            const SizedBox(height: 20,),
            
            // ignore: prefer_const_constructors
            
            
            // ListTile(
            //   title: const Text('Birthdate',style: TextStyle(
            //     fontWeight: FontWeight.bold
            //   )),
            //   subtitle: buildDateField(),
            // ),
            // // ignore: prefer_const_constructors
            // ListTile(
            //   title: const Text('Gender',
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold
            //     )
            //   ),
            //   subtitle: MyRadioGender(),
            // ),
            buildRegisterButton(),
            // const SizedBox(height: 100,),
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
               // ignore: prefer_const_literals_to_create_immutables
               children: [
                 const Text("Already have an account?",
                          style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                        backTolocgin_click(context),
                      ],
                    ),
            const SizedBox(height: 30,),
             Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                image: DecorationImage(
                image:AssetImage('assets/iconsshop.png'),
                // fit: BoxFit.cover,
                alignment: Alignment.center,
                fit: BoxFit.fitHeight
                )
              ),
            ),
          ],
        ),
      )
    );
  }


//RegisterButton
   ElevatedButton buildRegisterButton() {
    return ElevatedButton(
      onPressed: ()
       async {if (_formstate.currentState!.validate()){
         try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim()
          
      );
      userCredential.user!.sendEmailVerification();
      var authCredential = userCredential.user;
      
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Navigator.pushNamed(context, '/userForm');
      }
      else{
        Fluttertoast.showToast(msg: "Something is wrong");
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");

      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "The account already exists for that email.");

      }
    } catch (e) {
      print(e);
    }
       }else
            print('Invalid Form');
      },
      style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 245, 	173,172 ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),),
      child: const Text('Register',style:TextStyle(color: Colors.white,fontSize: 20)
       ),
    );
  }


 TextButton backTolocgin_click(BuildContext context) {
    return TextButton(
      // ignore: prefer_const_constructors
      child: Text('Login ',
        style: TextStyle(
          color: Color.fromARGB(255, 216,78,78)
          ),
        ),
      onPressed: () {
        print('Goto  Login pagge');
        Navigator.pushNamed(context, '/');
      },
    );
  }
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
        icon: Icon(Icons.lock),
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
        if (!validateEmail(value!))
          return 'Please fill in E-mail field';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'E-mail',
        icon: Icon(Icons.email),
        hintText: 'x@x.com',
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
    bool validateEmail(String value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return (!regex.hasMatch(value)) ? false : true;
  }
}

