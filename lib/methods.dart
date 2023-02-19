import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Sam extends StatefulWidget {
  const Sam({super.key});

  @override
  State<Sam> createState() => _SamState();
}

class _SamState extends State<Sam> {
  @override
  List<Doctor> docc=[];
  Map<String, List<details>> event = {};
   void initState() {
    super.initState();
   Func();
  }
  void Func() async{
    List<Doctor> temp=await fetchDoctors();
    for(Doctor i in temp){
      List<details> tem=[];
      int size=i.days.length;
      for(int a=0;a<size;a++){
        tem.add(details(name: i.name, role: i.role));
      }
      for(var j in i.days){
        event[j]=tem;
      }
    }
    setState(() {
    docc=temp;
    });
  }
 
Widget build(BuildContext context) {
  if(event.length>0){

  print(event);
  }
return Scaffold(
      body:Text('dfkja')
    );
  }
}
class Doctor {
  String name;
  String role;
  String id;
  List<dynamic> days;
  Doctor( {required this.name, required this.role,required this.id, required this.days});
}
class details{
  String name;
  String role;
  details({required this.name, required this.role});
}

  Future<List<Doctor>> fetchDoctors() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot snapshot = await firestore.collection('doctors').get();
  
  List<Doctor> Doctors = [];
  snapshot.docs.forEach((doc) {
    String name = doc.get('Name');
    String role = doc.get('Role');
    String id = doc.get('id');
    List temp=doc.get('day').toList();
    Doctor doctor = Doctor(name:name, role:role,id:id,days:temp);
    Doctors.add(doctor);
  });
  
  return Doctors;
}
