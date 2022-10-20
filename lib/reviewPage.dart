
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:miniproject_1/showDetailPost.dart';
class reviewPage extends StatefulWidget {
  const reviewPage({super.key});

  @override
  State<reviewPage> createState() => _reviewPageState();
}

class _reviewPageState extends State<reviewPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        stream: FirebaseFirestore.instance.collection('users-review-post').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }

          return Stack(children: [ListView(
            
            padding: EdgeInsets.all(16.0),
            children: snapshot.data!.docs.map((document){
              return Column(
                
                children: [
                  ListTile(
                    leading: Image(
                    image:NetworkImage(document['url_picture']),
                    fit: BoxFit.fitHeight,
                    ),
                    subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text((document['title']),
                                 // ignore: prefer_const_constructors
                                 style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Itim'
                                ),),SizedBox(height: 5,),
                                Text((document['desciption']),style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Itim'
                                )),

                            ],
                          ),trailing: Image.asset('assets/icons8-review-64.png'),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowDetailPost(document['title'])));
                          },
                    // trailing: IconButton(
                    //   onPressed: ()=> addToFav(document),
                    // // snapshot.data!.docs.length==0?addToFav(document):print("Already Added"),
                    //   icon: snapshot.data!.docs.length==0? const Icon(
                    //   Icons.favorite_outline,
                    //   color: Colors.white,
                    // // ignore: prefer_const_constructors
                    // ):Icon(
                    //   Icons.favorite,
                    //   color: Colors.red,
                    // ),),
                    // onTap:(){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowDetail(document['clothingNameThai'])));
                    // } ,
                  ),
                   Divider()
                ],
              );
            }).toList(),
          ),Column(
           mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      goToCearte_click(),
                      Text('create')
                    ],
                  ) ,
                ],
              ),
            ],
          )],);
        },
      )
    );
//     Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor:  Color.fromARGB(255, 245, 	173,172 ),
//       //   actions: <Widget>[
//       //       IconButton(
//       //           onPressed: () {
//       //             FirebaseAuth.instance.signOut();
//       //             Navigator.pushReplacementNamed(context, '/');
//       //           },
//       //           icon: const Icon(Icons.logout))
//       //     ],
//       // ),
//       // body: Center(
//       //   child: _widgetOptions.elementAt(_selectedIndex),
//       // ),
//       body: StreamBuilder(
//         stream: _firestore.collection('users-review-post').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if(!snapshot.hasData){
//             return Center(child: CircularProgressIndicator(),);
//           }

//           return 
              
//                   buildProductList(snapshot.data!);
  
            
//           //  ListView(
            
//           //   padding: EdgeInsets.only(top: 200),
//           //   children: snapshot.data!.docs.map((document){
//           //     return Column(
                
//           //       children: [
                  
//           //         CarouselSlider(
//           //     items: [document['url_picture']].map((item) => 
//           //      Container(
//           //       // width: 1000,
//           //       // height: 1000,
//           //        child: Image.network(
//           //           item,
//           //            fit: BoxFit.cover,
//           //           width: 1000,
//           //       height: 1000,
//           //         ),
//           //      ),
//           //     ).toList(),
//           //   options: CarouselOptions(
//           //     autoPlay: true,
//           //     // enlargeCenterPage: true,
//           //     //         viewportFraction:0.8,
//           //     //         enlargeStrategy: CenterPageEnlargeStrategy.height,
//           //   )),
//           //          Divider(),buildSaveButton(),
                   
//           //       ],
//           //     );
//           //   }).toList(),
//           // );
//         },
//       )
//     );
//   }
//     Stream<QuerySnapshot> getProduct(String titleName) {
//        final FirebaseAuth _auth = FirebaseAuth.instance;
//               var  currentUser = _auth.currentUser;
//     // Firestore _firestore = Firestore.instance;
//     return _firestore
//         .collection('users-review-post').doc(currentUser!.email).collection("post")
//         .where('clothingNameThai', isEqualTo: titleName)
//         .snapshots();
//   }
//       RaisedButton buildSaveButton() {
//     return RaisedButton(
        
//         onPressed: () async {
//             Navigator.pushNamed(context, '/createReview');
//           } ,

//       color: Color.fromARGB(255, 245, 	173,172 ),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//       child: const Text('Create',style:TextStyle(color: Colors.white,fontSize: 20)
//        ),);
//   }
//   ListView buildProductList(QuerySnapshot data) {
//     return  ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: data.docs.length,
//       itemBuilder: (BuildContext context, int index) {
//         var model = data.docs.elementAt(index);
//         return Container(
//           // margin: EdgeInsets.all(16),
//           child:
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Row(
//                     children: [Image.asset('assets/icons8-wavy-line-64.png'),
//                     Image.asset('assets/icons8-wavy-line-64.png'),
//                     Image.asset('assets/icons8-wavy-line-64.png'),
                    

              //         Container(
              //   width: 70,
              //   height: 70,
              //   decoration: const BoxDecoration(
              //         image: DecorationImage(
              //         image:AssetImage('assets/icons8-review-64.png'),
              //         // fit: BoxFit.cover,
              //         alignment: Alignment.center,
              //         fit: BoxFit.cover
              //         )
              //   ),
              // ),Image.asset('assets/icons8-wavy-line-64.png'),
//                     Image.asset('assets/icons8-wavy-line-64.png'),
//                     Image.asset('assets/icons8-wavy-line-64.png'),
//                     ],
//                   ),
//                     const Text('Review!.',
//                             style: TextStyle(color: Color.fromARGB(255, 245, 	173,172 ),
//                               fontSize: 25,
//                               fontFamily: 'FuzzyBubbles',
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   Card (
//                     elevation: 20,
//                     color: Color.fromARGB(255, 245, 	173,172),
//                     shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     ),child: Column(
//                       children: [
//                         Container(height: 400,
//                 width: 400,
//                       child: Image.network(
//                               model['url_picture'],
//                                fit: BoxFit.cover,
//                           //     width: 1000,
//                           // height: 1000,
//                             ),
//                     ),
//                       ],
//                     ), ), Card (
//                     // elevation: 20,
//                     // color: Color.fromARGB(255, 245, 	173,172),
//                     shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     ),child:Column(
//                       children: [
//                         Text(model['title'],
//                                 style: TextStyle(color: Color.fromARGB(255, 245, 	173,172 ),
//                                   fontSize: 25,
//                                   fontFamily: 'Itim',

//                                 ),),Text(model['desciption'],
//                                 style: TextStyle(color: Color.fromARGB(255, 245, 	173,172 ),
//                                   fontSize: 25,
//                                   fontFamily: 'Itim',

//                                 ),),
//                       ],
//                     ) )
// ,buildSaveButton()

//                     ]

                 
                
                
//               ),
//         );
//       },
//     );
    
//   }
  }   IconButton goToCearte_click() {
    return IconButton(
      onPressed: ()
        { Navigator.pushNamed(context, '/createReview');
      },
      color: Color.fromARGB(255, 245, 	173,172 ),
      icon: Icon(Icons.camera_alt_rounded),
      iconSize: 50.0,
     
       
    );
  }}