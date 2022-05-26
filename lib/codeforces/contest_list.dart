
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:codeforces_reminder/codeforces/rating_changes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;


class ContestList extends StatefulWidget {
  const ContestList({Key? key}) : super(key: key);
  @override
  State<ContestList> createState() =>_ContestListState();
}

List? listResponse;
Map? mapResponse;
bool _isLoading = true;

class _ContestListState extends State<ContestList> {
  final url = "https://codeforces.com/api/contest.list?gym=false";

  Future ApiCall() async{
    http.Response response;
    response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['result'];

      });
    }
    setState((){_isLoading = false;});

  }

  //call this ApiCall() method at first when u come to this page
  @override
  void initState() {
    // TODO: implement initState
    ApiCall();
    super.initState();
    //if server is taking too much time to respond
    Timer(const Duration(seconds: 30), () {
      if(_isLoading == true) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                title: const Text("Sorry!", style: TextStyle(color: Colors.white)),
                content: const Text("I'm unable to show data,server is not responding..",style: TextStyle(color: Colors.white)),
                actions: <Widget>[
                  TextButton(
                    child: const Text('exit',style: TextStyle(color: Colors.white)),
                    onPressed: (){
                      exit(0);
                    },
                  ),
                ],
              );
            });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Text("Last 50 Contests"),
        backgroundColor: Colors.black12,
      ),
      body: _isLoading?const Center(child: SpinKitRipple(color: Colors.white,size: 100)) :
      ListView.builder(
        itemCount: listResponse == null ? 0 : 50,
        itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){
            if(listResponse![index]['phase'].toString() == "FINISHED" && listResponse![index]['type'].toString() == "CF"){
             // Go to rating changes page
              Navigator.push(context,MaterialPageRoute(builder: (context) => RatingChanges(id:listResponse![index]['id'].toString())),);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Rating didn't change yet for this contest", style: TextStyle(fontSize: 17.00,)), duration: Duration(milliseconds: 1000),
              ));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(15.00),
            margin: const EdgeInsets.only(top: 10, right: 10.00, left: 10.00),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.00),
              color: Colors.white12,
            ),
            child: Column(
              children: [
                //Contest Name
                Container(
                  margin:
                  const EdgeInsets.only(top: 10, right: 10.00, left: 10.00),
                  child: Center(
                      child: listResponse![index]['name'] == null
                          ? const Text("Loading data")
                          : Text(
                          listResponse![index]['name'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  child: Center(
                    child: listResponse![index]['phase'] == null
                        ? const Text("Loading data")
                        : listResponse![index]['phase'].toString() == "BEFORE"? const Text("In Queue",
                          style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                          fontWeight: FontWeight.bold
                        ),
                    ):const Text("Finished", style: TextStyle(fontSize: 15, color: Colors.white,)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      ),
    );
  }
}
