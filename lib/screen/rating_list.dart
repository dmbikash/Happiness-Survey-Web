
import 'package:flutter/material.dart';

import '../model/model.dart';
class RatingList extends StatefulWidget {
  //String title;

  RatingList({
  Key? key,
  //required this. title,
  }) : super(key: key,

  );

  @override
  State<RatingList> createState() => _RatingListState();
}

class _RatingListState extends State<RatingList> {

  late List a=[];
  var dataT = [
    ["Name", "Age"],
    ["John", "23"],
    ["Jane", "29"],
    ["Jim", "35"],
  ];

  dynamic route_data;
  String title = "No Internet";
  List data = [];

  @override
  Widget build(BuildContext context) {
    route_data = ModalRoute.of(context)!.settings.arguments;
    print("----------------------------------------");
    print(route_data);
    title=route_data["name"];
    data=route_data["data"];
    print(data);

    double w = MediaQuery.of(context).size.width ;
    double h = MediaQuery.of(context).size.height ;
    TextStyle tx = TextStyle(
        fontSize: w*.025,
        fontWeight: FontWeight.w500
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          excell_generator(data,title);
          //make_excel();
          //createExcel();
        },
        child: Icon(Icons.download_outlined,size: w*.03,color: Colors.black,),
        backgroundColor: Colors.teal,

      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title:Text("${title}"),
      ),
      body: Container(
        height: h*.9,
        //color: Colors.red,
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index){
            return Column(
              children: [

                Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Colors.teal.withOpacity(.2),
                  width: w*.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 1,child: Text("${index+1}.",style: tx,)),
                      Expanded(flex:5,child: Text("ID: ${data[index]["employeeID"]}",style: tx,)),

                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

}
