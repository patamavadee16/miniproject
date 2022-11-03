import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniproject_1/bottomNavi.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:miniproject_1/login_Page.dart';

class OrderForm extends StatefulWidget {
   final String _idi; 
  const OrderForm(this._idi, {Key? key})
      : super(key: key);
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formstate = GlobalKey<FormState>();
  TextEditingController ?_age;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _zipCode = TextEditingController();
    final TextEditingController _tombon = TextEditingController();
  final TextEditingController _amphone = TextEditingController();
  String? message;
  String channelId = "1000";
  String channelName = "FLUTTER_NOTIFICATION_CHANNEL";
  String channelDescription = "FLUTTER_NOTIFICATION_CHANNEL_DETAIL";

  File? file;
  List<String> provices = ['','กรุงเทพมหานคร','สมุทรปราการ','นนทบุรี','ปทุมธานี','พระนครศรีอยุธยา','อ่างทอง','ลพบุรี','สิงห์บุรี','ชัยนาท','สระบุรี','ชลบุรี','ระยอง','จันทบุรี','ตราด','ฉะเชิงเทรา','ปราจีนบุรี','นครนายก','สระแก้ว','นครราชสีมา','บุรีรัมย์','สุรินทร์','ศรีสะเกษ','อุบลราชธานี','ยโสธร','ชัยภูมิ','อำนาจเจริญ','หนองบัวลำภู','ขอนแก่น','อุดรธานี','เลย','หนองคาย','มหาสารคาม','ร้อยเอ็ด','กาฬสินธุ์','สกลนคร','นครพนม','มุกดาหาร','เชียงใหม่','ลำพูน','ลำปาง','อุตรดิตถ์','แพร่','น่าน','พะเยา','เชียงราย','แม่ฮ่องสอน','นครสวรรค์','อุทัยธานี','กำแพงเพชร','ตาก','สุโขทัย','พิษณุโลก','พิจิตร','เพชรบูรณ์','ราชบุรี','กาญจนบุรี','สุพรรณบุรี','นครปฐม','สมุทรสาคร','สมุทรสงคราม','เพชรบุรี','ประจวบคีรีขันธ์','นครศรีธรรมราช','กระบี่','พังงา','ภูเก็ต','สุราษฎร์ธานี','ระนอง','ชุมพร','สงขลา','สตูล','ตรัง','พัทลุง','ปัตตานี','ยะลา','นราธิวาส','บึงกาฬ'];
    dynamic provice = '';
  
