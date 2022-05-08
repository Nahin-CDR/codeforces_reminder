import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class UserContestList extends StatefulWidget {

  @override
  State<UserContestList> createState() => _UserContestListState();
}

List? listResponse;
Map? mapResponse;

class _UserContestListState extends State<UserContestList> {
  String userHandle = "Nahin_junior71";

  Future ApiCall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://codeforces.com/api/user.rating?handle=$userHandle"));
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['result'];
      });
    } else {
      print("Error");
    }
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
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text("User's Contest list"),
        backgroundColor: Colors.black12,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(15.00),
            margin: const EdgeInsets.only(top: 10, right: 10.00, left: 10.00),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.00),
              color: Colors.white,
            ),
            child: Column(
              children: [
                //Contest Name
                Container(
                  margin:
                  const EdgeInsets.only(top: 10, right: 10.00, left: 10.00),
                  child: Center(
                      child: listResponse![index]['contestName'] == null
                          ? const Text("Loading data")
                          : Text(listResponse![index]['contestName'].toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.green,
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
                        fontSize: 18,
                        color: Colors.black,
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
                        fontSize: 18,
                        color: Colors.black,
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
                      style: const TextStyle(fontSize: 18),
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
