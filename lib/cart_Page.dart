// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniproject_1/showdetail.dart';
class Cart extends StatefulWidget {
  const Cart( {Key? key});
  @override
  _CartState createState() => _CartState();
}

  @override
class _CartState extends State<Cart> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
        .collection('users-cart-items')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('items')
        .where('emailUser', isEqualTo:(FirebaseAuth.instance.currentUser?.email) )
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
                          trailing:IconButton(onPressed: (){
                            FirebaseFirestore.instance
                            .collection('users-cart-items')
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection("items")
                            .doc(document['clothingID'])
                            .delete();
                              }, icon: const Icon(Icons.delete),
                            ),
                          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowDetail(document['clothingID'])));},
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