import 'package:flutter/material.dart';

class GetData {
  String? employeeID;
  String? ratedAt;
  int? index;

  GetData({this.employeeID, this.ratedAt, this.index});

  GetData.fromJson(Map<String, dynamic> json) {
    employeeID = json['employeeID'];
    ratedAt = json['rated_at'];
    index = json['index'];
  }
}