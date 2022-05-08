import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

Map? mapResponse;
Map? dataResponse;
List? listResponse;
String? element;

class API extends StatefulWidget {
  @override
  _APIState createState() => _APIState();
}

class _APIState extends State<API> {
  final url = "https://codeforces.com/api/contest.ratingChanges?contestId=566";

  Future ApiCall() async {
    http.Response response;
    response = await http.get(Uri.parse(url));
    print(response.statusCode);
    //json.decode(response.body)['status'] == "OK"
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['result'];
      });
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    ApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CodeForces"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(15.00),
            margin: new EdgeInsets.only(top: 10, right: 10.00, left: 10.00),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.00),
              color: Colors.black12,
            ),
            child: Column(
              children: [
                Container(
                  height: 40.00,
                  margin:
                      new EdgeInsets.only(top: 10, right: 10.00, left: 10.00),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.00),
                    color: Colors.black12,
                  ),
                  child: Center(
                      child: listResponse![index]['contestId'] == null
                          ? Text("Loading data")
                          : Text(
                              "contestId : " +
                                  listResponse![index]['contestId'].toString(),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ))),
                ),
                Container(
                  margin: new EdgeInsets.only(top: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  child: Center(
                    child: listResponse![index]['contestName'] == null
                        ? Text("Loading data")
                        : Text(
                            "contestName : " +
                                listResponse![index]['contestName'].toString(),
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
                Container(
                  margin: new EdgeInsets.only(top: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  child: Center(
                    child: listResponse![index]['handle'] == null
                        ? Text("Loading data")
                        : Text(
                            "handle : " +
                                listResponse![index]['handle'].toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                Container(
                  margin: new EdgeInsets.only(top: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  child: Center(
                    child: listResponse![index]['rank'] == null
                        ? Text("Loading data")
                        : Text(
                            "rank : " + listResponse![index]['rank'].toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                Container(
                  margin: new EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  child: Center(
                    child: listResponse![index]['newRating'] == null
                        ? Text("Loading data")
                        : Text(
                            "newRating : " +
                                listResponse![index]['newRating'].toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: listResponse == null ? 0 : listResponse!.length,
      ),
    );
  }
}
