// import 'package:cloud_firestore/cloud_firestore.dart';

// // ignore: camel_case_types
// class clothingModel {
// //========================================================
// // 1) CALSS PROPERTY
// //========================================================
//   final String clothingID;
//   final String clothingNameEng;
//   final String clothingNameThai;
//   final String color;  
//   final String imageUrl;
//   final String meterial;    
//   final int price;
//   final String size;


// //========================================================
// // 2) CONSTUCTURE
// //========================================================
//   MenuModel({
//     this.clothingID,
//     this.clothingNameEng,
//     this.clothingNameThai,
//     this.color,
//     this.imageUrl,
//     this.meterial,
//     this.price,
//     this.size,
//   });

// //========================================================
// // 3) MAP DATA TO FIRESTORE FORMAT
// //========================================================
// Map<String, dynamic> toFireStore() => {
//   'menuId': menuId,
//   'menuCategoryValue':menuCategoryValue,
//   'menuNameEng':menuNameEng,
//   'menuNameThai':menuNameThai,
//   'menuDescriptionEng':menuDescriptionEng,
//   'menuDescriptionThai':menuDescriptionThai,
//   'rating':rating,
//   'price': price,
//   'spicyLevel':spicyLevel ,
//   'imageUrl': imageUrl,

// };

// //========================================================
// // 4) FUNCTION SAVE ORDER
// //========================================================
// //   saveMenu(
// // ){
// //   Firestore.instance.collection('TT_ORDERS').document(menuId ).setData(this.toFireStore()
// // //==================================================
// // // THEN (IF SAVE COMPLETE)
// // //==================================================     
// //   ).then((value) {
// //     print('Save Complete');
// // //==================================================
// // // CATCH ERROR (IF ERROR)
// // //==================================================     
// //   }).catchError((error){
// //     print('Save Error $error');
// // //==================================================
// // // WHEN COMPLETE
// // //==================================================     
// //   }).whenComplete(() {
// //     print('When completed');
// //   });
// // }

// //========================================================
// // 5) FUNCTION GET MENU
// //========================================================
// //   Stream<QuerySnapshot> getMenu({String categoryValue}){
// //    return Firestore.instance.collection('TM_MENUS').where('menuCategoryValue',isEqualTo: categoryValue).snapshots();
// // }

// //========================================================
// // 6) FACTORY METHOD (FROMFILESTORE) TO GENERATE MENU OBJECT
// //========================================================
//   factory MenuModel.fromFireStore(DocumentSnapshot doc){
//     Map data = doc.data;
//     return MenuModel(
//       menuId: data['menuId'],
//       menuCategoryValue: data['menuId'],
//       menuNameEng: data['menuNameEng'],
//       menuNameThai: data['menuNameThai'],
//       menuDescriptionEng: data['menuDescriptionEng'],
//       menuDescriptionThai: data['menuDescriptionThai'],
//       rating: data['rating'],
//       price: data['price'],   
//       spicyLevel: data['spicyLevel'],
//       imageUrl: data['imageUrl'],                                           
//     );
//   }

// }


