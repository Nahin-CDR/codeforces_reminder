import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class UserContestList extends StatefulWidget {
  
  final String id;
  UserContestList({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<UserContestList> createState() => _UserContestListState(userHandle: id);
}

List? listResponse;
Map? mapResponse;
bool _isLoading = true;

class _UserContestListState extends State<UserContestList> {

  String userHandle;
  _UserContestListState({required this.userHandle});
  get ID => userHandle.toString();


 // String userHandle = "Nahin_junior71";

  Future ApiCall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://codeforces.com/api/user.rating?handle=$userHandle"));
    print(response.statusCode);
    // int worstRank = 0;
    // int bestRank = 999999999;
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['result'];

        // listResponse?.forEach((element) {
        //   if(worstRank < element['rank'] ){
        //       worstRank = element['rank'];
        //   }
        //   if(bestRank>element['rank']){
        //      bestRank = element['rank'];
        //   }
        // });




      });
    } else {
      print("Error");
    }
    setState((){
      _isLoading = false;
    });
    // print("best rank"+bestRank.toString());
    // print("worst rank"+worstRank.toString());
  }
  //call this ApiCall() method at first when u come to this page
  @override
  void initState() {
    // TODO: implement initState
    ApiCall();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Text("User's Contest list"),
        backgroundColor: Colors.black12,
      ),
      body: _isLoading? const Center(child: SpinKitRipple(color: Colors.white,size: 120)):  ListView.builder(
        itemBuilder: (context, index) {
          return Container(
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
                  const EdgeInsets.only(top: 5, right: 5.00, left: 5.00),
                  child: Center(
                      child: listResponse![index]['contestName'] == null
                          ? const Text("Loading data")
                          : Text(listResponse![index]['contestName'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                  ),
                ),

                //Rank
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  child: Center(
                    child: listResponse![index]['rank'] == null
                        ? const Text("Loading data")
                        : Text(
                      "Rank : " + listResponse![index]['rank'].toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                //Old Rating
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  child: Center(
                    child: listResponse![index]['oldRating'] == null
                        ? const Text("Loading data")
                        : Text(
                      "Old Rating : " +
                          listResponse![index]['oldRating'].toString(),
                      style: const TextStyle(
                        fontSize: 15,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                //New Rating
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  child: Center(
                    child: listResponse![index]['newRating'] == null
                        ? const Text("Loading data")
                        : Text(
                      "New Rating : " +
                          listResponse![index]['newRating'].toString(),
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                //Submission Status
              ],
            ),
          );
        },
        itemCount: listResponse == null ? 0 : listResponse?.length,
      ),
    );
  }
}
