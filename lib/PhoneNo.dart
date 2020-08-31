
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:login_register/FirstPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_register/loginpage.dart';

var pn = "";
class PhoneAuth extends StatefulWidget {


  @override
  PhoneAuthState createState() => PhoneAuthState();
}
var validatess = 1;
class PhoneAuthState extends State<PhoneAuth> {
  String phoneNo;
  String smsCode;
  String verificationId;






  Future<void> verifyPhone() async {
    print(1);
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
      print(2);
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed in');
      });
    };
    print(3);
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential credential) {
      print("Verificado");
      Navigator.push(
          context,
          // ignore: always_specify_types
          MaterialPageRoute(builder: (BuildContext contxt) => FirstScreen()));
    };

    print(4);
    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');

    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: pn,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter SMS Code'),
            content:
            TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
              keyboardType: TextInputType.number,
              //decoration: InputDecoration(errorText:validatecode(smsCode),),

            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[

              Text(validatess==2?'Please enter correct Code':'',style: TextStyle(color: Colors.redAccent),),

              Column(
                children:<Widget>[
                  Row(
                      children:<Widget>[
                        FlatButton(
                            child: Text("Resend"),
                            onPressed:() {
                              Navigator.of(context,rootNavigator: true).pop();
                              verifyPhone;

                            }
                        ),
                        SizedBox(
                          width: 40,
                          height: 50,

                        ),
                        FlatButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }

                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            onPressed:
                                (){
                              if(smsCode.length != 6)
                              {
                                setState(() {
                                  validatess = 2;
                                });
                              }
                              else {
                                FirebaseAuth.instance.currentUser().then((
                                    user) {
                                  if (user != null) {
                                    signIn();
                                    //Navigator.of(context).pop();
                                    //Navigator.of(context).pushReplacementNamed('/homepage');
                                    //Navigator.of(context,rootNavigator: true).pop();
                                  } else {
                                    //Navigator.of(context).pop();
                                    //signIn();
                                    setState(() {
                                      validatess = 2;
                                    });
                                  }
                                });
                              }},

                            child: Text('Done'),
                            textColor: Colors.white,
                            elevation: 7.0,
                            color: Colors.blue),
                      ])],
              ),
            ],
          );
        });
  }

  signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    Navigator.of(context).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => FirstScreen()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Center(
          child:
          Stack(
            children: [
              Column(
                children: <Widget> [
                  Container(
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        border: Border.all(
                          //color: Colors.red[500],
                        ),
                        borderRadius:  new BorderRadius.only(
                          bottomLeft: const Radius.circular(100.0),
                          bottomRight: const Radius.circular(100.0),
                        )
                    ),
                    width: 900,
                    height: 500,

                    child:
                        Column(
                          children:[
                        Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 300, 0),
                              child:
                            FlatButton(
                                child: Icon(Icons.keyboard_arrow_left,color: Colors.white,size: 50,),
                                onPressed: ()
                                {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginPage()),
                                  );
                                })),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
                      child:
                      Text("WELCOME",style: TextStyle(color: Colors.white,fontSize: 36,fontWeight: FontWeight.bold),),
                    ),
                    //color: Colors.indigoAccent,
                  ])),
                  //Text("WELCOME",style: TextStyle(color: Colors.black),),

                ],
              ),
              Padding(

                  padding: EdgeInsets.fromLTRB(0, 90, 10, 0),
                  child:
                  Center(
                    child:  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          //color: Colors.red[500],
                        ),
                        borderRadius:  new BorderRadius.all(Radius.circular(20)),
                      ),
                      width: 300,
                      height: 200,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 10,
                                height: 10,
                              ),
                              //Flexible(
                              // child:
                              DropdownButton<String>(
                                disabledHint: const Text('+91',style: TextStyle(color: Colors.black),),
                                items: <String>['+91'].map((String value) {
                                  return const DropdownMenuItem<String>(
                                    value: '+91',
                                    child: Text('+91',style: TextStyle(color: Colors.black),),
                                  );
                                }).toList(),
                                value: '+91',
                                onChanged: (_) {
                                },
                              ),
                              /* TextField(
                          decoration: InputDecoration(hintText: '+91',hintStyle: TextStyle(color: Colors.white),fillColor: Colors.blue,),
                          decoration: InputDecoration(hintText: '+91',hintStyle: TextStyle(color: Colors.white),fillColor: Colors.blue,),
                          keyboardType: TextInputType.text,

                          style: TextStyle(color: Colors.white),

                        ),*/

                              // ),
                              const SizedBox(
                                width: 10,
                                height: 0,
                              ),
                              Flexible(
                                child:
                                TextField(

                                  decoration: InputDecoration(hintText: 'Enter 10 digit number',hintStyle: TextStyle(color: Colors.black),fillColor: Colors.blue),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    this.phoneNo = "+91"+value;
                                    pn = this.phoneNo;

                                  },
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                                height: 0,
                              ),

                            ],
                          ),
                          const SizedBox(height: 20.0,width: 0,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(

                                  //padding: EdgeInsets.fromLTRB(90, 10, 50, 10),
                                  onPressed:(){
                                    Fluttertoast.showToast(
                                        msg: "Please Wait.....",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIos: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    print(pn);
                                    verifyPhone();},
                                  // () {
                                  //Navigator.of(context).push(MaterialPageRoute(
                                  //    builder: (BuildContext context) => MyHomePage()));
                                  // },
                                  child: Text('Verify'),
                                  textColor: Colors.white,
                                  //elevation: 7.0,
                                  color: Colors.indigoAccent,
                                  //padding: EdgeInsets.fromLTRB(90, 10, 50, 10)
                                ),]
                          ),
                          WillPopScope(
                            //Wrap out body with a `WillPopScope` widget that handles when a user is cosing current route
                            // ignore: missing_return
                            onWillPop: () async {
                              // ignore: always_specify_types
                              Future.value(
                                  false); //return a `Future` with false value so this route cant be popped or closed.
                            },
                            child: const Center(
                              child: Text(''),
                            ),)
                        ],
                      )
                      //color: Colors.indigoAccent,
                    ),
                  )

              ),

            ],
      ),
      //)
    ));
  }
}
