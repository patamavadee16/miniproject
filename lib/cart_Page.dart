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
          return Stack(
            children: [
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
                            .doc('clothingID')
                            .delete();
                              }, icon: const Icon(Icons.delete),
                            ),
                          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowDetail(document['clothingNameThai'])));},
                        ),
                        Divider()
                      ]
                    );
                  }
                ).toList(),
              ),
              Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text('create')
                    ]
                  )
                ]
              )
            ]
          )
          ]
        );
      }
    )
  );

  }
}
// Widget fetchData (String collectionName){
//   return StreamBuilder(
//     stream: FirebaseFirestore.instance.collection('users-cart-items').doc(FirebaseAuth.instance.currentUser?.email).collection('items').where('emailUser', isEqualTo:(FirebaseAuth.instance.currentUser?.email) )
//         .snapshots(),
//     builder:
//         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (snapshot.hasError) {
//         return const Center(
//           child: Text("Something is wrong"),
//         );
//       }
//       return ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//           itemCount:
//           snapshot.data == null ? 0 : snapshot.data!.docs.length,
//           itemBuilder: (_, index) {
//             DocumentSnapshot _documentSnapshot =
//             snapshot.data!.docs[index];

//             return Card(
//               elevation: 5,
//               child: ListTile(
//                     leading: Container(
//                             height: 200,
//                             width: 100,
//                             child: Image(
//                             image:NetworkImage(_documentSnapshot['imageUrl_2']),
//                             ),
//                           ),
//                     subtitle:    Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(_documentSnapshot['clothingNameThai']),
//                               Text('Color : '+(_documentSnapshot['color'])),
//                               Text('${_documentSnapshot['price']}'+' ฿',
//                                   style: const TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'FuzzyBubbles'
//                                   ),
//                                 ),
//                             ],
//                           ),
//                           trailing:
//                    IconButton(onPressed: (){
//                       FirebaseFirestore.instance
//                         .collection(collectionName)
//                         .doc(FirebaseAuth.instance.currentUser!.email)
//                         .collection("items")
//                         .doc(_documentSnapshot.id)
//                         .delete();
//                   }, icon: const Icon(Icons.delete),
//                   ),
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowDetail(_documentSnapshot['clothingNameThai'])));
//                   },
               
//               ));

//           });
//     },
//   );
// }