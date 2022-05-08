import 'package:flutter/material.dart';

import 'codeforces/contest_list.dart';
import 'codeforces/set_reminder.dart';
import 'codeforces/top_rated.dart';
import 'codeforces/user_contest_list.dart';
import 'codeforces/user_info.dart';
import 'codeforces/user_statistics.dart';
import 'codeforces/user_submission.dart';
class MENUS extends StatefulWidget {
  const MENUS({Key? key}) : super(key: key);
  @override
  State<MENUS> createState() => _MENUSState();
}
class _MENUSState extends State<MENUS> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50.00),
              ),
              color: Colors.black38,
            ),
            child: Stack(
              children: [
                Positioned(
                    top:30,
                    left: 0,
                    child:Container(
                      height: 80,
                      width: 200,
                      decoration: const BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.00),
                            bottomRight: Radius.circular(50.00),
                          )
                      ),
                    )
                ),
                const Positioned(
                    top: 50,
                    left: 10,
                    child: Text("  Menus",style:
                    TextStyle(fontSize: 30.00, color: Colors.grey, fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                //user Profile
                Container(
                  margin: EdgeInsets.all(10),
                  child: InkWell(
                      borderRadius: BorderRadius.only(
                        // topLeft: Radius.circular(50.00),
                          bottomRight: Radius.circular(50.00)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            UserInfo()));
                      },
                      child: Ink(
                        height: MediaQuery.of(context).size.height/12,
                        width: MediaQuery.of(context).size.width-20,
                        decoration: BoxDecoration(
                            color:Colors.black12,
                            borderRadius: BorderRadius.only(
                              // topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(50.00),
                            )
                        ),
                        child:  Container(
                            child: Center(
                                child : Row(
                                  children: const [
                                    Text("         "),
                                    Icon(
                                      Icons.account_circle_rounded,
                                      size: 22,
                                    ),
                                    Text("  User Profile",style: TextStyle(fontSize: 18.00)),
                                  ],
                                )
                            )
                        ),

                      )
                  ),
                ),
                //User Contest List
                Container(
                  margin: EdgeInsets.all(10),
                  child: InkWell(
                      borderRadius: BorderRadius.only(
                        // topLeft: Radius.circular(50.00),
                          bottomRight: Radius.circular(50.00)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            UserContestList()));
                      },
                      child: Ink(
                        height: MediaQuery.of(context).size.height/12,
                        width: MediaQuery.of(context).size.width-20,
                        decoration: BoxDecoration(
                            color:Colors.black12,
                            borderRadius: BorderRadius.only(
                              // topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(50.00),
                            )
                        ),
                        child:  Container(
                            child: Center(
                                child : Row(
                                  children: const [
                                    Text("         "),
                                    Icon(
                                      Icons.account_tree_outlined,
                                      size: 22,
                                    ),
                                    Text("  User's Contest List",style: TextStyle(fontSize: 18.00)),
                                  ],
                                )
                            )
                        ),

                      )
                  ),
                ),
                //User Statistics
                Container(
                  margin: EdgeInsets.all(10),
                  child: InkWell(
                      borderRadius: BorderRadius.only(
                        // topLeft: Radius.circular(50.00),
                          bottomRight: Radius.circular(50.00)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        const UserStatistics()));
                      },
                      child: Ink(
                        height: MediaQuery.of(context).size.height/12,
                        width: MediaQuery.of(context).size.width-20,
                        decoration: BoxDecoration(
                            color:Colors.black12,
                            borderRadius: BorderRadius.only(
                              //  topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(50.00),
                            )
                        ),
                        child:  Container(
                            child: Center(
                                child : Row(
                                  children: const [
                                    Text("         "),
                                    Icon(
                                      Icons.stacked_line_chart,
                                      size: 22,
                                    ),
                                    Text("  User's Statistics",style: TextStyle(fontSize: 18.00)),
                                  ],
                                )
                            )
                        ),

                      )
                  ),
                ),
                //User Submissions
                Container(
                  margin: EdgeInsets.all(10),
                  child: InkWell(
                      borderRadius: BorderRadius.only(
                        //  topLeft: Radius.circular(50.00),
                          bottomRight: Radius.circular(50.00)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        const UserSubmission()));
                      },
                      child: Ink(
                        height: MediaQuery.of(context).size.height/12,
                        width: MediaQuery.of(context).size.width-20,
                        decoration: BoxDecoration(
                            color:Colors.black12,
                            borderRadius: BorderRadius.only(
                              //  topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(50.00),
                            )
                        ),
                        child:  Container(
                            child: Center(
                                child : Row(
                                  children: const [
                                    Text("         "),
                                    Icon(
                                      Icons.app_registration,
                                      size: 22,
                                    ),
                                    Text("  User Submissions",style: TextStyle(fontSize: 18.00)),
                                  ],
                                )
                            )
                        ),

                      )
                  ),
                ),
                //ContestList
                Container(
                  margin: EdgeInsets.all(10),
                  child: InkWell(
                      splashColor: Colors.green,
                      borderRadius: BorderRadius.only(
                        //  topLeft: Radius.circular(50.00),
                          bottomRight: Radius.circular(50.00)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        const ContestList()));
                      },
                      child: Ink(
                        height: MediaQuery.of(context).size.height/12,
                        width: MediaQuery.of(context).size.width-20,
                        decoration: BoxDecoration(
                            color:Colors.black12,
                            borderRadius: BorderRadius.only(
                              // topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(50.00),
                            )
                        ),
                        child:  Container(
                            child: Center(
                                child : Row(
                                  children: const [
                                    Text("         "),
                                    Icon(
                                      Icons.list_alt,
                                      size: 22,
                                    ),
                                    Text("  Contest List ",style: TextStyle(fontSize: 18.00)),
                                  ],
                                )
                            )
                        ),

                      )
                  ),
                ),
                //Set Reminder
                Container(
                  margin: EdgeInsets.all(10),
                  child: InkWell(
                      borderRadius: BorderRadius.only(
                        //  topLeft: Radius.circular(50.00),
                          bottomRight: Radius.circular(50.00)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        const SetReminder()));
                      },
                      child: Ink(
                        height: MediaQuery.of(context).size.height/12,
                        width: MediaQuery.of(context).size.width-20,
                        decoration: BoxDecoration(
                            color:Colors.black12,
                            borderRadius: BorderRadius.only(
                              // topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(50.00),
                            )
                        ),
                        child:  Container(
                            child: Center(
                                child : Row(
                                  children: const [
                                    Text("         "),
                                    Icon(
                                      Icons.access_alarm,
                                      size: 22,
                                    ),
                                    Text("  Set Reminder",style: TextStyle(fontSize: 18.00)),
                                  ],
                                )
                            )
                        ),

                      )
                  ),
                ),
                //Top rated
                Container(
                  margin: EdgeInsets.all(10),
                  child:    InkWell(

                      borderRadius: BorderRadius.only(
                        //topLeft: Radius.circular(50.00),
                          bottomRight: Radius.circular(50.00)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        const TopRated()));
                      },
                      child: Ink(
                        height: MediaQuery.of(context).size.height/12,
                        width: MediaQuery.of(context).size.width-20,
                        decoration: BoxDecoration(
                            color:Colors.black12,
                            borderRadius: BorderRadius.only(
                              // topLeft: Radius.circular(50.00),
                              bottomRight: Radius.circular(50.00),
                            )
                        ),
                        child:  Container(
                            child: Center(
                                child : Row(
                                  children: const [
                                    Text("         "),
                                    Icon(
                                      Icons.arrow_upward_outlined,
                                      size: 22,
                                    ),
                                    Text("  Top 10 ",style: TextStyle(fontSize: 18.00)),
                                  ],
                                )
                            )
                        ),

                      )
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
