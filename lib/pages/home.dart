

import 'package:basic_crud_flutter/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'employee.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameController= TextEditingController();
  TextEditingController _ageController=TextEditingController();
  TextEditingController _locationController=TextEditingController();

  Stream? EmployeeStream;

  getontheload() async{
    EmployeeStream =await DatabaseMethods().getEmployeeDetails();
    setState(() {

    });
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }
  Widget allEmployeeDetails(){
    return StreamBuilder(stream: EmployeeStream, builder: (context,AsyncSnapshot snapshot) {
       return snapshot.hasData? ListView.builder(itemCount: snapshot.data.docs.length, itemBuilder: (context,index){
         DocumentSnapshot ds=snapshot.data.docs[index];
         return Material(
           child: Container(
             margin: EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 30),
             child: Column(
               children: [
                 Material(child: Container(
                     padding: EdgeInsets.symmetric(horizontal: 20),
                     width: double.infinity,
                     color: Colors.amberAccent,
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text("Name : "+ds["Name"],style: TextStyle(color: Colors.blueAccent,fontSize: 20),),
                             Spacer(),
                             GestureDetector(
                                 onTap: (){
                                   //showing the details in the boxe(textfields) for editng using ID
                                   _nameController.text=ds["Name"];
                                   _ageController.text=ds["Age"];
                                   _locationController.text=ds["Location"];
                                   editEmployeeDetails(ds["Id"]);  ///accessing the function through Id
                                 },
                                 child: Icon(Icons.edit,color: Colors.redAccent,)),
                                 GestureDetector(
                                     onTap: ()async{
                                       await DatabaseMethods().deleteEmployeeDetails(ds["Id"]);
                                     },
                                     child: Icon(Icons.delete,color: Colors.red,)),
                           ],
                         ),

                         Text("Age : "+ds["Age"],style: TextStyle(color: Colors.blueAccent,fontSize: 20),),
                         Text("Location : "+ds["Location"],style: TextStyle(color: Colors.blueAccent,fontSize: 20),),
                       ],
                     ))),
               ],
             ),
           ),
         );


       }):Container();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Employee()));
      }),
      appBar: AppBar(
        title: Center(child: Text("Home")),

      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 30),
        child: Column(
          children: [
            Expanded(child: allEmployeeDetails())
          ],
        ),
      )

    );
  }
  Future editEmployeeDetails(String id)=> showDialog(context: context, builder: (context)=>AlertDialog(
    content:SingleChildScrollView(
  child: Column(
  mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);  // dialog box will get removed
            },
            child: Icon(Icons.cancel),
          ),
          SizedBox(width: 10), // Adjust spacing between icon and text
          Text(
            "Edit details",
            style: TextStyle(fontSize: 30, color: Colors.amberAccent),
          ),
        ],
      ),
      SizedBox(height: 30),
      Text("Name"),
      SizedBox(height: 20),
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
      SizedBox(height: 20),
      Text("Age"),
      SizedBox(height: 20),
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
      SizedBox(height: 20),
      Text("Location"),
      SizedBox(height: 20),
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
      SizedBox(height: 10),
      ElevatedButton(onPressed: () async{
            Map<String,dynamic> updateInfo={
              "Name": _nameController.text,
              "Age" : _ageController.text,
              "Id": id,
              "Location" : _locationController.text,

            };
            //after clicking update the dialog box will be popped
            await DatabaseMethods().updateEmployeeDetails(id, updateInfo).then((value){
              Navigator.pop(context);
            });
      }, child: Text("Update"))

      // child: Row(
        //   children: [

            // SizedBox(height: 30,),
            // Text("Name"),
            // SizedBox(height: 20,),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   decoration: BoxDecoration(
            //     border: Border.all(),
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //
            //   child: TextField(
            //     controller: _nameController,
            //     decoration: InputDecoration(border: InputBorder.none),
            //   ),
            // ),
            // SizedBox(height: 20,),
            // Text("Age"),
            // SizedBox(height: 20,),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   decoration: BoxDecoration(
            //     border: Border.all(),
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //
            //   child: TextField(
            //     controller: _ageController,
            //     decoration: InputDecoration(border: InputBorder.none),
            //   ),
            // ),
            // SizedBox(height: 20,),
            // Text("Location"),
            // SizedBox(height: 20,),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   decoration: BoxDecoration(
            //     border: Border.all(),
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //
            //   child: TextField(
            //     controller: _locationController,
            //     decoration: InputDecoration(border: InputBorder.none),
            //   ),
            // ),
            // SizedBox(height: 5,),

          ],
        ),
      ),
    ),
  );
}
