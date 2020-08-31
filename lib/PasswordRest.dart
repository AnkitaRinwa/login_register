import 'package:flutter/material.dart';
import 'package:login_register/FirstPage.dart';
import 'package:login_register/PhoneNo.dart';
import 'package:login_register/RegisterPage.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_register/loginpage.dart';
import 'package:login_register/model/user_repository.dart';
import 'package:provider/provider.dart';



class ResetPasswordPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();






  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);


    return Scaffold(
        body:
        Form(
          key: _formKey,
          child:
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
                                Text("RESET PASSWORD",style: TextStyle(color: Colors.white,fontSize: 36,fontWeight: FontWeight.bold),),
                              ),
                              //color: Colors.indigoAccent,
                            ])
                        //color: Colors.indigoAccent,
                      ),
                      //Text("WELCOME",style: TextStyle(color: Colors.black),),

                    ],
                  ),
                  Padding(

                      padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
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
                          width: 350,
                          height: 200,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("RESET PASSWORD",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child:
                                TextFormField(
                                  controller: _emailController,
                                  textAlign: TextAlign.center,
                                  //style: TextStyle(color: Hexcolor('#06c4de'),fontFamily: 'Segoe UI'),
                                  decoration: new InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      // borderSide: BorderSide(color: Hexcolor('#06c4de'), width: 1.0),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      // borderSide: BorderSide(color: Hexcolor('#06c4de'), width: 1.0),
                                    ),
                                    hoverColor: Colors.red,
                                    //icon: const Icon(Icons.email),
                                    hintText: 'Email Address',
                                    //hintStyle: TextStyle(fontSize: 22,color: Hexcolor('#06c4de'),fontFamily: 'Segoe UI'),

                                  ),
                                  validator: (String value) {
                                    if (value.isEmpty) return 'Please enter some text';
                                    return null;
                                  },
                                ),),


                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child:
                                  ButtonTheme(
                                    child:
                                    new RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          //side: BorderSide(width: 1900)
                                        ),
                                        color: Colors.indigoAccent,
                                        child: new Text('Rest Password', style: TextStyle(fontFamily: 'Dosis')),
                                        // ignore: missing_return
                                        onPressed:()
                                        {

                                          user.resetPassword(_emailController.text);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => LoginPage()),
                                          );




                                        }
                                    ),
                                    minWidth: 200,
                                  )),

                ],
              ))
    ))
    ])),
        ));

  }
}

