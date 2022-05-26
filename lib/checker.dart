import 'dart:convert';
import 'dart:io';
import 'package:codeforces_reminder/menus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'codeforces/user_contest_list.dart';

class Checker extends StatefulWidget {
  const Checker({Key? key}) : super(key: key);
  @override
  State<Checker> createState() => _CheckerState();
}

String name = "Login";
//String userName = "Nahin_junior71";
List? listResponse;
Map? mapResponse;

class _CheckerState extends State<Checker> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _sharedData({required handle}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('handle', handle);
  }



  TextEditingController userName = TextEditingController();

  //String userHandle = "";
  bool _error = false;
  Future ApiCall({required userHandle}) async {
    //final url = "https://codeforces.com/api/user.info?handles=$userHandle";
    http.Response response;
    response = await http.get(Uri.parse("https://codeforces.com/api/user.info?handles=${userHandle}"));
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        _error = false;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['result'];
        if (listResponse == null) {
          print("nothing to show");
        }
      });
      print("success");
    } else {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: _error
            ? Text("${name.toString()}",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))
            : Text(
                "${name.toString()}",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        backgroundColor: Colors.black12,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                onChanged: (value) => {
                  setState(() {
                    ApiCall(userHandle: userName.text);
                    name = userName.text;
                    _sharedData(handle: userName.text);
                  })
                },
                style: TextStyle(color: Colors.white),
                controller: userName,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  counterStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: "user name here",
                  hintStyle: TextStyle(fontSize: 10.0, color: Colors.white),
                  labelText: "user handle",
                  labelStyle: TextStyle(color: Colors.white),
                ),
                autofocus: true,
                keyboardType: TextInputType.name,
                maxLength: 20,
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Container(
                height: 50,
                width: 150,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white12),
                    onPressed: () async {
                      if (userName.text.isNotEmpty) {
                        ApiCall(userHandle: userName.text);
                        if (_error) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              "Invalid User Handle",
                              style: TextStyle(
                                fontSize: 12.00,
                              ),
                            ),
                            duration: Duration(milliseconds: 1000),
                          ));
                        } else {
                          try {
                            final result =
                                await InternetAddress.lookup('google.com');
                            if (result.isNotEmpty &&
                                result[0].rawAddress.isNotEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  "Logging in...",
                                  style: TextStyle(
                                      fontSize: 12.00, color: Colors.white),
                                ),
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: Colors.green,
                              ));
                              _sharedData(handle: name);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return MENUS();
                              }));
                            }
                          } on SocketException catch (_) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                "You are disconnected from internet...",
                                style: TextStyle(
                                    fontSize: 12.00, color: Colors.white),
                              ),
                              duration: Duration(milliseconds: 1000),
                              backgroundColor: Colors.red,
                            ));
                          }
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          //   return MENUS(givenHandle: name);
                          // }));
                        }
                      } else {
                        showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.blueGrey,
                                title: const Text(
                                  'Attention!',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text(
                                        'Empty Input field !!!\nPlease enter a valid user handle.',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Try again',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    child: Text("Login")),
              ))
        ],
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
