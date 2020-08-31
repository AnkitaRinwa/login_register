import 'package:flutter/material.dart';
import 'package:login_register/loginpage.dart';
import 'package:login_register/model/user_repository.dart';
import 'package:provider/provider.dart';

class Authent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigoAccent,
        body:
        Center(
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
                            Provider.of<UserRepository>(context).signOut();
                          })),
                  Container(
                      width: 500,
                      height: 500,
                      color: Colors.white,
                      child:
                          Center(
                            child:
                      CircularProgressIndicator()),
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

                ])));
  }
}