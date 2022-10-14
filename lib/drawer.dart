import 'package:flutter/material.dart';
import 'package:miniproject_1/homepage.dart';
import 'package:miniproject_1/orderPage.dart';


class SharedDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final authData = Provider.of<Auth>(context, listen: false);
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15),
            height: 200,
            color:  Color.fromARGB(255, 245, 	173,172 ),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
               
                const CircleAvatar(
                  // radius: 70,
                  maxRadius: 70,
                  minRadius: 30,
                  backgroundColor: Colors.grey,
                ),
                 
                const SizedBox(height: 10),
                // Expanded(
                //   child: Text(
                //     authData == null ? 'userName' : authData.email,
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 17,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          const SizedBox(height: 10),
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
              // Navigator.pushReplacementNamed(context, OrdersScreen.routeName);
            },
          ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.edit),
          //   trailing: Icon(Icons.navigate_next),
          //   title: Text(
          //     'Manage Meals ',
          //     style: TextStyle(
          //       fontSize: 17,
          //     ),
          //   ),
          //   onTap: () {
          //     // Navigator.pushReplacementNamed(context, ManageScreen.routeName);
          //   },
          // ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.contacts),
          //   trailing: Icon(Icons.navigate_next),
          //   title: Text(
          //     'Contact Us ',
          //     style: TextStyle(
          //       fontSize: 17,
          //     ),
          //   ),
          //   onTap: () {},
          // ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.help),
          //   trailing: Icon(Icons.navigate_next),
          //   title: Text(
          //     'Help ',
          //     style: TextStyle(
          //       fontSize: 17,
          //     ),
          //   ),
          //   onTap: () {},
          // ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            trailing: Icon(Icons.navigate_next),
            // ignore: prefer_const_constructors
            title: Text(
              'Setting',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/homepage');
            },
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.exit_to_app),
          //   trailing: Icon(Icons.navigate_next),
          //   title: Text(
          //     'Log Out ',
          //     style: TextStyle(
          //       fontSize: 17,
          //     ),
          //   ),
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.of(context).pushReplacementNamed('/');
          //     //////////////////////////////////////////////////
          //     // authData.logOut();
          //   },
          // ),
          Divider(),
        ],
      ),
    );
  }
}
