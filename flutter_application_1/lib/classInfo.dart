import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'Information.dart';
import 'addStudent.dart';

class ClassInfo extends StatefulWidget {
  const ClassInfo({super.key});

  @override
  State createState() => ClassInfoState();
}

class ClassInfoState extends State {
  TextEditingController titleController = TextEditingController();
  TextEditingController strengthController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  bool classCreated = false;
  int classNameError = -1;

  Future<void> createClass(
      {required String className, required String subjcetName}) async {
    String className = titleController.text;
    String strength = strengthController.text;
    String subjcetName = subjectController.text;
    String date = DateFormat.yMMMd().format(DateTime.now());

    String url = 'http://prasad25.pythonanywhere.com//createClassroom';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {
      'className': className,
      'subjectName': subjcetName,
      'strength': strength,
      'dateOfCreation': date,
      'teacher_id': Information.getDataObject().getTeacherId(),
    };

    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        print(' class added  successful');
        classCreated = true;
        Navigator.pop(context);
      } else {
        print('already presnt: ${response.reasonPhrase}');
        classNameError = 2;
      }
      setState(() {});
    } catch (error) {
      print('Error: $error');
    }
  }

  List colors = [
    const Color.fromARGB(255, 250, 232, 232),
    const Color.fromARGB(255, 230, 236, 255),
    const Color.fromARGB(255, 250, 249, 232),
    const Color.fromARGB(255, 250, 232, 250)
  ];
  List classList = Information.getDataObject().classes;

  bool isCallTofetchsClass = true;
  @override
  Widget build(BuildContext context) {
    if (isCallTofetchsClass) {
      Information.getDataObject()
          .fetchClasses(Information.getDataObject().getTeacherId());
      print(classList);
      isCallTofetchsClass = false;
    }
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "My Class's",
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w700,
                fontSize: 23,
                color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          backgroundColor: const Color.fromARGB(255, 166, 119, 254)),
      floatingActionButton: FloatingActionButton(
          tooltip: "Add new Class",
          onPressed: () {
            classNameError = -1;
            getBottomSheet(-1);
          },
          backgroundColor: const Color.fromARGB(255, 166, 119, 254),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
            weight: 2,
          )),
      body: (classList.isNotEmpty)
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: classList.length,
              itemBuilder: ((context, index) {
                return getCard(context, index);
              }),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/noClassFound2.png",
                    width: 150,
                    height: 150,
                  ),
                  const Text("   No class found"),
                ],
              ),
            ),
    );
  }

  Widget getCard(BuildContext context, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: const EdgeInsets.all(13),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
                color: colors[index % colors.length],
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 14,
                    offset: const Offset(0, 15),
                  ),
                ]),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 13,
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1.2,
                              blurRadius: 14,
                            ),
                          ], shape: BoxShape.circle, color: Colors.white),
                          child: Image.asset("assets/images/Group 43.png"),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                      ]),
                  const SizedBox(
                    width: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 230,
                        child: Text(
                          classList[index]['class_name'],
                          style: GoogleFonts.quicksand(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 230,
                        child: Text(
                          "Strength : 80",
                          style: GoogleFonts.quicksand(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: 230,
                        child: Text(
                          "Subject : ${classList[index]['subject_name']}",
                          style: GoogleFonts.quicksand(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Created on\n${classList[index]['date_of_creation']}",
                    style: GoogleFonts.quicksand(
                        color: const Color.fromARGB(224, 116, 114, 114),
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (context, animation, _) {
                            return FadeTransition(
                              opacity: animation,
                              child: AddNewStudent(
                                className: classList[index]['class_name'],
                                subjectName: classList[index]['subject_name'],
                                classid: classList[index]['class_id'],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(125, 10)),
                    child: const Text(
                      "Add Student",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(fixedSize: const Size(80, 10)),
                    child: const Text(
                      "More",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      getBottomSheet(index);
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 143, 82, 255),
                    ),
                  )
                ],
              )
            ]))
      ],
    );
  }

  void getBottomSheet(int index) {
    if (index != -1) {
      titleController.text = classList[index].className;
      subjectController.text = classList[index].subject;
      strengthController.text = classList[index].strength;
    } else {
      titleController.clear();
      subjectController.clear();
      strengthController.clear();
    }
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text((index == -1) ? "New Class" : "Edit Class Information",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600)),
                const SizedBox(
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Class Name",
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 139, 56, 255),
                      ),
                    ),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: "eg. FE/SE",
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(0, 0, 0, 0.156)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 139, 56, 255),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      " Subject",
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 139, 56, 255),
                      ),
                    ),
                    TextField(
                      controller: subjectController,
                      decoration: InputDecoration(
                        hintText: "eg. Mathematics",
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.156),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        labelStyle: GoogleFonts.quicksand(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 139, 56, 255),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 139, 56, 255),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      " Strength",
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 139, 56, 255),
                      ),
                    ),
                    TextField(
                      controller: strengthController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "eg. 70",
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.156),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        labelStyle: GoogleFonts.quicksand(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 139, 56, 255),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 139, 56, 255),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
                //class aready present
                SizedBox(
                  child: Text((classNameError == 2)
                      ? "Classroom with this data already present"
                      : ""),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color.fromARGB(255, 170, 111, 254),
                    fixedSize: const Size(300, 50),
                  ),
                  onPressed: () async {
                    await addClass(index);
                    isCallTofetchsClass = true;
                    await Information.getDataObject().fetchClasses(
                        Information.getDataObject().getTeacherId());
                    classList = Information.getDataObject().classes;
                  },
                  child: Text(
                    "Submit",
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  addClass(index) async {
    String className = titleController.text.trim();
    String subject = subjectController.text.trim();
    String strength = strengthController.text.trim();
    String date = DateFormat.yMMMd().format(DateTime.now());

    if (className.isNotEmpty && strength.isNotEmpty && subject.isNotEmpty) {
      if (index == -1) {
        classList.add({
          'class_name': className,
          'subject_name': subject,
          'date_of_creation': date,
          'teacher_id': Information.getDataObject().getTeacherId(),
        });
        await createClass(className: className, subjcetName: subject);
        Information.getDataObject()
            .fetchClasses(Information.getDataObject().getTeacherId());
        setState(() {});
      } else {
        classList[index].className = className;
        classList[index].strength = strength;
        classList[index].date = date;
      }

      titleController.clear();
      subjectController.clear();
      strengthController.clear();

      setState(() {});
    }
  }
}
