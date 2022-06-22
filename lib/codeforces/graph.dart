import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';


class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {


  late List<charts.Series<Ratings, String>> _seriesData;
  _generateData() {
    var data1 = [
      Ratings('800', 30),
      Ratings('900', 40),
      Ratings('1000', 10),
      Ratings('1100', 30),
      Ratings('1200', 13),
      Ratings('1300', 34),
      Ratings('1400', 53),
      Ratings('1500', 5),
      Ratings('1600', 47),
      Ratings('1700', 405),
      Ratings('1800', 40),
      Ratings('1900', 45),
      Ratings('2000', 15),
      Ratings('2100', 435),
      Ratings('2200', 435),
      Ratings('2300', 435),
      Ratings('2400', 435),
      Ratings('2500', 435),
      Ratings('2600', 435),
      Ratings('2700', 435),
      Ratings('2800', 435),
      Ratings('2900', 435),
      Ratings('3000', 435),
      Ratings('3100', 435),
      Ratings('3200', 435),
      Ratings('3300', 435),
      Ratings('3400', 435),
      Ratings('3500', 435),
      Ratings('3600', 435),
      Ratings('3700', 435),
      Ratings('3800', 435),
      Ratings('3900', 435),
      Ratings('4000', 435),
    ];
    _seriesData.add(
      charts.Series(
        domainFn: (Ratings base, _) => base.base_rating,
        measureFn: (Ratings solveCount, _) => solveCount.solved,
        id: '01',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Ratings pollution, _) => charts.ColorUtil.fromDartColor(Colors.white),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = <charts.Series<Ratings, String>>[];
    _generateData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white12,
        appBar: AppBar(
          backgroundColor:Colors.black12,
          title: Text("Google Chart"),
        ),
        body: ListView(
          children: [
            Container(
                height: 20,
                alignment: Alignment.center,
                margin:const EdgeInsets.only(top: 10),
                child:const Text("Solve count graph",style: TextStyle(color: Colors.white,fontSize: 15))),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: MediaQuery.of(context).size.height/2,
                width: 1800.0,
                child:
                Flexible(
                  //fit: FlexFit.loose,
                  child: charts.BarChart(
                    _seriesData,
                    animate: true,
                    barGroupingType: charts.BarGroupingType.grouped,
                    // behaviors: [charts.SeriesLegend()],
                    animationDuration:const Duration(seconds: 5),
                    domainAxis :const charts.OrdinalAxisSpec(
                        renderSpec: charts.GridlineRendererSpec(
                          labelStyle: charts.TextStyleSpec(
                              fontSize: 15, color: charts.MaterialPalette.white
                          ), //change white color as per your requirement.
                        )),
                    primaryMeasureAxis:const  charts.NumericAxisSpec(
                        renderSpec: charts.GridlineRendererSpec(
                          labelStyle: charts.TextStyleSpec(
                              fontSize: 15, color: charts.MaterialPalette.white
                          ), //change white color as per your requirement.
                        )),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 20,
                    alignment: Alignment.center,
                    margin:const EdgeInsets.only(top: 10),
                    child:const Text("Problem Ratings ",style: TextStyle(color: Colors.white,fontSize: 15))),
                Container(
                    height: 20,
                    alignment: Alignment.bottomRight,
                    margin:const EdgeInsets.only(top: 10),
                    child:const Text(" >",style: TextStyle(color: Colors.white,fontSize: 15))),
              ],
            ),
            Divider(color: Colors.white,thickness: 2,)
          ],
        )

    );
  }
}















class Ratings {
  String base_rating;
  int solved;
  Ratings( this.base_rating, this.solved);
}

