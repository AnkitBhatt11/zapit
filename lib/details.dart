import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'apis/images.dart';

class DetailsScreen extends StatefulWidget {
  // const DetailsScreen({ Key? key }) : super(key: key);
  int index;

  DetailsScreen({required this.index
    
      });

  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
    bool net = false;
  nety() async {
    net = await InternetConnectionChecker().hasConnection;
    setState(() {
      print('nett$net');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nety();
  }
  var res;
  Future userid() async {
    //  profil = await getdetails(tokenProfile?.token);
    res = await getdummy();
    print('${res}');
    // print('userId${profil['_id']}');
    return res;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const double kDesignWidth = 375;
    const double kDesignHeight = 812;
    double _widthScale = MediaQuery.of(context).size.width / kDesignWidth;
    double _heightScale = MediaQuery.of(context).size.height / kDesignHeight;

    //  print(double.parse(widget.num).toInt().toString().length - 1);

    return net == false
        ? Scaffold(
            body: Center(
            child: Text('Check Internet Connection'),
          ))
        :FutureBuilder(
        future: userid(),
        builder: (context, snap) {
          return !snap.hasData
              ? Scaffold(
                  body: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.purple[200]),
                      SizedBox(
                        height: 10 * _heightScale,
                      ),
                      Text(
                        'Fetching data .... ',
                        style: TextStyle(color: Colors.purple),
                      )
                    ],
                  )),
                )
              : Scaffold(
                  appBar: AppBar(
                    // centerTitle: true,
                    backgroundColor: Colors.purple[300],
                    // Here we take the value from the MyHomePage object that was created by
                    // the App.build method, and use it to set our appbar title.
                    title: Text(
                      res[widget.index]['name'],
                      style: TextStyle(
                          fontSize: 22 * _widthScale,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  body: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 15)),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.all(10)),
                          res[widget.index]['logo_url']
                                  .toString()
                                  .contains('svg')
                              ? SvgPicture.network(
                                  res[widget.index]['logo_url'],
                                  height: 150 * _heightScale,
                                  width: 150 * _widthScale,
                                )
                              : Image.network(
                                  res[widget.index]['logo_url'],
                                  width: 150 * _widthScale,
                                  height: 150 * _heightScale,
                                ),
                          SizedBox(
                            width: 10 * _widthScale,
                          ),
                          Column(
                            //  mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                res[widget.index]['id'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10 * _heightScale,
                              ),
                              Text(
                                'Current price :',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('${res[widget.index]['price']} USD'),
                              SizedBox(
                                height: 10 * _heightScale,
                              ),
                              Text(
                                'All time high price :',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${res[widget.index]['high']} USD',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20 * _heightScale,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.0 * _widthScale, right: 10.0 * _widthScale),
                        child: Container(
                          height: 200 * _heightScale,
                          width: 330 * _widthScale,
                          child: LineChart(LineChartData(
                              backgroundColor: Colors.purple[100],
                              minX: 0,
                              minY: 0,
                              maxX: 8,
                              maxY: 10,
                              titlesData: FlTitlesData(
                                  show: true,
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget:
                                              (doublevalue, value) {
                                            switch (doublevalue.toInt()) {
                                              case 0:
                                                return Text('');
                                              case 2:
                                                return Text(
                                                  '2X',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                );
                                              case 4:
                                                return Text(
                                                  '4X',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                );
                                              case 6:
                                                return Text(
                                                  '6X',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                );
                                              case 8:
                                                return Text(
                                                  '8X',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                );
                                            }
                                            return Text('');
                                          })),
                                  bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget:
                                              (doublevalue, value) {
                                            switch (doublevalue.toInt()) {
                                              case 0:
                                                return Text(
                                                  'YTD',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                );
                                              case 2:
                                                return Text(
                                                  '365 Days',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                );
                                              case 4:
                                                return Text(
                                                  '30 Days',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                );
                                              case 6:
                                                return Text(
                                                  '7 Days',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                );
                                              case 8:
                                                return Text(
                                                  'TODAY',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                );
                                            }
                                            return Text('');
                                          }))),
                              lineBarsData: [
                                LineChartBarData(
                                    color: Colors.purple,
                                    preventCurveOverShooting: true,
                                    spots: [
                                      FlSpot(
                                          0,
                                          (double.parse(res[widget.index]
                                                      ['price']) -
                                                  double.parse(res[widget.index]
                                                          ['ytd']
                                                      ['price_change'])) /
                                              pow(
                                                  10,
                                                  (double.parse(
                                                              res[widget.index]
                                                                  ['price'])
                                                          .toInt()
                                                          .toString()
                                                          .length -
                                                      1))),
                                      FlSpot(
                                          2,
                                          (double.parse(res[widget.index]
                                                      ['price']) -
                                                  double.parse(res[widget.index]
                                                          ['365d']
                                                      ['price_change'])) /
                                              pow(
                                                  10,
                                                  (double.parse(
                                                              res[widget.index]
                                                                  ['price'])
                                                          .toInt()
                                                          .toString()
                                                          .length -
                                                      1))),
                                      FlSpot(
                                          4,
                                          (double.parse(res[widget.index]
                                                      ['price']) -
                                                  double.parse(res[widget.index]
                                                          ['30d']
                                                      ['price_change'])) /
                                              pow(
                                                  10,
                                                  (double.parse(
                                                              res[widget.index]
                                                                  ['price'])
                                                          .toInt()
                                                          .toString()
                                                          .length -
                                                      1))),
                                      FlSpot(
                                          6,
                                          (double.parse(res[widget.index]
                                                      ['price']) -
                                                  double.parse(res[widget.index]
                                                      ['7d']['price_change'])) /
                                              pow(
                                                  10,
                                                  (double.parse(
                                                              res[widget.index]
                                                                  ['price'])
                                                          .toInt()
                                                          .toString()
                                                          .length -
                                                      1))),
                                      FlSpot(
                                          8,
                                          (double.parse(
                                                  res[widget.index]['price']) /
                                              pow(
                                                  10,
                                                  (double.parse(
                                                              res[widget.index]
                                                                  ['price'])
                                                          .toInt()
                                                          .toString()
                                                          .length -
                                                      1)))),
                                    ],
                                    isCurved: true,
                                    barWidth: 3,
                                    belowBarData: BarAreaData(
                                        show: true, color: Colors.purple[300]))
                              ])),
                        ),
                      ),
                      Text(
                        'X represents ${pow(10, (double.parse(res[widget.index]['price']).toInt().toString().length - 1))} USD',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 40 * _heightScale),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0 * _widthScale),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Other Info. ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20 * _widthScale),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10 * _heightScale,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0 * _widthScale),
                        child: Row(
                          children: [
                            Text(
                              'Rank :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              res[widget.index]['rank'],
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      // Text('${res[widget.index]['price']} USD'),
                      SizedBox(
                        height: 10 * _heightScale,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0 * _widthScale),
                        child: Row(
                          children: [
                            Text(
                              'Market Cap :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              res[widget.index]['market_cap'],
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10 * _heightScale,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 20.0 * _widthScale),
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         'Max Supply :',
                      //         style: TextStyle(fontWeight: FontWeight.bold),
                      //       ),
                      //       Text(
                      //         res[widget.index]['max_supply'] == Null ? 'NA' : res[widget.index]['max_supply'] ,
                      //         style: TextStyle(fontWeight: FontWeight.w400),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Text(
                      //   '${res[widget.index]['high']} USD',
                      // )
                    ],
                  ),
                );
        });
  }
}
