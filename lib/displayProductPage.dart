import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniproject_1/drawer.dart';
import 'package:miniproject_1/login.dart';
import 'package:miniproject_1/profile_page.dart';
import 'package:miniproject_1/showdetail.dart';

class displayProduct extends StatefulWidget {
  const displayProduct( {Key? key});
   


  @override
  State<displayProduct> createState() => _displayProductState();
}

class _displayProductState extends State<displayProduct> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _saved = false;
  // ProductsController producsController = ProductsController.instance;
  @override
//   Widget build(BuildContext context) {
//     String _id = widget._idi;
//     return StreamBuilder(
//         stream: getBook(_id),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text("Detail Books"),
//             ),
//             body: snapshot.hasData
//                 ? buildBookList(snapshot.data!)
//                 : const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//           );
//         });
//   }

//   ListView buildBookList(QuerySnapshot data) {
//     return ListView.builder(
//       itemCount: data.docs.length,
//       itemBuilder: (BuildContext context, int index) {
//         var model = data.docs.elementAt(index);
//         String a = model['color'] + '  ' + model['price'].toString();
//         return ListTile(
//           title: Text(model['color']),
//           //    subtitle: Text(model['detail'] + Text("${model['price']}")),
//           subtitle: Text(a),
//           trailing: ElevatedButton(
//               child: const Text('Delete'),
//               onPressed: () {
//                 print(model.id);
//         //deleteValue(model.id);
//                 //Navigator.pop(context);
//               }),
//         );
//       },
//     );
//   }

//   //Future<void> deleteValue(String titleName) async {
//   //  await _firestore
//   //      .collection('books')
//   //      .doc(titleName)
//   //      .delete()
//   //      .catchError((e) {
//   //    print(e);
//   //  });
//   //}

//   Stream<QuerySnapshot> getBook(String titleName) {
//     // Firestore _firestore = Firestore.instance;
//     return _firestore
//         .collection('clothing')
//         .where('clothingID', isEqualTo: titleName)
//         .snapshots();
//   }
// }


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
                    leading: Container(
                            height: 200,
                            width: 100,
                            child: Image(
                            image:NetworkImage(document['imageUrl']),
                            ),
                          ),
                    subtitle:    Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Type  : '+(document['clothingNameThai'])),
                              // SizedBox(height: 30,),
                              Text('Color : '+(document['color'])),
                              Text('Size : '+(document['size'])),
                              Text('Price : ${document['price']}'),

                            ],
                          ),
                    trailing: IconButton(onPressed: ()=> addToFav(document),
                    // snapshot.data!.docs.length==0?addToFav(document):print("Already Added"),
                  icon: snapshot.data!.docs.length==0? Icon(
                      Icons.favorite_outline,
                      color: Colors.white,
                    ):Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),),
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowDetail(document['clothingNameThai'])));
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
        .doc()
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


