import 'package:flutter/material.dart';
import 'package:sqflite2/database/database_model.dart';


import 'database/my_databases.dart';

import 'models/dog.dart';

void main() async {
  print('hhhhh');
  WidgetsFlutterBinding.ensureInitialized();
  MyDatabase myDatabase = MyDatabase();
  await myDatabase.dogDatabase();
  await myDatabase.catDatabase();

  await myDatabase.insert(Dog(0, 'Dog1', 3));
  await myDatabase.insert(Dog(1, 'Dog2', 2));
  await myDatabase.insert(Dog(2, 'Dog3', 4));
  await myDatabase.insert(Dog(3, 'Dog4', 5));
  await myDatabase.insert(Dog(4, 'Dog5', 5));
  await myDatabase.insert(Dog(5, 'Dog6', 6));
  await myDatabase.insert(Dog(6, 'Dog7', 7));
  await myDatabase.insert(Dog(7, 'Dog7', 7));
  await myDatabase.insert(Dog(8, 'Dog7', 7));
  await myDatabase.insert(Dog(0, 'Dog700', 7));
  await myDatabase.insert(Dog(9, 'Dog1', 7));
  await myDatabase.insert(Dog(10, 'Dog1', 7));



//  await myDatabase.insert(Cat(0, 'Cat1'));
//  await myDatabase.insert(Cat(1, 'Cat2'));
//  await myDatabase.insert(Cat(2, 'Cat3'));
//  await myDatabase.insert(Cat(3, 'Cat4'));
//  await myDatabase.insert(Cat(4, 'Cat5'));
//  await myDatabase.insert(Cat(5, 'Cat6'));
//  await myDatabase.insert(Cat(6, 'Cat7'));
//  await myDatabase.insert(Cat(7, 'Cat8'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyDatabase myDatabase = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
          future: myDatabase.getAll('dogs', 'dogs_db'),
          builder: (BuildContext context,
              AsyncSnapshot<List<DatabaseModel>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text('error , no connection made'));
                break;
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error));
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('No data '));
                }

                print(snapshot.data.cast());
                return _drawDogs(context, snapshot.data.cast());
                break;
              default:
                return Center(child: Text('error , no connection made'));
                break;
            }
          },
        ),
      ),
    );
  }

  Widget _drawDogs(BuildContext context, List<Dog> dogs) {
    return ListView.builder(
      itemCount: dogs.length,
      itemBuilder: (BuildContext context, int position) {
        return ListTile(
          title: Text(dogs[position].dogName),
        );

      },
    );
  }
}
