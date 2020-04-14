import 'package:sqflite2/database/database_model.dart';

class Dog implements DatabaseModel{
   int dogID ;


   String dogName ;
   int dogAge ;


  Dog(this.dogID, this.dogName ,this.dogAge, );


   @override
   int getID() {
     return this.dogID ;
   }



   Dog.fromMap(Map<String,dynamic> map){
    this.dogID = map['id'];
    this.dogAge = map['age'];
    this.dogName = map['name'];

  }
   @override
   String database() {
     return 'dogs_db';
   }

  @override
  String table() {

    return 'dogs';
  }

  @override
  Map<String,dynamic > toMap() {
   return {
     'id':this.dogID,

     'age':this.dogAge,
     'name':this.dogName,

   };
  }


}