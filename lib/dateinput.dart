import 'package:flutter/material.dart';
import 'package:mmoilproject/data.dart';
import 'package:mmoilproject/main.dart';
import 'package:toast/toast.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class DateInput extends StatefulWidget {
  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  bool flag;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flag=false;
  }
  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmation!"),
            content: Text("Do you want to logout?"),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                      child: Text("Yes"),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>MyHomePage()));
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
  final GlobalKey<ScaffoldState> _scaffoldkey =GlobalKey<ScaffoldState>();
  String inputdate;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Choose Date"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Image.asset("assets/image00111.png"),
                SizedBox(height: 20,),
                Text("Pick Your Date",style: TextStyle(fontSize: 20)),
                SizedBox(height: 20,),
                DatePickerWidget(
                  pickerTheme: DateTimePickerTheme(
                    backgroundColor: Colors.transparent,
                    cancel: Text(""),
                    pickerHeight: 150
                  ),
                  onCancel: (){
                    Navigator.pop(context);
                  },
                  maxDateTime: DateTime.now(),
                  minDateTime: DateTime(2019,11,29),
                  onConfirm: (DateTime dt,List l){
                    setState(() {
                      flag=true;
                      inputdate=dt.year.toString()+"-"+dt.month.toString()+"-"+dt.day.toString();
                    });
                    print(inputdate);
                    Toast.show("Date Picked: $inputdate", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>DateInput()));
                  },
                ),
                SizedBox(height: 20,),
                Container(
                  height: MediaQuery.of(context).size.height/18,
                  width: MediaQuery.of(context).size.width/1.7,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors:[
                          Colors.blue.shade800,
                          Colors.blue,
                        ],
                      ),
                  ),
                  child: FlatButton(
                    onPressed:(){
                      if(flag==true) {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Data(inputdate)));
                      }
                      else{
                        setState(() {
                          flag=false;
                        });
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Selection not confirmed"),
                            content: Text("Please confirm your date selection"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Okay"),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        }
                      );
                    }
                      },
                    child: Text(
                      "Show Results".toUpperCase(),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: MediaQuery.of(context).size.height/18,
                  width: MediaQuery.of(context).size.width/2.2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors:[
                          Colors.redAccent.shade200,
                          Colors.pink,
                        ],
                      ),
                  ),
                  child: FlatButton(
                    onPressed:_onBackPressed,
                    child: Text(
                      "LOGOUT".toUpperCase(),
                      style: TextStyle(color: Colors.white,fontSize: 16),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
