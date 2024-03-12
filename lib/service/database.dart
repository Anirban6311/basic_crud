
import 'package:cloud_firestore/cloud_firestore.dart';
// for deleting ,updating our databases
class DatabaseMethods{
  Future addEmployeeDetails(Map<String,dynamic> employeeInfoMap,String id) async{
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(employeeInfoMap);
  }
}