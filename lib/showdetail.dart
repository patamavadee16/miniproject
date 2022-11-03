
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:miniproject_1/order_form.dart';

class ShowDetail extends StatefulWidget {
  final String _idi; 
  const ShowDetail(this._idi, {Key? key})
      : super(key: key); 

  @override
  State<ShowDetail> createState() => _ShowDetail();
}

class _ShowDetail extends State<ShowDetail> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String _id = widget._idi;
    return StreamBuilder(
        stream: getProduct(_id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 245, 	173,172 ),
              title: const Text('Detail.',
                        style: TextStyle(color: Color.fromARGB(255, 247, 247, 247),
                          fontSize: 30,
                          fontFamily: 'Mitr'
                        ),
                      ),
            ),
            
            body: snapshot.hasData
                ? buildProductList(snapshot.data!)
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
        String title = model['clothingNameEng'] + '  ' + model['clothingNameThai'];
        return Column(
          children: [
           Text(model['clothingNameEng'],style: TextStyle( fontFamily: 'Mitr',
                  fontSize: 25,)),
                  
            CarouselSlider(
              
              items: [model['imageUrl'],model['imageUrl_2'],model['imageUrl_3']].map((item) => 
               Container(
                height: 1000,
                 child: Image.network(
                    item,
                     fit: BoxFit.cover,

                 ),
                  ),
               
              ).toList(),
            options: CarouselOptions(
              autoPlay: true,
                          enlargeCenterPage: true,
                          height: MediaQuery.of(context).size.height/2,
                        ),),
            // SizedBox(height: 100),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading:Text(model['clothingNameThai'],style: const TextStyle(
                  fontSize: 25,
                  fontFamily: 'Mitr')), 
                  // trailing: IconButton(onPressed: (){addToFav(model);},
                  // icon:Fav(),),
                  ),
        
                
                  Text('Price : ${model['price']} ฿',style: textStyle()),
                  Text('Color : '+model['color'],style: textStyle()),
                  Text('Size : '+model['size'],style: textStyle()),
                  Text('Meterial: '+model['meterial'],style: textStyle()),
                  Text('description: '+model['description'],style: textStyle()),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: addOrderButton(model),
                       ),
                      Flexible(
                       fit: FlexFit.loose,
                       flex: 2,
                       child: addtoCart_click(model)
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
    
  }

  TextStyle textStyle() {
    return TextStyle(
                fontSize: 13,
                fontFamily: 'Mitr');
  }

  IconButton addtoCart_click(model) {
    return IconButton(onPressed: (){
                      addToCart(model);
                  },
                  icon: Icon(Icons.shopping_cart),
                  color: Color.fromARGB(255, 245, 	173,172 ),);
  }
  Future addToCart(QueryDocumentSnapshot<Object?> model) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection("items")
        .doc(model['clothingID'])
        .set({
      "emailUser":FirebaseAuth.instance.currentUser?.email,
      "clothingID":model['clothingID'],
      "clothingNameEng":model['clothingNameEng'],
      "clothingNameThai":model['clothingNameThai'],
      "color":model['color'],
      "imageUrl":model['imageUrl'],
      "imageUrl_2":model['imageUrl_2'],
      "imageUrl_3":model['imageUrl_3'],
      "meterial":model['meterial'],
      "price":model['price'],
      "size":model['size'],

    }).then((value) => print("Added to cart"));
  }
  
     ElevatedButton addOrderButton(QueryDocumentSnapshot<Object?> model) {
    return ElevatedButton(
      
      onPressed: () async {
        Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderForm(model['clothingID'])));
     
      },
      style: ElevatedButton.styleFrom(
        primary:Color.fromARGB(255, 245, 	173,172 ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),),
      child: Text(
            'Order now',
            style: TextStyle(color: Colors.white),
          ),
    );
  }
  
  Stream<QuerySnapshot> getProduct(String titleID) {
    // Firestore _firestore = Firestore.instance;
    return _firestore
        .collection('clothing')
        .where('clothingID', isEqualTo: titleID)
        .snapshots();
  }
}
