import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mmoilproject/dateinput.dart';
import 'package:flutter/animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MM Oil Mills',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticInOut,
    ));
    animationController.forward();
  }
  Future<bool> onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmation!"),
            content: Text("Do you want to exit?"),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                      child: Text("Yes"),
                      onPressed: () {
                        SystemNavigator.pop();
                      }
                  ),
                  FlatButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.pop(context,false);
                      }
                  ),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('MM Oil Mills'),
          ),
          body: WillPopScope(
            onWillPop: onBackPressed,
            child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Transform(
                        transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                        child: Image.asset("assets/image00111.png")),
                    Form(
                      key: formKey,
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 13),
                          child: TextFormField(
                            decoration: InputDecoration(
                              /*icon: Icon(
                                    Icons.email,
                                  ),*/
                              labelText: "Email",
                              hintText: "abc@gmail.com",
                            ),
                            validator: (input) {
                              if (input.contains("@") && input.contains(".com")) {
                                return null;
                              } else {
                                return "Invalid Email format";
                              }
                            },
                            onSaved: (input) => _email = input,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 13),
                          child: TextFormField(
                            decoration: InputDecoration(
                              /* icon: Icon(
                                    Icons.vpn_key,
                                  ),*/
                              labelText: "Password",
                              hintText: "Must be more than 6 characters",
                            ),
                            validator: (input) {
                              if (input.length > 6) {
                                return null;
                              } else {
                                return "Your password must have atleast 6 characters";
                              }
                            },
                            obscureText: true,
                            onSaved: (input) => _password = input,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Transform(
                          transform: Matrix4.translationValues(0.0, animation.value*width, 0.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 18,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.blue.shade500,
                                    Colors.blue,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(0)),
                            child: FlatButton(
                              onPressed: signIn,
                              child: Text(
                                "Login".toUpperCase(),
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
          ),
        );
      },
    );
  }

  Future<FirebaseUser> signIn() async {
    final formState = formKey.currentState;
    FirebaseUser user;
    AuthResult result;
    if (formState.validate()) {
      formState.save();
      try {
        result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        user = result.user;
        print("Logged in");
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => DateInput()));
        return user;
      } catch (e) {
        e.message=="The email address is badly formatted."?showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error!"),
                content: Text("Remove extra space(s) after your email"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Try Again!"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }):showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error!"),
                content: Text("Incorrext email or password"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Try Again!"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
        print("Login Failed ${e.message} $_email $_password");
        return null;
      }
    } else {
      return null;
    }
  }
}