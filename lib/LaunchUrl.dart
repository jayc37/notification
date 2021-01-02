import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rich_alert/rich_alert.dart';
import 'Ifameapp.dart';
import 'setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:screen/screen.dart';
import 'package:connectivity/connectivity.dart';

class LaunchUrlDemo extends StatefulWidget {
  final String title = ' PHATTIEN';
  @override
  _LaunchUrlDemoState createState() => _LaunchUrlDemoState();
}
const storedPasscode = '123333';
class _LaunchUrlDemoState extends State<LaunchUrlDemo> {
  //
  int key = 0; 
  List<String>tnul;
  bool isAuthenticated = false;
  String phoneNumber = '';
  String tokenid ='';
  String devicename = '';
  bool initialized = false;
  bool error = false;
  bool _isopen = true;
  int timeop = 300;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        initialized = true;
        _getToken();
        print('get init firestore');
      });
    } catch(e) {
      // Set `error` state to true if Firebase initialization fails
      setState(() {
        error = true;
      });
    }
  }
createContext(BuildContext context){                      
List<String> tokenlist = new List();
tokenlist.add(devicename);
tokenlist.add(tokenid);
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Settingf(text: tokenlist)),
    );
}

createbrowser(dataKey,BuildContext context){                      
    setState(() {
  () {
    String textToSend = dataKey;
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Iframeapp(text: textToSend)),
          );
        }.call();

    });
}
  //Loading counter value on start
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
    devicename = prefs.getString('deviceName');
    if (devicename == ""){
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Settingf(text: tnul)),
    );
    }
    });
  }
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();
Timer timer;

bool onhold = false;
  @override
  void initState() {
    // printIps();
    initializeFlutterFire();
    super.initState();
    initPlatformState();
    _loadCounter();
    // _sendTokentoFB();
    _configureFirebaseListeners();
  }

  @override
void dispose() {
  timer?.cancel();
  Screen.setBrightness(0.5);
  _verificationNotifier.close();
  super.dispose();
}
disScreen(){
    Screen.setBrightness(0.0);
    timer.cancel();
    }


initPlatformState() {
    setState(() {
    Screen.setBrightness(0.5);
    startTimer();
    });
    checkWifi();
  }

  
checkWifi() async{

var connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.mobile) {
  // I am connected to a mobile network.
} else if (connectivityResult == ConnectivityResult.wifi) {
  // I am connected to a wifi network.
}
else {
      
      return showDialog(context: context,builder: (context){
      return RichAlertDialog(
      alertTitle: richTitle("INTERNET KHÔNG KHẢ DỤNG",),
     alertSubtitle: richSubtitle("Vui lòng kết nối internet"),
      alertType: RichAlertType.WARNING, 
      actions: [
        FlatButton(onPressed: () 
        {
          if(connectivityResult != ConnectivityResult.none)
          {
          Navigator.pop(context);
          }
        },
        child: Text("OK"),color:Colors.lightGreen,)
      ],
    );
    }
    );
}
}
void startTimer() {
  int _start = this.timeop;
  const oneSec = const Duration(seconds: 1);
  if (timer != null){
      timer.cancel();
  }
  timer = new Timer.periodic(
    oneSec,
    (Timer timer) => setState(
      () {
        if (_start < 1) {
          disScreen();
        } else {
          _start = _start - 1;
        }
      },
    ),
  );
}
_getToken() {
  try
    {
    _firebaseMessaging.getToken().then((token) {
      tokenid = token;
      if(devicename != ""){

        FirebaseFirestore.instance.collection('fcm-token').doc(devicename).set({'device1_pt1': tokenid,'number': 0});
        print(devicename + 'Token change' + token);
      }
      else{
        _loadCounter();
      }
    });
    }
    catch (e) {
      print(e.toString());
    }
  }
//

_configureFirebaseListeners() {

      _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: false),
    );
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
         _setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
         _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
         _setMessage(message);
      },
    );

  }
  //
_setMessage(Map<String, dynamic> message)  {


    if (Theme.of(context).platform == TargetPlatform.iOS){
    final data = message['key1'];
    var timeoption = int.parse(message['iscount']);
    if(timer != null){
      timer.cancel();
    }
    if (timeoption == null)
    {
      timeoption = 300;
      setState(() {
        this.timeop = timeoption;
      });
    }
    else{
      setState(() {
        this.timeop = timeoption * 60;
      });
    }
    initPlatformState();
    String textToSend = data;
        setState((){
        createbrowser(textToSend,context);
        });
    }
    else {

    }

  }
  
  Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor:  Colors.white,
          appBar: AppBar(
            
            leading: BackButton(
              color: Colors.red,
              onPressed: (){
              },         
            ), 
            title: Text(widget.title,style: const TextStyle(fontSize: 20.0,color: Colors.white),),
            backgroundColor: Colors.red,
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                // child: GestureDetector(
                //   onTap:()  {
                    
                //   },
                //   child: Icon(
                //       Icons.notifications,
                //       color: Colors.white,
                //   ),
                // )
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onLongPress:()  {
                    initPlatformState();
                     _showLockScreen(
                          context,
                          opaque: false,
                          cancelButton: Text(
                            'Cancel',
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                            semanticsLabel: 'Cancel',
                          ),
                        );
                  },
                  child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                  ),
                )
              ),
            ],
          ),
          body:
          GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () =>initPlatformState(),
          child: 
          Container(
            child: Column(
              children:<Widget>[
                            Container(
                padding: EdgeInsets.all(0.0),
              ),
            ]
          ),
        ),
      ),
    );
  }
  //herr

  _showLockScreen(BuildContext context,
      {bool opaque,
      CircleUIConfig circleUIConfig,
      KeyboardUIConfig keyboardUIConfig,
      Widget cancelButton,
      List<String> digits}) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) => PasscodeScreen(
            title: Text(
              'Enter Passcode',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEntered,

            cancelButton: cancelButton,
            deleteButton: Text(
              'X',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'X',
            ),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            cancelCallback: _onPasscodeCancelled,
            digits: digits,
            passwordDigits: 6,
            bottomWidget: _buildPasscodeRestoreButton(),
          ),
        ),
        );
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = storedPasscode == enteredPasscode;
    _verificationNotifier.add(isValid);
  
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
              Navigator.maybePop(context).then((result) {
                        createContext(context);
      });
      });
    }
    else{
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  _buildPasscodeRestoreButton() => Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
      child: FlatButton(
        child: Text(
          "Reset passcode",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300),
        ),
        splashColor: Colors.white.withOpacity(0.4),
        highlightColor: Colors.white.withOpacity(0.2),
        onPressed: _resetAppPassword,
      ),
    ),
  );

  _resetAppPassword() {
      Navigator.maybePop(context).then((result) {
        if (!result) {
          return;
        }
        _showRestoreDialog(() {
          Navigator.maybePop(context);
          // ignore: todo
          //TODO: Clear your stored passcode here
        });
      });
    }

  _showRestoreDialog(VoidCallback onAccepted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Reset passcode",
            style: const TextStyle(color: Colors.black87),
          ),
          content: Text(
            "Passcode reset is a non-secure operation!\n\nConsider removing all user data if this action performed.",
            style: const TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(
                "Cancel",
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            FlatButton(
              child: Text(
                "I understand",
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: onAccepted,
            ),
          ],
        );
      },
    );
  }
}
  // herr