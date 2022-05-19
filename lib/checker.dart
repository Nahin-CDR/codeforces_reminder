import 'dart:convert';
import 'package:codeforces_reminder/menus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'codeforces/user_contest_list.dart';

class Checker extends StatefulWidget {
  const Checker({Key? key}) : super(key: key);
  @override
  State<Checker> createState() =>_CheckerState();
}
String name ="";
//String userName = "Nahin_junior71";
List? listResponse;
Map? mapResponse;
class _CheckerState extends State<Checker> {

  TextEditingController userName = TextEditingController();

  //String userHandle = "";
   bool _error = false;
   Future ApiCall({required userHandle}) async{
    final url = "https://codeforces.com/api/user.info?handles=$userHandle";
    http.Response response;
    response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if(response.statusCode == 200){
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['result'];
        if(listResponse == null) {
          print("nothing to show");
        }
      });
      print("success");
    }else{
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("User Info"),
        backgroundColor: Colors.black12,
      ),
      body:SafeArea(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child:   Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextField(
                  onChanged: (value) => {
                    setState((){
                      name = userName.text;
                    })
                  },
                    controller: userName,
                    decoration: InputDecoration(
                    hintText: "user name here",
                    hintStyle: TextStyle(fontSize: 10.0),
                    labelText: "user handle",
                    labelStyle: TextStyle(color: Colors.deepOrange),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                      suffixIcon: Icon(Icons.abc_outlined),
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  maxLength: 20,
                ),
              ),
            ),
            Flexible(
                flex: 1,
                child:  Container(
                  height: 50, width: 150,
                  child: ElevatedButton(
                      onPressed: (){
                        if(userName.text.length>0)
                          {
                            //setState(() {
                              ApiCall(userHandle: name);
                              if(_error){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Invalid User Handle",
                                    style: TextStyle(
                                      fontSize: 17.00,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 1000),
                                ));
                              }else{
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                  return MENUS(givenHandle: name);
                                }));
                              }
                           // });
                          }else{
                          showCupertinoDialog(context: context, builder: (context){
                            return  AlertDialog(
                              title: const Text('Information Mismatched !'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: const <Widget>[
                                    Text('given user name or password is incorrect'),
                                    Text('please be careful!'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Try again'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                        }},
                      child: Text("Login")
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget showError() {
   return AlertDialog(
      title: const Text('Information Mismatched !'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('given user name or password is incorrect'),
            Text('please be careful!'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Try again'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}


