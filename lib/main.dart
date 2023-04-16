import 'package:flutter/material.dart';
import 'package:happiness_survey_admin_web_app/screen/dashboard.dart';
import 'package:happiness_survey_admin_web_app/screen/rating_list.dart';
import 'package:happiness_survey_admin_web_app/screen/test.dart';
import 'package:happiness_survey_admin_web_app/screen/details_list.dart';
import 'package:happiness_survey_admin_web_app/screen/test3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home:RatingList(title: 'asas',),
      //initialRoute: 'Test2',
      initialRoute: '/',
      routes: {
       "/" : (context) => Dashboard(),
       "RatingList" : (context) => RatingList(),
       "DetailsList" : (context) => DetailsList(),
       "Test3" : (context) => ImageUploadScreen(),
      },
    );
  }
}



