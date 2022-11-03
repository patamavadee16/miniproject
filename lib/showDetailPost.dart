
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
        return          
               
        SingleChildScrollView(
        child:Column(
          children: [
          Container(child: Image.network(model['url_picture'],)),   //รูปคอมเมนต์

      Card (                   
                margin: EdgeInsets.only(left: 10,right: 10,top:20),
                elevation: 5,
                color: Color.fromARGB(255, 247, 247, 247),
                shape: RoundedRectangleBorder(                 
                borderRadius: BorderRadius.circular(12.0),
                ),child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                
                Container(
                  width: 2300,
                  height: 300,
                  child: 
                  SingleChildScrollView(
                    padding: EdgeInsets.all(20),
        child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [ 
                      const Text("สินค้า",style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Mitr')),
                      Text(model['title'],
                    
                          ),
                          const Text("comment",style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Mitr')),
                          Text(model['desciption'],
                            ),
                    ],
                  ),
                ))
              ],
            )),
          ],
        ));
      },
    );
    
  }
  Stream<QuerySnapshot> getProduct(String titleID) {
    // Firestore _firestore = Firestore.instance;
    return _firestore
        .collection('users-review-post')
        .where('title', isEqualTo: titleID)
        .snapshots();
  }
}
