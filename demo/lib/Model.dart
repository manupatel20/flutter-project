import 'package:flutter/material.dart';

class ReceipeModel {
  late String label;
  late String image;
  late double calories;
  late String url;

  ReceipeModel({ this.label="default",  this.image="default",  this.calories=0.000,  this.url="default"});

  factory ReceipeModel.fromMap(Map<String, dynamic> map) {
    return ReceipeModel(
      label: map['label'],
      image: map['image'],
      calories: map['calories'],
      url: map['url'],
    );
  }
}
