import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class TopRated extends StatefulWidget {
  const TopRated({Key? key}) : super(key: key);
  @override
  State<TopRated> createState() =>_TopRatedState();
}

List? listResponse;
Map? mapResponse;
bool _isLoading = true;

class _TopRatedState extends State<TopRated> {
  final url = "https://codeforces.com/api/user.ratedList?activeOnly=true&includeRetired=false";

  Future ApiCall() async{
    http.Response response;
    response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['result'];
      });
    }
    setState((){_isLoading = false ;});
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
      appBar: AppBar(title: const Text("10 Top rated"),backgroundColor: Colors.black12),
      body: _isLoading?const Center(child: SpinKitRipple(color: Colors.white,size: 100))
          : ListView.builder(itemCount: listResponse == null ? 0 : 20,itemBuilder: (context,index) {
            return Padding(padding: EdgeInsets.only(top: 10.00,left: 10.00,right: 10.00),
            child: ListTile(
              tileColor: Colors.white12,
              title: listResponse![index]['firstName'] == null
                  ? const Text("Loading data")
                  : Text(listResponse![index]['firstName'].toString(),style: const TextStyle(fontSize: 17, color: Colors.white),),
              subtitle: listResponse![index]['rank'] == null
                  ? const Text("Loading data")
                  : Text(listResponse![index]['rank'].toString()+" : "+ listResponse![index]['rating'].toString(),style: const TextStyle(color: Colors.white)),
            onTap: (){
                showDialog(context: context, builder: (context) => AlertDialog(
                  backgroundColor: Colors.blueGrey,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text(listResponse![index]['handle'].toString(),style: TextStyle(fontSize: 20, color: Colors.white)),
                     const Divider(color: Colors.white,thickness: 2,)
                    ],
                  ),
                  content: Builder(
                    builder: (context) {
                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                     // var height = MediaQuery.of(context).size.height;
                      var width = MediaQuery.of(context).size.width;
                      return Container(
                        padding: EdgeInsets.zero, height: MediaQuery.of(context).size.height*0.45,
                        width: width - 0,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            //User Photo
                            Container(
                               // width: MediaQuery.of(context).size.width/3,height: MediaQuery.of(context).size.height/6,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: listResponse![index]['titlePhoto'] == null ? const Text("Loading data") :
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.blue,
                                  backgroundImage: NetworkImage(listResponse![index]['titlePhoto'].toString()) ,
                                )
                            ),
                            //name
                            Container(
                              child: listResponse![index]['firstName'] == null
                                  ? const Text("name not found...",style: TextStyle(fontSize: 12,color: Colors.black))
                                  : Text("Name : " +listResponse![index]['firstName'].toString(),style: const TextStyle(fontSize: 12,color: Colors.white),),
                            ),
                            //organization
                            Container(
                              child: listResponse![index]['country'] == null
                                  ? const Text("organization not found...",style: TextStyle(fontSize: 12,color: Colors.black))
                                  : Text("Organization : " +
                                  listResponse![index]['organization'].toString(),style: const TextStyle(fontSize: 12, color: Colors.white,),
                              ),
                            ),
                            //City Name
                            Container(
                              child: listResponse![index]['city'] == null
                                  ? const Text("city not found...",style: TextStyle(fontSize: 12,color: Colors.black))
                                  : Text("City : " +
                                  listResponse![index]['city'].toString(), style: const TextStyle(fontSize: 12,  color: Colors.white,
                              ),
                              ),
                            ),
                            //Total Friends
                            Container(
                                child: listResponse![index]['friendOfCount'] == null
                                    ? const Text("friends not found...",style: TextStyle(fontSize: 12,color: Colors.black))
                                    : Text("Friends : "+
                                    listResponse![index]['friendOfCount'].toString(),style: const TextStyle(fontSize: 12,color: Colors.white),
                                )
                            ),
                            //Contest Rating
                            Container(
                              child: listResponse![index]['rating'] == null
                                  ? const Text("contest rating not found...",style: TextStyle(fontSize: 12,color: Colors.black))
                                  : Text("Contest Rating : " +
                                  listResponse![index]['rating'].toString(),style: const TextStyle(fontSize: 12, color: Colors.white)),
                            ),
                            //MaxRating
                            Container(
                              child: listResponse![index]['maxRating'] == null
                                  ? const Text("max rating not found...",style: TextStyle(fontSize: 12,color: Colors.black))
                                  : Text("Max Rating : " +
                                  listResponse![index]['maxRating'].toString(),
                                style: const TextStyle(fontSize: 12, color: Colors.white),
                              ),
                            ),
                            //Current Rank
                            Container(
                              child: listResponse![index]['rank'] == null
                                  ? const Text("current rank not found...",style: TextStyle(fontSize: 12,color: Colors.black))
                                  : Text("Current Rank : " + listResponse![index]['rank'].toString(),style: const TextStyle(fontSize: 12, color: Colors.white)),
                            ),
                            //Max Rank
                            Container(
                              child: listResponse![index]['maxRank'] == null
                                  ? const Text("max rank not found...",style: TextStyle(fontSize: 12,color: Colors.black))
                                  : Text("Max Rank : " +listResponse![index]['maxRank'].toString(),style: const TextStyle(fontSize: 12, color: Colors.white,)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                }, child:const Text("Ok",style: TextStyle(fontSize: 15, color: Colors.white,))),
                  ],
                ));
            },
            ),
            );
      })
    );
  }
}
