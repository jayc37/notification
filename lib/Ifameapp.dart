import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LaunchUrl.dart';

class Iframeapp extends StatefulWidget {
    final String text;
    final int timeop;
    Iframeapp({Key key, @required this.text, this.timeop}) : super(key: key);
  @override
  _IframeappState createState() => _IframeappState(text:text,timeop:timeop);
}
class _IframeappState extends State<Iframeapp>
{
  int count = 0;
  String device_name = '';
  double brightness;
  bool isopn = true;
  //Loading counter value on start
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
    device_name = prefs.getString('deviceName');
    
    FirebaseFirestore.instance.collection('fcm-token').doc(device_name).update({'number': 0});
    });
  }
  
  // bool _isKeptOn = false;
  // double _brightness = 1.0;
    @override
  void initState() {
    initPlatformState();
    super.initState();
    _loadCounter();

  }
    final String text;
    final int timeop;
    _IframeappState({@required this.text, this.timeop});
  InAppWebViewController webView;
  String url = "";
  double progress = 0;
  
  @override
void dispose() {
  super.dispose();
    // timer?.cancel();
  Screen.setBrightness(0.5);
}
// @protected
// @mustCallSuper
// void deactivate(){
//   super.deactivate();
// }
// int _u;
// Timer timer;

// startTime(reset){
//   this._u = reset;
//   const oneSec = const Duration(seconds: 1);
//   if (isopn){
//           timer = Timer.periodic(
//             oneSec,
//             (Timer timer) => setState(
//       () {
//           if (_u < 1) {
//             disScreen();
//           } else {
//             _u = _u -1;
//           }
//         },
//       ),
//     );
//   }
// }
// void startTimer(timeop) {
//       startTime(timeop);
// }

initPlatformState()  {
    setState(() {
    Screen.setBrightness(0.5);
    });
  }
// void  disScreen(){
//     Screen.setBrightness(0.0);
//     // timer.cancel();
//     }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: null,
        
        body: 
         GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              isopn = false;
            });
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LaunchUrlDemo()),
            );
          },
          child:
        Container(
          child: Column(children: <Widget>[
            Container(
                padding: EdgeInsets.all(0.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container()),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(0.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                child: 
                Stack(children: [
                InAppWebView(
                  initialUrl: this.text,
                  initialHeaders: {},
                  initialOptions: InAppWebViewGroupOptions(
                    
                    crossPlatform: InAppWebViewOptions(
                      
                        debuggingEnabled: true,
                        javaScriptEnabled: true,
                    )
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                  },
                  onLoadStart: (InAppWebViewController controller, String url) {
                    setState(() {
                      this.url = text;
                    });
                  },
                  onLoadStop: (InAppWebViewController controller, String url)  {
                    setState(() {
                      this.url = text;
                      // if (count == 0){

                      //   webView.evaluateJavascript(source:
                      // """
                      // document.getElementsByName("UserName")[0].value = "00340";
                      // document.getElementsByName("PassWord")[0].value = "PT123456";
                      // document.getElementsByClassName("btn")[0].click();
                      // """);
                      // }
                      // count+= 1;

                    // controller.injectJavascriptFileFromAsset(assetFilePath: "images/js/in.js");
                    });
                  },
                  onProgressChanged: (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
                      GestureDetector(
                    
                            
                          //  onDoubleTap: () async {
                          //   double brightness = await Screen.brightness;
                          //    if (brightness == 0.0){
                          //     Screen.setBrightness(0.5);
                          //     startTime(300);
                          //    }
                          //    },
                  ),
                ],)
              ),
            ),
            ButtonBar(
              
              alignment: MainAxisAlignment.center,
              
              children: <Widget>[
                
                // RawMaterialButton(
                  
                //   child: Icon(Icons.home,size: 10.0,),
                //   onPressed: () {

                //         Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => LaunchUrlDemo()),
                //       );
                //   },
                //    elevation: 2.0,
                //     fillColor: Colors.white,
                //       padding: EdgeInsets.all(10.0),
                //       shape: CircleBorder(),
                // ),
              ],
            ),
        ])),),
      ),
    );
  }
}
//
