import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 200,
        leading: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Image.asset("assets/images/logo.png",height: 100,),
        ),
        backgroundColor: Colors.white,
      ),

    );
  }
}
