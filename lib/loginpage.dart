import 'package:flutter/material.dart';
import 'package:login_register/FirstPage.dart';
import 'package:login_register/PasswordRest.dart';
import 'package:login_register/PhoneNo.dart';
import 'package:login_register/RegisterPage.dart';
import 'package:login_register/model/user_repository.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';



class LoginPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
                        child:
                  Text("WELCOME",style: TextStyle(color: Colors.white,fontSize: 36,fontWeight: FontWeight.bold),),
                      ),
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
                height: 400,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("LOGIN",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
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
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child:
                      TextFormField(
                        obscureText: true,
                        obscuringCharacter: '*',
                        controller: _passwordController,
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
                          hintText: 'Password',

                          //hintStyle: TextStyle(fontSize: 22,color: Hexcolor('#06c4de'),fontFamily: 'Segoe UI'),

                        ),
                        validator: (String value) {
                          if (value.isEmpty) return 'Please enter some text';
                          return null;
                        },
                      ),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(120, 0, 0, 0),
                      child:
                      FlatButton(
                        onPressed: ()
                        {
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                                return new ResetPasswordPage();
                              }));

                        },
                        child: Text("Forget Password"),
                      )),

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
                          child: new Text('Login', style: TextStyle(fontFamily: 'Dosis')),
                          // ignore: missing_return
                          onPressed:()
                         {
                           if (_formKey.currentState.validate()) {
                             user.signIn(
                                 _emailController.text, _passwordController.text);
                           }


                          }
                      ),
                      minWidth: 200,
                    )),
                    SizedBox(
                      //width: 30,
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 70,

                        ),
                        FloatingActionButton(
                          heroTag: "btn1",
                          onPressed: ()
                          {

                            Navigator.of(context)
                                .push(MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                                  return new PhoneAuth();
                                }));


                          },
                          backgroundColor: Colors.orange,
                          child: Icon(Icons.phone_android),
                        ),
                        SizedBox(
                          width: 20,

                        ),
                        FloatingActionButton(
                          heroTag: "btn2",
                          onPressed: ()
                          async {
                            if (!await user.signInWithFB())
                            SnackBar(
                            content: Text("Something is wrong"),
                            );

                          },
                          backgroundColor: Colors.blue,
                          child: Text("f"),
                        ),
                        SizedBox(
                          width: 20,

                        ),
                        FloatingActionButton(
                          heroTag: "btn3",
                          onPressed: ()
                          async {

                            if (!await user.signInWithGoogle())
                             SnackBar(
                                content: Text("Something is wrong"),
                              );

                          print("Ok");
                            user.signInWithGoogle().whenComplete(() {

                          });
                          },
                          backgroundColor: Colors.red,
                          child: Text("G+"),
                        ),
                      ],
                    ),
                  ],
                ),
                //color: Colors.indigoAccent,
              ),
            )

            ),
            Padding(
              padding: EdgeInsets.fromLTRB(100, 700, 0, 0),
              child:
              Row(
              children:[
            Text("No Account  "),
                FlatButton(
                  onPressed: ()
                    {
                      Navigator.of(context)
                          .push(MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                            return new Registerpage();
                          }));


                    },
                    //disabledColor: Colors.blue,
                  child: Text("Create Account",style: TextStyle(color: Colors.blue),),

                ),
        ]
            ))
          ],
            )),
      ));
  }
}

