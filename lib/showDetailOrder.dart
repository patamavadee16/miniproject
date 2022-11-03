
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ShowDetailOrder extends StatefulWidget {
  final String _idi; 
  const ShowDetailOrder(this._idi, {Key? key})
      : super(key: key); 

  @override
  State<ShowDetailOrder> createState() => _ShowDetailOrder();
}

class _ShowDetailOrder extends State<ShowDetailOrder> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List _products = [];
  

  @override
  Widget build(BuildContext context) {
    String _id = widget._idi;
    return StreamBuilder(
        stream: getProduct(_id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 245, 	173,172 ),
              title: const Text('Detail',
                        style: TextStyle(color: Color.fromARGB(255, 247, 247, 247),
                          fontSize: 30,
                          fontFamily: 'Mitr'
                        ),
                      ),
            ),
            
            body: snapshot.hasData
                ? buildProductList(snapshot.data!)
                :const Center(child: CircularProgressIndicator(),)
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
          children: [

            // SizedBox(height: 100),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(model['imageUrl'],),
                 
        
                
                const Text('รายละเอียดสินค้า',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontFamily: 'Mitr'
                        ),),
                 
                  Text(model['clothingNameThai']), 
                  Text('Color : '+model['color']),
                  Text('Price : ${model['price']} ฿'),
                  const SizedBox(height: 20,),
                  const Text('รายละเอียดการจัดส่ง',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontFamily: 'Mitr'
                        ),),
                  Text('ผู้รับ : '+model['name']),
                  Text('ที่อยู่ : '+(model['address']['No.']).toString()),
                  Text('ตำบล : '+(model['address']['tombon']).toString()),
                  Text('อำเภอ : '+(model['address']['amphone']).toString()),
                  Text('จังหวัด : '+(model['address']['provide']).toString()),
                  Text('รหัสไปรษณีย์: '+(model['address']['zipcode']).toString()),
                  
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


  
  Stream<QuerySnapshot> getProduct(String titleID) {
    return _firestore
        .collection('users-order').doc(FirebaseAuth.instance.currentUser?.email)
        .collection('item')
        .where('id', isEqualTo:titleID)
        .snapshots();
  }
}
