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
    print(response.statusCode);
    if(response.statusCode == 200){
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['result'];
      });
    }else{
      print("Error");
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
                  backgroundColor: Colors.black38,
                  title: Text("Details",style: const TextStyle(fontSize: 20, color: Colors.white)),
                  content: Center(
                    child:  Column(
                      children: [
                        //User Photo
                        Container(
                          width: MediaQuery.of(context).size.width/3,height: MediaQuery.of(context).size.height/6,
                          margin: const EdgeInsets.only(top: 5, right: 5.00, left: 5.00,bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.00),
                              color: Colors.white),
                          child: Center(
                            child: listResponse![index]['titlePhoto'] == null ? const Text("Loading data") :
                            Container(
                              margin: const EdgeInsets.all(5.00),
                              width: 150.00,
                              height: 180.00,
                              child: const Text(""),//Image(image: NetworkImage(imageUrl.toString())),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: const BorderRadius.all(Radius.circular(15.00)),
                                  image: DecorationImage(image: NetworkImage(listResponse![index]['titlePhoto'].toString()),
                                    fit: BoxFit.fill,
                                  )
                              ),
                            ),
                          ),
                        ),
                        //Name
                        Center(
                          child: listResponse![index]['firstName'] == null
                              ? const Text("Loading data")
                              : Text("Name : " +
                              listResponse![index]['firstName'].toString(),style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          ),
                        ),
                        Center(
                          child: listResponse![index]['country'] == null
                              ? const Text("Loading data")
                              : Text("Country : " +
                              listResponse![index]['country'].toString(),style: const TextStyle(fontSize: 15, color: Colors.white,),
                          ),
                        ),
                        //Country Name
                        //City Name
                        Center(
                          child: listResponse![index]['city'] == null
                              ? const Text("Loading data")
                              : Text("City : " +
                              listResponse![index]['city'].toString(), style: const TextStyle(fontSize: 15,  color: Colors.white,
                          ),
                          ),
                        ),
                        //Total Friends
                        Center(
                            child: listResponse![index]['friendOfCount'] == null
                                ? const Text("Loading data")
                                : Text("Friends : "+
                                listResponse![index]['friendOfCount'].toString(),style: const TextStyle(fontSize: 15,color: Colors.white),
                            )
                        ),
                        //Contest Rating
                        Center(
                          child: listResponse![index]['rating'] == null
                              ? const Text("Loading data")
                              : Text("Contest Rating : " +
                              listResponse![index]['rating'].toString(),style: const TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                        //MaxRating
                        Center(
                          child: listResponse![index]['maxRating'] == null
                              ? const Text("Loading data")
                              : Text("Max Rating : " +
                              listResponse![index]['maxRating'].toString(),
                            style: const TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                        //Current Rank
                        Center(
                          child: listResponse![index]['rank'] == null
                              ? const Text("Loading data")
                              : Text("Current Rank : " + listResponse![index]['rank'].toString(),style: const TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                        //Max Rank
                        Center(
                          child: listResponse![index]['maxRank'] == null
                              ? const Text("Loading data")
                              : Text("Max Rank : " +listResponse![index]['maxRank'].toString(),style: const TextStyle(fontSize: 15, color: Colors.white,)),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                }, child: Text("Ok",style: const TextStyle(fontSize: 15, color: Colors.white,))),
                  ],
                ));
            },
            ),
            );
      })
    );
  }
}
