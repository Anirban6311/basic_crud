import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'employee.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Employee()));
      }),
      appBar: AppBar(
        title: Center(child: Text("Home")),
      ),


    );
  }
}
