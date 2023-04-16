import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List happy = [{"employeeID" : "BIkash"}];
  late List vhappy = [];
  late List sad ;
  late List vsad = [];
  late List neutral ;
  late int count = 0;
  late Future<List> futureData;

  String logo_url = "http://192.168.10.57:8000/image/get_image";
  //String logo_url = "http://127.0.0.1:8000/image/get_image";


  void run_me() {
    // List endpoint =["vsad","sad","neutral","happy","vhappy"];
    List endpoint = ["sad", "neutral", "happy"];

    //String url = "http://127.0.0.1:8000/read/";
    String url = "http://192.168.10.57:8000/read/";



    //fetchVhappy(url+endpoint[4]);
    fetchHappy(url + endpoint[2]);
    fetchNeutral(url + endpoint[1]);
    fetchSad(url + endpoint[0]);
    //fetchVsad(url+endpoint[0]);
    print("count");
  }

  @override
  void initState() {
    super.initState();
    run_me();
  }

  @override
  Widget build(BuildContext context) {
    print(count);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    TextStyle tx = TextStyle(
        fontSize: w * .022, color: Colors.black, fontWeight: FontWeight.w500);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          leadingWidth: 200,
          leading: Padding(
            padding: EdgeInsets.only( top: 12, bottom: 12),
            child: Image.network(logo_url),
          ),
          backgroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.refresh,
            size: w * .03,
            color: Color(0xFF252849),
          ),
          backgroundColor: Color(0xFFF6F6F6),
          onPressed: () {
            setState(() {
              //uildCircularProgressIndicator();
              count = 0;
              run_me();
            });
          },
        ),
        body: count! <= 0
            ? Center(child: buildCircularProgressIndicator())
            : Container(
                //color: Colors.red,
                //color: Color(0xFFEAEEF4),

                padding: EdgeInsets.all(5),
                child: Center(
                  child: Container(
                    height: h * .8,
                    width: w * .8,
                    color: Colors.white,
                    //color: Colors.blueGrey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                         // color: Colors.redAccent,
                          height: 50,
                          width: 500,
                          child: Text(
                            "Dashboard",
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF252849),
                            ),
                          ),
                        ),
                        Container(
                          width: w*.8,
                          height: h*.5,
                          //color: Colors.green,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                // hoverColor: Colors.red,
                                  onTap: (){
                                    print("happy");
                                    Navigator.pushNamed(context, "DetailsList",
                                    arguments: {
                                      "index" : 0,
                                      'happy' : happy,
                                      'neutral' : neutral,
                                      'sad' : sad,
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: w*.005),
                                    //color: Colors.lime,
                                    color: Color(0xFFF6F6F6),
                                    height: h*.34,
                                    child: Row(
                                      children: [
                                        Container(
                                          //color: Colors.purple,
                                          width: w*.14,
                                          margin: EdgeInsets.all(w*.005),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Happy",
                                                style: GoogleFonts.poppins(
                                                  fontSize: w*.025,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              Text(
                                                "${((happy.length/count)*100).toStringAsFixed(2)} %",
                                                style: GoogleFonts.poppins(
                                                  fontSize:w*.025,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF13CC61)
                                                ),
                                              ),
                                              Text("Employees are Happy",
                                                style: GoogleFonts.poppins(
                                                  fontSize: w*.01,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFA5A9AC),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              //color: Colors.purple[200],
                                              margin: EdgeInsets.all(10),
                                              width: w*.074,
                                              padding: EdgeInsets.zero,
                                              child: Image(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                  "assets/images/happyVector.png",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: (){
                                    print("neutral");
                                    Navigator.pushNamed(context, "DetailsList",
                                        arguments: {
                                          "index" : 1,
                                          'happy' : happy,
                                          'neutral' : neutral,
                                          'sad' : sad,
                                        });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: w*.005),
                                    //color: Colors.orange,
                                    color: Color(0xFFF6F6F6),
                                    height: h*.34,
                                    child: Row(
                                      children: [
                                        Container(
                                          //color: Colors.cyan,
                                          width: w*.14,
                                          margin: EdgeInsets.all(w*.005),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Neutral",
                                                style: GoogleFonts.poppins(
                                                  fontSize: w*.025,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              Text(
                                                "${((neutral.length/count)*100).toStringAsFixed(2)} %",
                                                style: GoogleFonts.poppins(
                                                    fontSize: w*.025,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFD6AC05),
                                                ),
                                              ),
                                              Text("Employees are Neutral",
                                                style: GoogleFonts.poppins(
                                                  fontSize:  w*.01,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFA5A9AC),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              //color: Colors.cyan[200],
                                              margin: const EdgeInsets.all(10),
                                              //height: 120,
                                              width: w*.08,
                                              padding: EdgeInsets.zero,
                                              child: const Image(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                  "assets/images/neutralVector.png",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: (){
                                    print("sad");
                                    Navigator.pushNamed(context, "DetailsList",
                                        arguments: {
                                          "index" : 2,
                                          'happy' : happy,
                                          'neutral' : neutral,
                                          'sad' : sad,
                                        });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: w*.005),
                                    //color: Colors.teal,
                                    color: Color(0xFFF6F6F6),
                                    height: h*.34,
                                    child: Row(
                                      children: [
                                        Container(
                                          //color: Colors.purpleAccent,
                                          width: w*.14,
                                          margin: EdgeInsets.all(w*.005),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Sad",
                                                style: GoogleFonts.poppins(
                                                  fontSize: w*.025,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              Text(
                                                "${((sad.length/count)*100).toStringAsFixed(2)} %",
                                                style: GoogleFonts.poppins(
                                                    fontSize: w*.025,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFE74C3C)
                                                ),
                                              ),
                                              Text("Employees are Sad",
                                                style: GoogleFonts.poppins(
                                                  fontSize:  w*.01,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFA5A9AC),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                            //  color: Colors.purpleAccent[200],
                                              margin: EdgeInsets.all(10),
                                              //height:w*.078,
                                              width: w*.08,
                                              padding: EdgeInsets.zero,
                                              child: Image(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                  "assets/images/sadVector.png",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // InkWell(
                        //   onTap: (){
                        //     print("vsad");
                        //     Navigator.pushNamed(context, "RatingList",
                        //         arguments: {
                        //       "name": "Very Sad",
                        //       "data": vsad,
                        //         }
                        //     );
                        //     },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text("Very Sad",style: tx,),
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: LinearPercentIndicator(
                        //           progressColor: Colors.red,
                        //           percent: (vsad.length/count) > 1? .5 : (vsad.length/count),
                        //           width: w*.52,
                        //           lineHeight: 20,
                        //           barRadius: Radius.circular(50),
                        //           animationDuration: 1000,
                        //           animation: true,
                        //           trailing: SizedBox(width:w*.13,child: Text("${((vsad.length/count)*100).toStringAsFixed(2)} %",style: tx,)),
                        //         ),
                        //       ),
                        //       //
                        //       //Text("Neutral"),
                        //       //Text("Happy"),
                        //       //Text("Ver
                        //     ],
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: (){
                        //     //print("sad");
                        //     Navigator.pushNamed(context, "RatingList",
                        //         arguments: {
                        //           "name": "Sad",
                        //           "data": sad,
                        //         }
                        //     );
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text("Sad",style: tx,),
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: LinearPercentIndicator(
                        //
                        //           progressColor: Colors.orange,
                        //           percent: (sad.length/count) > 1? .5 : (sad.length/count),
                        //           width: w*.52,
                        //           lineHeight: 20,
                        //           barRadius: Radius.circular(50),
                        //           animationDuration: 1000,
                        //           animation: true,
                        //           trailing: SizedBox(width:w*.13,child: Text("${((sad.length/count)*100).toStringAsFixed(2)} %",style: tx,)),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: (){
                        //     print("neutral");
                        //     Navigator.pushNamed(context, "RatingList",
                        //         arguments: {
                        //           "name": "Neutral",
                        //           "data": neutral,
                        //         }
                        //     );
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text("Neutral",style: tx,),
                        //       Padding(
                        //
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: LinearPercentIndicator(
                        //
                        //           progressColor: Colors.yellow ,
                        //           percent: (neutral.length/count) > 1? .5 : (neutral.length/count),
                        //           width: w*.52,
                        //           lineHeight: 20,
                        //           barRadius: Radius.circular(50),
                        //           animationDuration: 1000,
                        //           animation: true,
                        //           trailing: SizedBox(width:w*.13, child: Text("${((neutral.length/count)*100).toStringAsFixed(2)} %",style: tx,)),
                        //         ),
                        //       ),
                        //
                        //     ],
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: (){
                        //     print("happy");
                        //     Navigator.pushNamed(context, "RatingList",
                        //         arguments: {
                        //           "name": "Happy",
                        //           "data": happy,
                        //         }
                        //     );
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //
                        //       Text("Happy",style: tx,),
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: LinearPercentIndicator(
                        //
                        //           progressColor: Colors.lightGreen,
                        //           percent: (happy.length/count) > 1? .5 : (happy.length/count),
                        //           width: w*.52,
                        //           lineHeight: 20,
                        //           barRadius: Radius.circular(50),
                        //           animationDuration: 1000,
                        //           animation: true,
                        //           trailing: SizedBox(width:w*.13,child: Text("${((happy.length/count)*100).toStringAsFixed(2)} %",style: tx,)),
                        //         ),
                        //       ),
                        //
                        //     ],
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: (){
                        //     print("vhappy");
                        //     Navigator.pushNamed(context, "RatingList",
                        //         arguments: {
                        //           "name": "Very happy",
                        //           "data": vhappy,
                        //         }
                        //     );
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text("Very Happy",style: tx,),
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: LinearPercentIndicator(
                        //
                        //           progressColor: Colors.green,
                        //           percent: (vhappy.length/count) > 1? .5 : (vhappy.length/count),
                        //           width: w*.52,
                        //           lineHeight: 20,
                        //           barRadius: Radius.circular(50),
                        //           animationDuration: 1000,
                        //           animation: true,
                        //           trailing: SizedBox(width:w*.13,child: Text("${((vhappy.length/count)*100).toStringAsFixed(2)} %",style: tx,)),
                        //         ),
                        //       ),
                        //
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ));
  }

  CircularProgressIndicator buildCircularProgressIndicator() =>
      CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: Colors.teal[800],
      );

  Future<void> fetchVhappy(String url) async {
    //String url = 'http://127.0.0.1:8000/read/vhappy';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var api_data = jsonDecode(response.body);
      setState(() {
        vhappy = api_data;
        count = api_data.length + count;
      });
      print("vhappy");
      print(vhappy);
    } else {
      setState(() {
        vhappy = [];
      });
      print('No Ratings Found for vhappy');
    }
  }

  Future<void> fetchHappy(String url) async {
    //String url = 'http://10.0.2.2:8000/read/happy';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var api_data = jsonDecode(response.body);
      setState(() {
        happy = api_data;
        count = api_data.length + count;
      });
      print("happy-------------------------");
      print(happy);
    } else {
      setState(() {
        happy = [];
      });
      print('No Ratings Found for happy');
    }
  }

  Future<void> fetchNeutral(String url) async {
    //String url = 'http://10.0.2.2:8000/read/neutral';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var api_data = jsonDecode(response.body);
      setState(() {
        neutral = api_data;
        count = api_data.length + count;
      });
      print("Neutral");

      print(neutral);
    } else {
      setState(() {
        neutral = [];
      });
      print('No Ratings Found for neutral');
    }
  }

  Future<void> fetchSad(String url) async {
    //String url = 'http://10.0.2.2:8000/read/sad';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var api_data = jsonDecode(response.body);
      setState(() {
        sad = api_data;
        count = api_data.length + count;
      });
      print("sad");
      print(sad);
    } else {
      setState(() {
        sad = [];
      });
      print('No Ratings Found for sad');
    }
  }

  Future<void> fetchVsad(String url) async {
    // String url = 'http://10.0.2.2:8000/read/vsad';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var api_data = jsonDecode(response.body);
      setState(() {
        vsad = api_data;
        count = api_data.length + count;
      });
      print("vsad");

      print(vsad);
    } else {
      setState(() {
        vsad = [];
      });
      print('No Ratings Found for vsad');
    }
  }
}
