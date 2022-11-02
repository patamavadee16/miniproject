
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ShowDetailPost extends StatefulWidget {
   var _idi; 
   ShowDetailPost(this._idi, {Key? key})
      : super(key: key); 

  @override
  State<ShowDetailPost> createState() => _ShowDetail();
}

class _ShowDetail extends State<ShowDetailPost> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // ProductsController producsController = ProductsController.instance;
  @override
  Widget build(BuildContext context) {
    String _id = widget._idi;
    return StreamBuilder(
        stream: getProduct(_id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 245, 	173,172 ),
              title: const Text('Review Post',
                        style: TextStyle(color: Color.fromARGB(255, 247, 247, 247),
                          fontSize: 30,
                          fontFamily: 'Mitr'
                        ),
                      ),
            ),
            body: snapshot.hasData
                ?buildProductList(snapshot.data!)

                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        });
  }

  ListView buildProductList(QuerySnapshot data) {
    return ListView.builder(

      padding: EdgeInsets.all(16.0),
      itemCount: data.docs.length,
      itemBuilder: (BuildContext context, int index) {
        var model = data.docs.elementAt(index);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            Stack(
              children: [
                Image.network(model['url_picture'],),
                IconButton(onPressed: (){addToFav();}, icon: const Icon(Icons.favorite))],),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [ 
                  Text(model['title'],
                    style: const TextStyle( 
                      fontSize: 20,
                      fontFamily: 'Mitr')
                      ),
                      Text(model['desciption'],
                        style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Itim')),
                  // Card(
                  // margin: EdgeInsets.only(left: 40,right: 40,top:20),
                  // elevation: 5,
                  // color: Color.fromARGB(255, 245, 244, 244),
                  // shape: RoundedRectangleBorder(
                  // borderRadius: BorderRadius.circular(12.0),
                  // ),
                  // child  : 
                  //     ListTile(
                  //       subtitle:  Text(model['desciption'],
                  //       style: const TextStyle(
                  //       fontSize: 20,
                  //       fontFamily: 'Itim'))),
           
                  // )
                  // ,const Text('Create your review >',
                  //       style: TextStyle(color: Color.fromARGB(255, 245, 	173,172 ),
                  //         fontSize: 30,
                  //         fontFamily: 'FuzzyBubbles'
                  //       ),
                  //     ),Image.asset('assets/icons8-cart-64.png')
                ],
              ),
            )
          ],
        );
      },
    );
    
  }
  IconButton addToFav_click(QueryDocumentSnapshot<Object?> document) {
    return IconButton(onPressed: (){
                    addToFav();
                  },
                  icon: Icon(Icons.favorite_border),);
  }
    Future addToFav() async {
   
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-fav-post");
    return _collectionRef
        .doc(currentUser!.email).collection('post').doc()
        .set({
      "title":widget._idi['title'],

    }).then((value) => print("Added to Fav"));
  }
  Stream<QuerySnapshot> getProduct(String titleID) {
    // Firestore _firestore = Firestore.instance;
    return _firestore
        .collection('users-review-post')
        .where('title', isEqualTo: titleID)
        .snapshots();
  }
}
