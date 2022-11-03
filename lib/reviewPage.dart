
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miniproject_1/showDetailPost.dart';
class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users-review-post').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
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
                                fontFamily: 'Mitr'
                                ),),
                                const SizedBox(height: 5,),
                                Text((document['desciption']),style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Mitr'
                                )),

                            ],
                          ),trailing: Image.asset('assets/icons8-review-64.png'),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowDetailPost(document['title'])));
                          },
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