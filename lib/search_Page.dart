import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miniproject_1/product_Page.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
 var inputText = "" ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              
              TextFormField(
                onSaved: (val){
                  inputText =  val!;
                    print(inputText);
                },
                // controller: inputText ,
                onChanged: (val) {
                  setState(() {
                    print(inputText);
                    inputText = val;
                    print(inputText);
                  });
                },
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('clothing').where('clothingNameEng', isEqualTo : inputText).snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Something went wrong"),
                          );
                        }else

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Text("Loading"),
                          );
                        }else if(snapshot.hasData){
                          return  buildProductList(snapshot.data!);
          //                 return ListView(
            
          //   padding: EdgeInsets.all(16.0),
          //   children: snapshot.data!.docs.map((document){
          //     return Column(
                
          //       children: [
          //         ListTile(
          //           leading: Image(
          //           image:NetworkImage(document['imageUrl']),
          //           fit: BoxFit.fitHeight,
          //           ),
          //           subtitle: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Text((document['clothingNameThai']),
          //                        // ignore: prefer_const_constructors
          //                        style: TextStyle(
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.bold,
          //                       fontFamily: 'FuzzyBubbles'
          //                       ),),
          //                       Text('Color : '+(document['color'])),
          //                       Text('Size : '+(document['size'])),
          //                       Text('${document['price']}'+' ฿',
          //                         style: const TextStyle(
          //                         fontSize: 15,
          //                         fontWeight: FontWeight.bold,
          //                         fontFamily: 'FuzzyBubbles'
          //                         ),),
          //                   ],
          //                 ),
          //           onTap:(){
          //             Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetails(document)));
          //           } ,
          //         ),
          //          Divider()
          //       ],
          //     );
          //   }).toList(),
          // );
                        }else 
                        return Text("Something  wrong");
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView data(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                               print(data['clothingNamethai']);
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(data['clothingNamethai']),
                              leading: Image.network(data['imageUrl'][0]),
                             
                            ),
                          );
                        }).toList(),
                      );
  }
    ListView buildProductList(QuerySnapshot data) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: data.docs.length,
      itemBuilder: (BuildContext context, int index) {
        var model = data.docs.elementAt(index);
        String title = model['clothingNameEng'] + '  ' + model['clothingNameThai'];
        if(model['clothingNameEng'].toString().toLowerCase().startsWith('s')) {
          return Column(
          children: [
            AspectRatio(
              aspectRatio:40.0/30.0,
              child:
            CarouselSlider(
              items: [model['imageUrl'],model['imageUrl_2']].map((item) => 
               Container(
                 child: Image.network(
                    item,
                     fit: BoxFit.cover,
                  ),
               ),
              ).toList(),
            options: CarouselOptions(
              autoPlay: true,
            ))),
            SizedBox(height: 100),

          ],
        );
        }else
        return SizedBox(height: 100);
      },
    );
    
  }
}