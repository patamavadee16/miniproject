import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniproject_1/search_Page.dart';
import 'package:miniproject_1/showdetail.dart';

class Home extends StatefulWidget {
  const Home( {Key? key});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  final List _products = [];
  final _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img-path"],
        );
        print(qn.docs[i]["img-path"]);
      }
    });

    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("clothing").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-ID": qn.docs[i]["clothingID"],
          "product-name": qn.docs[i]["clothingNameThai"],
          "product-nameEng": qn.docs[i]["clothingNameEng"],
          "product-price": qn.docs[i]["price"],
          "product-img": qn.docs[i]["imageUrl"],
          "product-size": qn.docs[i]["size"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20,top: 10),
              child: TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.search),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color.fromARGB(255, 245, 	173,172 ))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: "Search products here",
                  hintStyle: TextStyle(fontSize: 15),
                ),
                onTap: () {Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => SearchScreen())
              );},
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AspectRatio(
              aspectRatio: 3.5,
              child: CarouselSlider(
                  items: _carouselImages
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.fitWidth)),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      })),
            ),
            const SizedBox(
              height: 10,
            ),
            DotsIndicator(
              dotsCount:
                  _carouselImages.isEmpty ? 1 : _carouselImages.length,
              position: _dotPosition.toDouble(),
              decorator: const DotsDecorator(
                spacing: EdgeInsets.all(2),
                activeSize: Size(8, 8),
                size: Size(6, 6),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ShowDetail(_products[index]['product-ID']))),
                      child: Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: AspectRatio(
                                aspectRatio: 2,
                                child: Container(
                                    color: Color.fromARGB(255, 231, 205, 205),
                                    child: Image.network(
                                      _products[index]["product-img"],
                                    )),)
                       ),
                            Text("${_products[index]["product-nameEng"]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold
                    ),),
                            Text("${_products[index]["product-name"]}"),
                            // Text("${_products[index]["product-size"]}"),
                            Text(
                                "${_products[index]["product-price"].toString()}"+'฿'),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      )),
    );
  }
}