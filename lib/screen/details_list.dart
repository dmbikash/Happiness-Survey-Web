
import 'dart:convert';
import 'package:http/http.dart' as http ;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happiness_survey_admin_web_app/components.dart';

class DetailsList extends StatefulWidget {
  const DetailsList({super.key});

  @override
  State<DetailsList> createState() => _DetailsListState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _DetailsListState extends State<DetailsList>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    print("aaaaaaaaaa--------------------aaaaaaaaaaaaaa");
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  List endpoint = ["sad", "neutral", "happy"];
  String url = "http://192.168.10.57:8000/read/";


  dynamic route_data =[];
  dynamic route_data3 =[];
  dynamic route_data2_sad = {
    "data": [{
      'employeeID' : "loading.......",
    }]
  };
  late dynamic route_data2_neutral = {
    "data": [{
      'employeeID' : "loading.......",
    }]
  };
  late dynamic route_data2_happy = {
    "data": [{
      'employeeID' : "loading.......",
    }]
  };

  //late List happy ;

  List data = [];
  List<String> tabName = ["Sad", "Neutral", "Happy"];






  String logo_url = "http://192.168.10.57:8000/image/get_image";
  //String logo_url = "http://127.0.0.1:8000/image/get_image";






  @override
  Widget build(BuildContext context) {

      route_data = ModalRoute.of(context)!.settings.arguments;
      print("route_data- $route_data");

    if(route_data == null) {
      print("ami route data paini/ harayfelsi");

      fetchHappy(url+endpoint[2]).then((value) {
        //print(route_data2);
      });
      fetchNeutral(url+endpoint[1]).then((value) => null);
      fetchSad(url+endpoint[0]).then((value) => null);
    }

    if(route_data != null){
      setState(() {
        _tabController = TabController(length: 3, vsync: this, initialIndex: route_data["index"]);
      });
    }

    double w = MediaQuery.of(context).size.width ;
    double h = MediaQuery.of(context).size.height ;

    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 50,
        leadingWidth: 200,
        leading: Padding(
          padding: EdgeInsets.only( top: 12, bottom: 12),
          child: Image.network(logo_url),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Color(0xFFEAEEF4),
        child: Center(
          child: Container(
            color: Color(0xFFFFFFFF),
           // color: Colors.redAccent,
            height: h*.8-5,
            width: w*.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //color: Colors.green,
                  padding: EdgeInsets.only(top: 15, left: 40),
                  height: h*.08,
                  child: Text("Happiness Survey Stats",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 25
                    ),
                  ),
                ),
                Container(
                  // tab menu
                  //color: Colors.blue,
                  height: h*.06,
                  width: 400,
                  child: TabBar(
                    labelColor: Color(0xFF252849),
                    automaticIndicatorColorAdjustment: true,
                    indicatorColor: Color(0xFF252849),
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: _tabController,
                    tabs:  <Widget>[
                      Tab(
                        child: Text("Happy",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),),
                      ),
                      Tab(
                        child: Text("Neutral",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),),
                      ),

                      Tab(
                        child: Text("   Sad   ",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),),
                      ),

                    ],
                  ),
                ),
                Container(
                  // tab screen details
                  //color: Colors.yellow.withOpacity(.9),
                  height:  h*.63-10,
                 // width: 400,
                  child: TabBarView(
                    controller: _tabController,
                    children:  <Widget>[
                      buildThepage(h, w, tabName, 0, route_data!= null? route_data["happy"]:route_data2_sad["data"] ),
                      buildThepage(h, w, tabName, 1, route_data!= null? route_data["neutral"]:route_data2_neutral["data"] ),
                      buildThepage(h, w, tabName, 2, route_data!= null? route_data["sad"]:route_data2_happy["data"] ),

                      // Center(
                      //   child: Text("It's rainy here"),
                      // ),
                      // Center(
                      //   child: Text("It's sunny here"),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> fetchHappy(String url) async {
    //String url = 'http://10.0.2.2:8000/read/happy';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var api_data = jsonDecode(response.body);
      // setState(() {
      //   route_data = {
      //     "data": [api_data]
      //   };
      //   //count = api_data.length + count;
      // });
        route_data2_happy = {
          "data": api_data
        };
      print("fpound----------------happy-----------------people");
      print(route_data);
    } else {
      setState(() {
        route_data= {
          "data" :[
        {"employeeID": "--something qwrong"}
        ],
      };
      });
      print('No Ratings Found for happy');
    }
  }
  Future<void> fetchNeutral(String url) async {
    //String url = 'http://10.0.2.2:8000/read/happy';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var api_data = jsonDecode(response.body);
      // setState(() {
      //   route_data = {
      //     "data": [api_data]
      //   };
      //   //count = api_data.length + count;
      // });
      route_data2_neutral = {
        "data": api_data
      };
      print("found -------------neutral--------------------people");
      print(route_data);
    } else {
      setState(() {
        route_data= {
          "data" :[
            {"employeeID": "--something wrong--"}
          ],
        };
      });
      print('No Ratings Found for happy');
    }
  }
  Future<void> fetchSad(String url) async {
    //String url = 'http://10.0.2.2:8000/read/happy';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var api_data = jsonDecode(response.body);
      // setState(() {
      //   route_data = {
      //     "data": [api_data]
      //   };
      //   //count = api_data.length + count;
      // });
      route_data2_sad = {
        "data": api_data
      };
      print("fpund-------------------sad--------------people");
      print(route_data);
    } else {
      setState(() {
        route_data= {
          "data" :[
            {"employeeID": "--something qwrong"}
          ],
        };
      });
      print('No Ratings Found for happy');
    }
  }
}
