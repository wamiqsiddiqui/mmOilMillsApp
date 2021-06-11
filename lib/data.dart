import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mmoilproject/loader.dart';
import 'package:mmoilproject/dateinput.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class Data extends StatefulWidget {
  final date;

  Data(this.date) : super();

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  QuerySnapshot data;
  dynamic refiningTank1val;
  dynamic refiningTank2val;
  dynamic crudeTank1val;
  dynamic crudeTank2val;

  getData() async {
    return await Firestore.instance
        .collection("tankdata")
        .where("udate", isEqualTo: widget.date)
        .getDocuments();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData().then((results) {
      setState(() {
        if (results.documents.isNotEmpty) {
          data = results;
          // onlyDate = DateFormat.yMMMd().add_jm().format(DateTime.parse(data.documents[0].data['date'].toDate().toString()));
          //onlyDate = onlyDate.substring(0, 13);
          // print(onlyDate);
          refiningTank1val = data.documents[0]['refiningTank1'] / 2;
          refiningTank2val = data.documents[0]['refiningTank2'] / 2;
          crudeTank1val = data.documents[0]['crudeTank1'] / 2;
          crudeTank2val = data.documents[0]['crudeTank2'] / 2;
        } else {
          Loader();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => DateInput()));
      },
      child: MaterialApp(
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Home"),
              bottom: TabBar(
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    child: Text("Refined Tank 1"),
                  ),
                  Tab(
                    child: Text("Refined Tank 2"),
                  ),
                  Tab(
                    child: Text("Crude Tank 1"),
                  ),
                  Tab(
                    child: Text("Crude Tank 2"),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Card(
                  //height: 50,
                  //padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: data != null
                      ? Padding(
                          padding: EdgeInsets.all(5),
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height:
                                      MediaQuery.of(context).size.height / 1.4,
                                  child: LiquidLinearProgressIndicator(
                                      value: 0.9,
                                      // Defaults to 0.5.
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.blue),
                                      // Defaults to the current Theme's accentColor.
                                      backgroundColor: Colors.white,
                                      // Defaults to the current Theme's backgroundColor.
                                      borderColor: Colors.black,
                                      borderWidth: 0,
                                      borderRadius: 12.0,
                                      direction: Axis.vertical,
                                      // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                                      center: Text(
                                        "Filling Up in 3,2,1...",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      )),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height:
                                      MediaQuery.of(context).size.height / 1.65,
                                  child: FAProgressBar(
                                    currentValue: data.documents[0]
                                            ['refiningTank1']
                                        .toInt(),
                                    maxValue: data.documents[0]['refiningTank1']
                                        .toInt(),
                                    size: 0,
                                    animatedDuration:
                                        const Duration(milliseconds: 4000),
                                    direction: Axis.vertical,
                                    verticalDirection: VerticalDirection.up,
                                    borderRadius: 0,
                                    backgroundColor: Colors.transparent,
                                    progressColor: Colors.blue.shade600,
                                    changeColorValue: refiningTank1val.toInt(),
                                    changeProgressColor: Colors.blue,
                                    displayText: ' Ton(s)',
                                  ),
                                ),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      SizedBox(height: 20,),
                                      Text(
                                        "Refined Tank 1",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "${widget.date}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "${data.documents[0]
                                            ['refiningTank1']
                                                .toInt()} Ton(s)",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ]),
                        )
                      : Loader(),
                ),
                Card(
                  child: data != null
                      ? Padding(
                          padding: EdgeInsets.all(5),
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height:
                                      MediaQuery.of(context).size.height / 1.4,
                                  child: LiquidLinearProgressIndicator(
                                      value: 0.9,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.blue),
                                      backgroundColor: Colors.white,
                                      borderColor: Colors.black,
                                      borderWidth: 0,
                                      borderRadius: 12.0,
                                      direction: Axis.vertical,
                                      // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                                      center: Text(
                                        "Filling Up in 3,2,1...",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      )),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height:
                                      MediaQuery.of(context).size.height / 1.65,
                                  child: FAProgressBar(
                                    currentValue: data.documents[0]
                                            ['refiningTank2']
                                        .toInt(),
                                    maxValue: data.documents[0]['refiningTank2']
                                        .toInt(),
                                    size: 0,
                                    animatedDuration:
                                        const Duration(milliseconds: 4000),
                                    direction: Axis.vertical,
                                    verticalDirection: VerticalDirection.up,
                                    borderRadius: 0,
                                    backgroundColor: Colors.transparent,
                                    progressColor: Colors.blue.shade600,
                                    changeColorValue: refiningTank2val.toInt(),
                                    changeProgressColor: Colors.blue,
                                    displayText: ' Ton(s)',
                                  ),
                                ),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      SizedBox(height: 20,),
                                      Text(
                                        "Refined Tank 2",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "${widget.date}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "${data.documents[0]
                                            ['refiningTank2']
                                                .toInt()} Ton(s)",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ]),
                        )
                      : Loader(),
                ),
                Card(
                  child: data != null
                      ? Padding(
                          padding: EdgeInsets.all(5),
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height:
                                      MediaQuery.of(context).size.height / 1.4,
                                  child: LiquidLinearProgressIndicator(
                                      value: 0.9,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.blue),
                                      backgroundColor: Colors.white,
                                      borderColor: Colors.black,
                                      borderWidth: 0,
                                      borderRadius: 12.0,
                                      direction: Axis.vertical,
                                      // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                                      center: Text(
                                        "Filling Up in 3,2,1...",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      )),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height:
                                      MediaQuery.of(context).size.height / 1.65,
                                  child: FAProgressBar(
                                    currentValue:
                                        data.documents[0]['crudeTank1'].toInt(),
                                    maxValue:
                                        data.documents[0]['crudeTank1'].toInt(),
                                    size: 0,
                                    animatedDuration:
                                        const Duration(milliseconds: 4000),
                                    direction: Axis.vertical,
                                    verticalDirection: VerticalDirection.up,
                                    borderRadius: 0,
                                    backgroundColor: Colors.transparent,
                                    progressColor: Colors.blue.shade600,
                                    changeColorValue: crudeTank1val.toInt(),
                                    changeProgressColor: Colors.blue,
                                    displayText: ' Ton(s)',
                                  ),
                                ),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      SizedBox(height: 20,),
                                      Text(
                                        "Crude Tank 1",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "${widget.date}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                              "${data.documents[0]
                                              ['crudeTank1']
                                                  .toInt()} Ton(s)",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ]),
                        )
                      : Loader(),
                ),
                Card(
                  //height: 50,
                  //padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: data != null
                      ? Padding(
                          padding: EdgeInsets.all(5),
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height:
                                      MediaQuery.of(context).size.height / 1.4,
                                  child: LiquidLinearProgressIndicator(
                                      value: 0.9,
                                      // Defaults to 0.5.
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.blue),
                                      // Defaults to the current Theme's accentColor.
                                      backgroundColor: Colors.white,
                                      // Defaults to the current Theme's backgroundColor.
                                      borderColor: Colors.black,
                                      borderWidth: 0,
                                      borderRadius: 12.0,
                                      direction: Axis.vertical,
                                      // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                                      center: Text(
                                        "Filling Up in 3,2,1...",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      )),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height:
                                      MediaQuery.of(context).size.height / 1.65,
                                  child: FAProgressBar(
                                    currentValue:
                                        data.documents[0]['crudeTank2'].toInt(),
                                    maxValue:
                                        data.documents[0]['crudeTank2'].toInt(),
                                    size: 0,
                                    animatedDuration:
                                        const Duration(milliseconds: 4000),
                                    direction: Axis.vertical,
                                    verticalDirection: VerticalDirection.up,
                                    borderRadius: 0,
                                    backgroundColor: Colors.transparent,
                                    progressColor: Colors.blue.shade600,
                                    changeColorValue: crudeTank2val.toInt(),
                                    changeProgressColor: Colors.blue,
                                    displayText: ' Ton(s)',
                                  ),
                                ),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      SizedBox(height: 20,),
                                      Text(
                                        "Crude Tank 2",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "${widget.date}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "${data.documents[0]
                                            ['crudeTank2']
                                                .toInt()} Ton(s)",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ]),
                        )
                      : Loader(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
