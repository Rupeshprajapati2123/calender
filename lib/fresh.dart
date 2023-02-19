import 'dart:async';
import 'dart:collection';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import './utils.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  
  List<Doctor> docc=[];
  Map<String, List<details>> event = {};
  Map<String, List<details>> myEvent = {};
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
    final titleController = TextEditingController();
  final descpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    _selectedDate = _focusedDay;
    Func();
  }

  

  List _listOfDayEvents(DateTime dateTime) {
    
    if (event[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return event[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }
  void Func() async{
    List<Doctor> temp=await fetchDoctors();
    for(Doctor i in temp){
      int size=i.days.length;
      for(var j in i.days){
        if(event.containsKey(j)){
          List<details> ?aa;
          aa=event[j];
          event.remove(j);
          aa!.add(details(name: i.name, role: i.role));
          event[j]=aa;
        }else{
          List<details> tem=[];
        tem.add(details(name: i.name, role: i.role));
        event[j]=tem;
        }
      }
    }
    setState(() {
    docc=temp;
    });
  }
 
   _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Meet Details',
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: "Doctor's Name",
              ),
            ),
            TextField(
              controller: descpController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Reminder'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            child: const Text('Add Event'),
            onPressed: () {
              if (titleController.text.isEmpty &&
                  descpController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Required title and description'),
                    duration: Duration(seconds: 2),
                  ),
                );
                //Navigator.pop(context);
                return;
              } else {
                print(titleController.text);
                print(descpController.text);
                
                setState(() {
                    if (myEvent[
                          DateFormat('yyyy-MM-dd').format(_selectedDate!).toString()] !=
                      null) {
                    myEvent[
                            DateFormat('yyyy-MM-dd').format(_selectedDate!).toString()]
                        ?.add(details(name: titleController.text, role: descpController.text));
                  } else {
                    myEvent[
                        DateFormat('yyyy-MM-dd').format(_selectedDate!).toString()] =[details(name: titleController.text, role: descpController.text)];
                      
                  }
                });
               
                print(
                    "New Event for backend developer ${json.encode(myEvent)}");
                titleController.clear();
                descpController.clear();
                Navigator.pop(context);
                return;
              }
            },
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor's meet"),
      ),
      body:Column(
        children:[
       TableCalendar(firstDay: DateTime(2022),
       lastDay: DateTime(2024),
       focusedDay: _focusedDay,
       calendarFormat: _calendarFormat,
       onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
            eventLoader: _listOfDayEvents,
       ),
       ..._listOfDayEvents(_selectedDate!).map(
            (myEvents) => ListTile(
                
              leading: const Icon(
                Icons.done,
                color: Colors.teal,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text("Doctor's Name:   ${myEvents.name}"),
              ),
              subtitle: Text('Role:   ${myEvents.role}'),
            ),
          ),
       ]
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Schedule a meet'),
    ));
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
