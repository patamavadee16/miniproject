import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniproject_1/showDetailOrder.dart';
import 'package:miniproject_1/showdetail.dart';


class OrderPage extends StatefulWidget {
   const OrderPage( {Key? key});
   
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Order"),
      backgroundColor:  Color.fromARGB(255, 245, 	173,172 )),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
        .collection('users-order')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('item')
        .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          return
              ListView(          
                padding: EdgeInsets.all(16.0),
                  children: snapshot.data!.docs.map((document){
                    return Column(             
                      children: [
                        ListTile(
                          leading: Image(image:NetworkImage(document['imageUrl']),fit: BoxFit.fitHeight,),
                          subtitle:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(document['clothingNameThai']),
                              Text('Color : '+(document['color'])),
                              Text('${document['price']}'+' ฿',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Itim'),
                                ),
                            ],
                          ),
                          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowDetailOrder(document['id'])));},
                        ),
                        Divider()
                      ]
                    );
                  }
                ).toList(),
              );

      }
    )
  );
  }
}
  