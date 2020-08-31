import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_register/FirstPage.dart';
import 'package:login_register/loginpage.dart';



class Registerpage extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");





  @override
  Widget build(BuildContext context) {


    void registerToFb() {
      firebaseAuth
          .createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text)
          .then((result) {
        dbRef.child(result.user.uid).set({
          "email": _emailController.text,
          "name": _nameController.text,
          "contectno": _contactController.text
        }).then((res) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        });
      }).catchError((err) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(err.message),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
    }






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
                            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child:
                            Text("REGISTER",style: TextStyle(color: Colors.white,fontSize: 36,fontWeight: FontWeight.bold),),
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
                      height: 450,
                      child: Column(
                        children: [
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
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'All field Required';
                                }
                                return null;
                              },
                            ),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child:
                            TextFormField(
                              controller: _nameController,
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
                                hintText: 'Name',
                                //hintStyle: TextStyle(fontSize: 22,color: Hexcolor('#06c4de'),fontFamily: 'Segoe UI'),

                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'All field Required';
                                }
                                return null;
                              },
                            ),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child:
                            TextFormField(
                              controller: _contactController,
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
                                hintText: 'Contact No',
                                //hintStyle: TextStyle(fontSize: 22,color: Hexcolor('#06c4de'),fontFamily: 'Segoe UI'),

                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'All field Required';
                                }
                                return null;
                              },
                            ),

                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'All field Required';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child:
                            TextFormField(

                              obscureText: true,
                              obscuringCharacter: '*',
                              controller: _ConfirmController,
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
                                hintText: 'Confirm Password',
                                //hintStyle: TextStyle(fontSize: 22,color: Hexcolor('#06c4de'),fontFamily: 'Segoe UI'),

                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'All field Required';
                                }
                                return null;
                              },
                            ),),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child:
                              ButtonTheme(
                                child:
                                new RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      //side: BorderSide(width: 1900)
                                    ),
                                    color: Colors.indigoAccent,
                                    child: new Text('Register', style: TextStyle(fontFamily: 'Dosis')),
                                    // ignore: missing_return
                                    onPressed:()
                                    {

                                      if (_formKey.currentState.validate()) {
                                        if(_ConfirmController.text == _passwordController.text)
                                                registerToFb();
                                      }

                                    }
                                ),
                                minWidth: 200,
                              )),
                        ],
                      ),
                      //color: Colors.indigoAccent,
                    ),
                  )

              ),
            ],
          )),
    ));
  }
}
