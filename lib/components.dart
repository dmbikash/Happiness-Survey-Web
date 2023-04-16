import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/model.dart';
final _controller0 = ScrollController();
final _controller1 = ScrollController();
final _controller2 = ScrollController();

List<dynamic> _con= [_controller0 , _controller1 , _controller2 ];

double table_width = .7;

TextStyle tabStateStyle = (GoogleFonts.poppins(
  fontWeight: FontWeight.w600,
  fontSize: 14,
));

TextStyle tx = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w600
);
Container container( String name, bool align){
  Container box = Container(
    height: 25,
    padding: EdgeInsets.only(left: 5, bottom: 5),
      margin: EdgeInsets.only(left: 0, right: 5),
      color: Color(0xFFD9D9D9),

      child: Text("$name",
      textAlign: align ? TextAlign.center : TextAlign.start ,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),)
  );
  return box;
}


dynamic buildThepage(double h, double w, List tabName, int pageNo, List data){

var pages = List.generate(3, (index) {
  return Center(
    child: Column(
      children: [
        Container(
          // color: Colors.lime,
          width: w * table_width,
          height: h * .08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${tabName[pageNo]} Employee Survey List", style: tabStateStyle,),
              Container(

                margin: EdgeInsets.only(right: 5),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00539B),
                    padding: EdgeInsets.all(12),
                  ),
                  onPressed: () {
                    print('received data-----$data');
                    excell_generator(data,"title");
                  },
                  label: Text("Download"),
                  icon: Icon(Icons.download),
                ),
              )

            ],
          ),
        ),
        Container(
          // table header
          width: w * table_width,
          // color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: container("SL", true),
              ),
              // Expanded(flex:5,child: Text("ID: ${data[index]["employeeID"]}",style: tx,)),
              Expanded(flex: 2, child: container("ID", false)),
              Expanded(flex: 5, child: container("NAME", false),),
              Expanded(flex: 2, child: container("FLOOR", false),),

            ],
          ),
        ),
        Container(
          height: h * .49 - 20,
          width: w*.73,
          //color: Colors.pink,
          child: Scrollbar(
            thumbVisibility: true,
            //trackVisibility: true,
            //interactive: true,

            controller: _con[pageNo],

            child: ListView.builder(
              controller: _con[pageNo],
              // itemCount: data.length,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      //table boxes
                      margin: EdgeInsets.only(top: 5),
                      color: index % 2 == 0 ? Color(0xFFEAEEF4) : Color(
                          0xFFFFFFFF),
                      width: w * table_width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 1,
                              child: Text("${index + 1}.", style: tx,
                                textAlign: TextAlign.center,)),
                          // Expanded(flex:5,child: Text("ID: ${data[index]["employeeID"]}",style: tx,)),
                          Expanded(
                              flex: 2, child: Text(data[index]["employeeID"], style: tx,)),
                          Expanded(flex: 5,
                              child: Text(
                                data[index]["name"],
                                //"Mirza Bishsho Al Shakkhor Bin Noman Urf Turan ",
                                style: tx,)),
                          Expanded(flex: 2, child: Text("Level-1", style: tx,)),

                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    ),
  );

});
return pages[1];
}