  setDataToTextField(data){
    return  Form(
      key: _formstate,
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Image(image:NetworkImage(data['imageUrl']),fit: BoxFit.fitHeight,),
          subtitle:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['clothingNameThai']),
              Text('Color : '+(data['color'])),
              Text('${data['price']}'+' ฿',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Itim'),),
            ],
         ),
       ),
        Text("Information"),
        SizedBox(height: 8,),
        nameField(),
        SizedBox(height: 8,),
        phoneField(),
        SizedBox(height: 8,),
        Text("Address"),
        SizedBox(height: 8,),
        addressField(),
        SizedBox(height: 8,),
        tombonField(),
        SizedBox(height: 8,),
        amphoneField(),
        SizedBox(height: 8,),
        zipCodeField(),
        SizedBox(height: 10,),
        buildSelectField(),
        SizedBox(height: 5,),
        //Text(provice.toString()),
        Row(
          children: [
            Expanded(
              child: updateButton(data),),
          ],
        )
      ],),
        
    ),);
  }

  ElevatedButton updateButton(data) {
    return ElevatedButton(
            onPressed: (){
            updateData(data);
            
            },
            style: ElevatedButton.styleFrom(
          primary:const Color.fromARGB(255, 245, 	173,172 ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),),
     child: Text("confirm",style: TextStyle(color: Colors.white,fontSize: 20),));
  }

  TextFormField phoneField() {
    return TextFormField(
        controller: _phone,
        validator: (value) {
      if (value!.isEmpty) {
        return 'Please fill in this field';
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      labelText: ('เบอร์โทรติดต่อ'),
      // icon: const Icon(Icons.phone_enabled_outlined),
      hintText: ('เบอร์โทรติดต่อ '),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      )
    ),
      );
  }

  TextFormField addressField() {
    return TextFormField(
        controller: _address  ,
        validator: (value) {
      if (value!.isEmpty)
        return 'Please fill in this field';
      else
        return null;
    },
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      labelText: ('ที่อยู่'),
      // icon: const Icon(Icons.email),
      hintText: ('ที่อยู่'),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      )
    ),
      );
  }
    TextFormField tombonField() {
    return TextFormField(
        controller: _tombon  ,
        validator: (value) {
      if (value!.isEmpty)
        return 'Please fill in this field';
      else
        return null;
    },
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      labelText: ('ตำบล'),
      hintText: ('ตำบล'),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      )
    ),
      );
  }
      TextFormField amphoneField() {
    return TextFormField(
        controller: _amphone  ,
        validator: (value) {
      if (value!.isEmpty)
        return 'Please fill in this field';
      else
        return null;
    },
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      labelText: ('อำเภอ'),
      hintText: ('อำเภอ'),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      )
    ),
      );
  }


  TextFormField nameField() {
    return TextFormField(
        controller: _name ,
        validator: (value) {
      if (value!.isEmpty) {
        return 'Please fill in this field';
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      labelText: ('ชื่อผู้รับ'),
      hintText: ('ชื่อผู้รับ'),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      )
    ),
      );
  }

  updateData(data){
         final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
     Random random = Random();
    int i = random.nextInt(100);
    if (_formstate.currentState!.validate()){
      sendNotification();
       CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-order");
    return _collectionRef
        .doc(FirebaseAuth.instance.currentUser?.email).collection("item").doc(data['clothingID'])
        .set({
      "id": i.toString(),
      "clothingID":data['clothingID'],
      "clothingNameThai":data['clothingNameThai'],
      "imageUrl":data['imageUrl'],
      "color":data['color'],
      "price":data['price'],
      "name":_name.text,
      "phone":_phone.text,
      "address":{"No.":_address.text,
      "tombon":_tombon.text, "amphone":_amphone.text,"provide":provice,"zipcode":_zipCode.text}
    }).then((value) =>  Navigator.pushNamedAndRemoveUntil(context, '/OrderPage', ModalRoute.withName('/homepage')));
    }
   
     
  }


    InputDecorator buildSelectField() {
      return InputDecorator(
  
      decoration: const 
    InputDecoration(
      labelText: 'Province',
      border: OutlineInputBorder(borderRadius: BorderRadius.horizontal(left :Radius.circular(20), right:Radius.circular(20)))
    ),
 
    child: DropdownButtonHideUnderline(
    child: DropdownButton(
    value: provice,
    onChanged: (value) {
      setState(() {
         provice = value;
      });
    },
    items: provices
    .map(
    (value) => DropdownMenuItem<String>(
    value: value,
    child: Text(value),
    ),
    )
    .toList(),
    ),
    ),
    );
    }
      TextFormField zipCodeField() {
    return TextFormField(
        controller: _zipCode,
        validator: (value) {
      if (value!.isEmpty) {
        return 'Please fill in this field';
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      labelText: ('รหัสไปรษณีย์'),
      hintText: ('ใส่รหัสไปรษณีย์'),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      )
    ),
      );
  }
  @override
 initState() {
    message = "No message.";

    var initializationSettingsAndroid =
        AndroidInitializationSettings('noti');

    var initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) async {
      print("onDidReceiveLocalNotification called.");
    });

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
      // when user tap on notification.
      print("onSelectNotification called.");
      setState(() {
        message = payload.payload;
      });
    });

    super.initState();
  }
  sendNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '10000',
      'FLUTTER_NOTIFICATION_CHANNEL',
      channelDescription: 'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        111, 'Sodsai shop', 'comfirm order', platformChannelSpecifics,
        payload: 'I just haven\'t Met You Yet');
  }
  Widget build(BuildContext context) {
      String _id = widget._idi;
    return Scaffold(
      appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 245, 	173,172 ),
              title: const Text('Form',style: TextStyle(color: Color.fromARGB(255, 247, 247, 247),fontSize: 30,fontFamily: 'Mitr'))
            ),
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("clothing").doc(_id).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            var data = snapshot.data;
            if(data==null){
              return Center(child: CircularProgressIndicator(),);
            }
            return setDataToTextField(data);
          },
        ),
      )),
    );
  }
}