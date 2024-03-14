


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// for deleting ,updating our databases
class DatabaseMethods{
  Future addEmployeeDetails(Map<String,dynamic> employeeInfoMap,String id) async{
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(employeeInfoMap);
  }
   ///to fetch data from the collection in the form of snapshots
  Future<Stream<QuerySnapshot>> getEmployeeDetails() async{
    return await FirebaseFirestore.instance.collection("Employee").snapshots(

    );
  }

  //function to update the details
  Future updateEmployeeDetails(String id,Map<String,dynamic> updateInfo) async{
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
         .update(updateInfo)
    ;
  }
  // deletion
  Future deleteEmployeeDetails(String id) async{
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .delete()

    ;
  }

}