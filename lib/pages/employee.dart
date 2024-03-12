import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

import '../service/database.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  TextEditingController _nameController= TextEditingController();
  TextEditingController _ageController=TextEditingController();
  TextEditingController _locationController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Employee"),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text("Name"),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),

              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20,),
            Text("Age"),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),

              child: TextField(
                controller: _ageController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20,),
            Text("Location"),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),

              child: TextField(
                controller: _locationController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 5,),
            ElevatedButton(onPressed: () async{
                String id=randomAlphaNumeric(10);
                  Map<String,dynamic> employeeInfoMap= {
                       "Name" : _nameController.text,
                       "Age"  : _ageController.text,
                    "Id": id,
                       "Location" : _locationController.text,
                  };
                  await DatabaseMethods().addEmployeeDetails(employeeInfoMap,id).then((value) => Fluttertoast.showToast(
                      msg: "Employee Details Added",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  ));
            }, child: Text("Submit"))

          ],
        ),
      ),
    );
  }
}
