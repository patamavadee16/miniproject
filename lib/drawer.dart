import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniproject_1/bottomNavi.dart';
import 'package:miniproject_1/order_Page.dart';


class SharedDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final authData = Provider.of<Auth>(context, listen: false);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: 
        
          UserAccountsDrawerHeader(accountEmail: data('email'), 
          accountName: data('firstname'),
           currentAccountPicture: Container(
            child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
                  builder: (context, AsyncSnapshot snapshot){
                    var data = snapshot.data;
                    if (snapshot.hasData) {
                return Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),
                    image: data['url_picture']==""?DecorationImage(image: AssetImage('assets/icons-account.png'),fit: BoxFit.cover):DecorationImage(image: NetworkImage(data['url_picture']),fit: BoxFit.cover)
                    ),
                );
                
                  } else {
                return CircularProgressIndicator();
              }}),
          ),
          decoration: 
            const BoxDecoration(
              color: Color.fromARGB(255, 245, 	173,172 ),
            ),
          ),),
          
          // Container(
          //   padding: EdgeInsets.only(top: 15),
          //   height: 200,
          //   color:  Color.fromARGB(255, 245, 	173,172 ),
          //   child: Column(
          //     // ignore: prefer_const_literals_to_create_immutables
          //     children: <Widget>[
          //       StreamBuilder(
          //         stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
          //         builder: (context, AsyncSnapshot snapshot){
          //           var data = snapshot.data;
          //           if(data!=null){
          //           return Column(
          //             children: [
          //          CircleAvatar(    
          //         maxRadius: 60,
          //         backgroundColor: Colors.grey,
          //         child:data['url_picture']==""?Container(
          //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),
          //           image: DecorationImage(image: AssetImage('assets/icons-account.png'),fit: BoxFit.cover)
          //           ),)
          //         :Container(
          //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),
          //           image: DecorationImage(image: NetworkImage(data['url_picture']),fit: BoxFit.cover)
          //           ),)
                    
          //       ),SizedBox(height: 10,),Text(data['firstname']+data['lastname'])

          //             ],
          //           );
          //   }
          //           return Column(
          //             children: [
          //             ],
          //           );
          //         }),
        
                 
          //       const SizedBox(height: 10),
          //     ],
          //   ),
          // ),
          ListTile(
            leading: Icon(Icons.home),
            trailing: Icon(Icons.navigate_next),
            // ignore: prefer_const_constructors
            title: Text(
              'Home ',
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/homepage');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            trailing: const Icon(Icons.navigate_next),
            // ignore: prefer_const_constructors
            title: Text(
              'Orders ',
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            onTap: () {Navigator.pushNamed(context, '/orderPage');
            },
          ),
          Divider(),
        ],
      ),
    );
  }

  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>> data(String filed) {
    return StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
                builder: (context, AsyncSnapshot snapshot){
                  if (snapshot.hasData) {
              return Text(snapshot.data[filed]);
              
                } else {
              return CircularProgressIndicator();
            }});
  }

}

