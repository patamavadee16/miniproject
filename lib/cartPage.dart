import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniproject_1/showdetail.dart';
class Cart extends StatefulWidget {
  const Cart( {Key? key});
  @override
  _CartState createState() => _CartState();
}

  @override
class _CartState extends State<Cart> {
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: fetchData("users-cart-items"),
      ),
    );
  }


}
Widget fetchData (String collectionName){
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .snapshots(),
    builder:
        (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Text("Something is wrong"),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.all(16.0),
          itemCount:
          snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot _documentSnapshot =
            snapshot.data!.docs[index];

            return Card(
              elevation: 5,
              child: ListTile(
                    leading: Container(
                            height: 200,
                            width: 100,
                            child: Image(
                            image:NetworkImage(_documentSnapshot['imageUrl']),
                            ),
                          ),
                    subtitle:    Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_documentSnapshot['clothingNameThai']),
                              // SizedBox(height: 30,),
                              Text('Color : '+(_documentSnapshot['color'])),
                              // Text('Size : '+(_documentSnapshot['size'])),
                              Text('Price : ${_documentSnapshot['price']}'),
 
                            ],
                          ),
                          trailing:
                   IconButton(onPressed: (){
                      FirebaseFirestore.instance
                        .collection(collectionName)
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection("items")
                        .doc(_documentSnapshot.id)
                        .delete();
                  }, icon: Icon(Icons.delete),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowDetail(_documentSnapshot['clothingNameThai'])));
                  },
               
              ));

          });
    },
  );
}