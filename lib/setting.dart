
import 'package:flutter/material.dart';
import 'package:rich_alert/rich_alert.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'LaunchUrl.dart';

class Settingf extends StatefulWidget {
  final String title = 'HEAD PHATTIEN';
  final List<String> text;
  Settingf({Key key, @required this.text}) : super(key: key);
  @override
  _SettingfState createState() => _SettingfState(text: text);
}

class _SettingfState extends State<Settingf> {
  
  initPlatformState() {
    setState((){
    Screen.setBrightness(0.5);
    });
  }
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

   final List<String> text;
    _SettingfState({@required this.text});
   final tController = TextEditingController();
  bool status = false;
  String mesa;
  String aler;
  String pre_name;
  String device_name = "Device connected ID";


createAleardialog(what,BuildContext context){
  if (what == "1"){
      return showDialog(context: context,builder: (context){
      return RichAlertDialog(
      alertTitle: richTitle("SUCCESS",),
     alertSubtitle: richSubtitle("Thay đổi thành công"),
      alertType: RichAlertType.SUCCESS, 
      actions: [
        FlatButton(onPressed: () 
        {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LaunchUrlDemo()),
          );
          }
        , child: Text("OK"),color:Colors.lightGreen,)
      ],
    );
    }
    );
  }
  else if(what == "2")
  {
      return showDialog(context: context,builder: (context){
          return RichAlertDialog(
            alertTitle: richTitle("ERROR",),
            alertSubtitle: richSubtitle("TÊN THIẾT BỊ KHÔNG ĐƯỢC RỖNG"),
            alertType: RichAlertType.ERROR, 
            actions: [
              FlatButton(onPressed: () {Navigator.of(context).pop();}, child: Text("OK"),color:Colors.greenAccent,)
          ],
        );
      }
    );
  }   
  else if(what == "3")
  {
      return showDialog(context: context,builder: (context){
          return RichAlertDialog(
            alertTitle: richTitle("ERROR",),
            alertSubtitle: richSubtitle("TÊN MỚI BỊ TRÙNG VỚI TÊN CŨ"),
            alertType: RichAlertType.ERROR, 
            actions: [
              FlatButton(onPressed: () {Navigator.of(context).pop();}, child: Text("OK"),)
          ],
        );
      }
    );
  } 
  else{
      return showDialog(context: context,builder: (context){
      return RichAlertDialog(
      alertTitle: richTitle("WARRING",),
     alertSubtitle: richSubtitle("Tên $what đã tồn tại.\n Bạn có chắc muốn lấy tên này $what?\n 'CÁC DỮ LIỆU SẼ BỊ GHI ĐÈ NẾU BẠN CHỌN 'CÓ'!'"),
      alertType: RichAlertType.WARNING, 
      actions:<Widget>[

          Expanded(child: Container(
            
child: Column(children: <Widget>[
          Container(child:
          FlatButton(onPressed: () {
          
          appendtoken(what);
          {
      return showDialog(context: context,builder: (context){
      return RichAlertDialog(
          alertTitle: richTitle("PHATTIEN",),
          alertSubtitle: richSubtitle("SUCCESS CHANGE"),
          alertType: RichAlertType.SUCCESS, 
      actions: [
        FlatButton(onPressed: () 
        {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LaunchUrlDemo()),
          );
          }
        , child: Text("OK"),color: Colors.greenAccent,
        ),
      ],
    );
    }
    );
  }
          }, 
        child: Text("Có"),color: Colors.greenAccent,
        ),),
        Container(
                   child:   FlatButton(onPressed: ()
         {
           Navigator.of(context).pop();
           }, 
              child: Text("Không"),color: Colors.blueAccent,
            ),

        ),       

        ],
        ),
        ),
        ),
      ],
    );
    }
    );
  }
  }
_save() async {
    if (tController.text != "") {
        aler = await getdevicename(tController.text.toUpperCase());
        return aler;
    } 
    else {
        return "2";
    }
}
Future<bool> checkIfDocExists(String docId) async {
  try {
    // Get reference to Firestore collection
    var collectionRef = FirebaseFirestore.instance.collection('fcm-token');
    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  } catch (e) {
    throw e;
  }
}

/// Check If Document Exists

  getdevicename(deviceName) async {
  bool docExists = await checkIfDocExists(deviceName);

  if (!docExists){
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pre_name = prefs.getString("deviceName");
    FirebaseFirestore.instance.collection('fcm-token').doc(pre_name).delete();
        FirebaseFirestore.instance.collection('fcm-token').doc(deviceName).set({"device1_pt1": text[1]});
    await prefs.setString('deviceName', deviceName);
    device_name = deviceName;
    return "1";
  }
  else{
      device_name = deviceName;
      if (text[0] == device_name){
        return device_name;
      }
      else{
        return device_name;
      }

  }
}

appendtoken(deviceName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pre_name = prefs.getString("deviceName");
    FirebaseFirestore.instance.collection('fcm-token').doc(deviceName).update({"device1_pt1": text[1]});
    await prefs.setString('deviceName', deviceName);
}
  @override
    Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor:  Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("SETTING",style: const TextStyle(fontSize: 20.0,color: Colors.white),),
            backgroundColor: Colors.red,
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push( 
                      context,
                    MaterialPageRoute(builder: (context) => LaunchUrlDemo()),
                    );
                  },
                  child: Icon(
                      Icons.more_vert
                  ),
                )
              ),
            ],
          ),
          body:
                    GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () =>initPlatformState()
,
          child: 

          Container(
            child: Column(
              children:<Widget>[
                            Container(
                              child: TextField(
                                controller: tController,
                                  decoration: InputDecoration(
                                    hintText: text[0].toString(), //edit
                                    suffixIcon: IconButton(
                                      onPressed: () => tController.clear(),
                                      icon: Icon(Icons.clear),
                                    ),
                                  ),
                                ),
                  padding: EdgeInsets.all(10.0),
                  ),
                            Container(
                              child: RaisedButton (
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  onPressed:() async {
                                    mesa = await _save();
                                    createAleardialog(mesa,context);
                                    },
                      child: Text("Save"),
                    )
                  ),
                  //
                ],
              ),
            ),
        ),);
    }
  }
