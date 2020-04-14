import 'package:flutter/cupertino.dart';
import 'package:sqflite2/database/database_model.dart';

class Cat implements DatabaseModel{
  int id ;
  String name ;


  Cat(this.id, this.name);

  Cat.fromMap(Map<String,dynamic> map){
    this.id = map['id'];
    this.name = map['name'];
  }



  @override
  String table() {
    return 'cats';
  }

  @override
  Map<String,dynamic > toMap() {
    return {
      'id':this.id,
      'name':this.name,
    };

  }

  @override
  String database() {
   return 'cats_db';
  }

  @override
  int getID() {
    return this.id ;
  }

}