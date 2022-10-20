import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniproject_1/product_Page.dart';

class displayProduct extends StatefulWidget {
  const displayProduct( {Key? key});
   


  @override
  State<displayProduct> createState() => _displayProductState();
}

class _displayProductState extends State<displayProduct> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _saved = false;
  Widget build(BuildContext context) {

    return  Scaffold(
      // appBar: AppBar(
      //   backgroundColor:  Color.fromARGB(255, 245, 	173,172 ),
      //   actions: <Widget>[
      //       IconButton(
      //           onPressed: () {
      //             FirebaseAuth.instance.signOut();
      //             Navigator.pushReplacementNamed(context, '/');
      //           },
      //           icon: const Icon(Icons.logout))
      //     ],
      // ),
      // body: Center(
      //   child: _widgetOptions.elementAt(_selectedIndex),
      // ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('clothing').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }

          return ListView(
            
            padding: EdgeInsets.all(16.0),
            children: snapshot.data!.docs.map((document){
              return Column(
                
                children: [
                  ListTile(
                    leading: Image(
                    image:NetworkImage(document['imageUrl']),
                    fit: BoxFit.fitHeight,
                    ),
                    subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text((document['clothingNameThai']),
                                 // ignore: prefer_const_constructors
                                 style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'FuzzyBubbles'
                                ),),
                                Text('Color : '+(document['color'])),
                                Text('Size : '+(document['size'])),
                                Text('${document['price']}'+' ฿',
                                  style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'FuzzyBubbles'
                                  ),),
                            ],
                          ),
                    trailing: IconButton(
                      onPressed: (){addToFav(document);},
                    // snapshot.data!.docs.length==0?addToFav(document):print("Already Added"),
                      icon: _saved==false? const Icon(
                      Icons.favorite_outline,
                      color: Colors.black,
                    // ignore: prefer_const_constructors
                    ):Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),),
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetails(document)));
                    } ,
                  ),
                   Divider()
                ],
              );
            }).toList(),
          );
        },
      )
    );

  }

//     // Firestore _firestore = Firestore.instance;
//     return _firestore
//         .collection('clothing')
//         .where('clothingID', isEqualTo: titleName)
//         .snapshots();
//   }
// }
  IconButton addToFav_click(QueryDocumentSnapshot<Object?> document) {
    return IconButton(onPressed: (){
                    addToFav(document);
                  },
                  icon: Icon(Icons.favorite_border),);
  }
    Future addToFav(QueryDocumentSnapshot<Object?> document) async {
   
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-fav-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(document['clothingID'])
        .set({
      "clothingID":document['clothingID'],
      "clothingNameEng":document['clothingNameEng'],
      "clothingNameThai":document['clothingNameThai'],
      "color":document['color'],
      "imageUrl":document['imageUrl'],
      "imageUrl_2":document['imageUrl_2'],
      "meterial":document['meterial'],
      "price":document['price'],
      "size":document['size']

    }).then((value) => print("Added to Fav"));
  }
}


