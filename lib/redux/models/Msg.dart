import 'package:flutter/material.dart';

class Msg {
  String msg;
  String name;
  DateTime time;
  
  Msg({
    @required this.msg,
    @required this.name,
    @required this.time,
  });

  Msg.fromJson(Map<String, dynamic> json){
    msg = json['msg'];
    name = json['name'];
    time = DateTime.now();
  }

  Map<String, dynamic> toJson(){
  return {
    "msg": this.msg,
    "name": this.name,
    "time": this.time,
  };
}

  
}

