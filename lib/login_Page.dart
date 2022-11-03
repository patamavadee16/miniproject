import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formstate = GlobalKey<FormState>();
  String? email;
  String? password;
  final auth = FirebaseAuth.instance;
  String? message;
  String channelId = "1000";
  String channelName = "FLUTTER_NOTIFICATION_CHANNEL";
  String channelDescription = "FLUTTER_NOTIFICATION_CHANNEL_DETAIL";


  @override
  initState() {
    message = "No message.";

    var initializationSettingsAndroid =
        AndroidInitializationSettings('noti');

    var initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) async {
      print("onDidReceiveLocalNotification called.");
    });

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
      // when user tap on notification.
      print("onSelectNotification called.");
      setState(() {
        message = payload.payload;
      });
    });

    super.initState();
  }
  sendNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '10000',
      'FLUTTER_NOTIFICATION_CHANNEL',
      channelDescription: 'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        111, 'Sodsai shop', 'enjoy to shopping', platformChannelSpecifics,
        payload: 'I just haven\'t Met You Yet');
  }

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        
        key: _formstate,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 50),
              width: w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Container(
                    width: 160,
                    height: 160,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                      image:AssetImage('assets/logo1.png'),
                      alignment: Alignment.center,
                      fit: BoxFit.fitHeight,
                      )
                    ),
                  ),
                // ignore: prefer_const_constructors
                  Text('Welcome',
                    style: const TextStyle(color: Color.fromARGB(255, 245, 	173,172 ),
                      fontSize: 45,
                      fontFamily: 'Mitr'
                    ),
                  ), 
                  const Text('Hello! Welcome to Sodsai Shop.',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Mitr'
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Card(
                    elevation: 5,
                    color: Color.fromARGB(255, 245, 244, 244),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const SizedBox(height: 10,),
                      emailTextFormField(),
                      const SizedBox(height: 20,),
                      passwordTextFormField(),
                      ],
                    ),
                  ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(child: loginButton()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      forgotPasswordButton(context),
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text("Don't have account?",
                          style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Mitr'
                          ),
                        ),
                        registerButton( context),
                      ],
                    ),
                  ),
                const SizedBox(height: 10,),
                
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  ElevatedButton loginButton() {
    return ElevatedButton(
          onPressed: () async {
            // sendNotification();
          if (_formstate.currentState!.validate()) {
            print('Valid Form');
            _formstate.currentState!.save();
            try {
              await auth
                  .signInWithEmailAndPassword(
                      email: email!, password: password!)
                  .then((value) {
                if (value.user!.emailVerified) {
                  sendNotification();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login Pass")));
                      Navigator.pushNamed(context, '/homepage');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please verify email")));
                }
              }).catchError((reason) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Email or Password Invalid")));
              });
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            }
          } else
            print('Invalid Form');
        },
          style: ElevatedButton.styleFrom(
          primary:const Color.fromARGB(255, 245, 	173,172 ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),),
              child: const Text('Login',style: TextStyle(color: Colors.white),),
      );
  }
   TextButton no(BuildContext context) {
    return TextButton(
      // ignore: prefer_const_constructors
      child: Text('Forgot Password?',
        style: const TextStyle(
          color: Color.fromARGB(255, 216,78,78),
          fontFamily: 'Mitr'
          ),
        ),
      onPressed: () {
        sendNotification();
      },
    );
  }

  TextButton forgotPasswordButton(BuildContext context) {
    return TextButton(
      // ignore: prefer_const_constructors
      child: Text('Forgot Password?',
        style: const TextStyle(
          color: Color.fromARGB(255, 216,78,78),
          fontFamily: 'Mitr'
          ),
        ),
      onPressed: () {
        Navigator.pushNamed(context, '/forgotPasswordPage');
      },
    );
  }
  TextButton registerButton(BuildContext context) {
    return TextButton(
      // ignore: prefer_const_constructors
      child: Text('Register Now',
        style: const TextStyle(
          color: Color.fromARGB(255, 216,78,78),
          fontFamily: 'Mitr'
          ),
        ),
      onPressed: () {
        print('Goto  Regis pagge');
        Navigator.pushNamed(context, '/register');
      },
    );
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
      onSaved: (value) {
        password = value!.trim();
      },
      validator: (value) {
        if (value!.length < 8)
          return 'Please Enter more than 8 Character';
        else
          return null;
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration:  InputDecoration(
        labelText: 'Password',
        icon: const Icon(Icons.lock),
        hintText: ('Password'),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        )
      ),
    );
  }

  TextFormField emailTextFormField() {
    return TextFormField(
      onSaved: (value) {
        email = value!.trim();
      },
      validator: (value) {
        if (!validateEmail(value!)) {
          return 'Please fill in E-mail field';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
     decoration: InputDecoration(
        labelText: ('E-mail'),
        icon: const Icon(Icons.email),
        hintText: ('aaaa@mail'),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        )
      ),
    );
  }

  bool validateEmail(String value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return (!regex.hasMatch(value)) ? false : true;
  }
}
