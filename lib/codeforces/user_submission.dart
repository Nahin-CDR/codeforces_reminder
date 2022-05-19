
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class UserSubmission extends StatefulWidget {
  const UserSubmission({Key? key}) : super(key: key);
  @override
  State<UserSubmission> createState() =>_UserSubmissionState();
}

String userName = "Nahin_junior71";
String problemCount = "50";

List? listResponse;
Map? mapResponse;
bool _isLoading = true;

class _UserSubmissionState extends State<UserSubmission> {
  final url = "https://codeforces.com/api/user.status?handle=$userName&from=1&count=$problemCount";

  Future ApiCall() async{
    http.Response response;
    response = await http.get(Uri.parse(url));
    print(response.statusCode);

    if(response.statusCode == 200){
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['result'];
      });
    }else{
      print("Error");
    }
    setState((){
      _isLoading = false;
    });
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
        title: const Text("User Submissions"),
        backgroundColor: Colors.black12,
      ),
      body:_isLoading? const Center(child: SpinKitRipple(color: Colors.white,size: 120)):
      ListView.builder(itemBuilder: (context,index){
        return Container(
          padding: const EdgeInsets.all(15.00),
          margin: const EdgeInsets.only(top: 10, right: 10.00, left: 10.00),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.00),
            color: Colors.white12,
          ),
          child: Column(
            children: [
              //problem name with category
              Center(
                  child: listResponse![index]['problem'] == null
                      ? const Text("Loading data")
                      : Text(
                      listResponse![index]['problem']['index'].toString()+". "+
                          listResponse![index]['problem']['name'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ))),
              //problem rating
              Center(
                child: listResponse![index]['problem'] == null
                    ? const Text("Loading data")
                    : Text(
                  "Rating : " +
                      listResponse![index]['problem']['rating'].toString(),
                  style: const TextStyle(
                    fontSize: 15,
                      color: Colors.white
                  ),
                ),
              ),
              //Problem Tags
              Center(
                child: listResponse![index]['problem'] == null
                    ? const Text("Loading data")
                    : Text(
                  "Tags : " +
                      listResponse![index]['problem']['tags'].toString(),
                  style: const TextStyle(
                    fontSize: 15,
                      color: Colors.white
                  ),
                ),
              ),
              //Participant type
              Center(
                child: listResponse![index]['author'] == null
                    ? const Text("Loading data")
                    : Text(
                  "Participant Type : " +
                      listResponse![index]['author']['participantType'].toString(),
                  style: const TextStyle(
                    fontSize: 15,
                      color: Colors.white
                  ),
                ),
              ),
              //Programming Language
              Center(
                child: listResponse![index]['programmingLanguage'] == null
                    ? const Text("Loading data")
                    : Text(
                  "Programming Language : " +
                      listResponse![index]['programmingLanguage'].toString(),
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              //Submission Status
              Center(
                child: listResponse![index]['verdict'] == null
                    ? const Text("Loading data")
                    : listResponse![index]['verdict'].toString() == "OK" ? const Text(
                  "Accepted",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ) : const Text(
                  "Wrong Answer",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          ),
        );
      },
      itemCount: listResponse == null ? 0 : listResponse?.length,
      ),
    );
  }
}
