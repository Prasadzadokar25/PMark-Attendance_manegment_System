import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AddNewStudent extends StatefulWidget {
  final String className;
  final String subjectName;
  final int classid;
  const AddNewStudent({
    required this.className,
    required this.subjectName,
    required this.classid,
    super.key,
  });

  @override
  State createState() => _AddNewstudenttate();
}

class _AddNewstudenttate extends State<AddNewStudent> {
  TextEditingController studentNameController = TextEditingController();
  TextEditingController studentRollNoController = TextEditingController();
  TextEditingController studentContactController = TextEditingController();

  GlobalKey<FormState> addStudentKey = GlobalKey<FormState>();
  bool studentAlreadyPesent = false;

  List colors = [
    const Color.fromARGB(255, 250, 232, 232),
    const Color.fromARGB(255, 230, 236, 255),
    const Color.fromARGB(255, 250, 249, 232),
    const Color.fromARGB(255, 250, 232, 250)
  ];

  List<dynamic> student = [];

  Future<bool> fetchsstudent(String classId) async {
    final Map<String, dynamic> requestData = {'class_id': classId};
    log("here to call student list");
    final response = await http.post(
      Uri.parse('http://prasad25.pythonanywhere.com/getStudents'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      student = jsonDecode(response.body);
    } /*else {
      throw Exception('Failed to load classes***************');
    }*/

    sort(student);
    setState(() {});

    return true;
  }

  sort(List list) {
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list.length - 1; j++) {
        if (int.parse(list[j]["roll_no"]) > int.parse(list[j + 1]["roll_no"])) {
          Map temp = list[j];
          list[j] = list[j + 1];
          list[j + 1] = temp;
        }
      }
    }
  }

  bool isCallTofetchsstudent = true;
  @override
  Widget build(BuildContext context) {
    if (isCallTofetchsstudent) {
      fetchsstudent("${widget.classid}");
      isCallTofetchsstudent = false;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add student",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w700,
            fontSize: 23,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 166, 119, 254),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),

            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(12))),

            height: 40,
            width: double.infinity,
            //   color: const Color.fromARGB(255, 232, 220, 255),
            child: Text(
              " Class : ${widget.className}",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(12))),

            height: 40,
            width: double.infinity,
            //   color: const Color.fromARGB(255, 232, 220, 255),
            child: Text(
              " Subject : ${widget.subjectName}",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          FutureBuilder(
              future: fetchsstudent("${widget.classid}"),
              builder: (context, snapshot) {
                return (student.isNotEmpty)
                    ? Expanded(
                        child: SizedBox(
                            child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: student.length,
                          itemBuilder: ((context, index) {
                            return getStudentCard(context, index);
                          }),
                        )),
                      )
                    : Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/noClassFound2.png",
                                width: 150,
                              ),
                              const Text(" No Student found"),
                            ],
                          ),
                        ),
                      );
              }),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 166, 119, 254),
              fixedSize: const Size(double.maxFinite, 60),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            onPressed: () {
              getBottomSheet(1);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget getStudentCard(context, index) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.black12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin:
                const EdgeInsets.only(top: 13, left: 13, right: 13, bottom: 6),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            alignment: Alignment.center,
            width: double.infinity,
            decoration: const BoxDecoration(
              //color: colors[index % colors.length],
              borderRadius: BorderRadius.all(Radius.circular(12)),
              /* boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(5, 8),
                  ),
                ],*/
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 52,
                            width: 52,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1.2,
                                blurRadius: 14,
                              ),
                            ], shape: BoxShape.circle, color: Colors.white),
                            //child: Image.asset(classes[0][index]['image']),
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
                            student[index]['student_name'],
                            style: GoogleFonts.quicksand(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                          width: 230,
                          child: Text(
                            "Roll No: : ${student[index]['roll_no']}",
                            style: GoogleFonts.quicksand(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                /*Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        //getBottomSheet(index);
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 143, 82, 255),
                      ),
                    )
                  ],
                )*/
              ],
            ),
          )
        ],
      ),
    );
  }

  void getBottomSheet(int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: addStudentKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("New Student",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
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
                          " Student Name",
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 139, 56, 255),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (studentNameController.text.isEmpty) {
                              return "Please enter valid student name";
                            } else {
                              return null;
                            }
                          },
                          controller: studentNameController,
                          decoration: const InputDecoration(
                            hintText: "eg. prasad zadokar",
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.156),
                            ),
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
                          " Roll No.",
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 139, 56, 255),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (studentRollNoController.text.isEmpty) {
                              return "Please enter valid roll number";
                            } else {
                              try {
                                int.parse(studentRollNoController.text);
                              } catch (e) {
                                return "Please enter valid roll number";
                              }
                              return null;
                            }
                          },
                          onChanged: (value) {
                            studentAlreadyPesent = false;
                            setState(() {});
                          },
                          controller: studentRollNoController,
                          decoration: InputDecoration(
                            hintText: "eg. 79",
                            hintStyle: const TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.156),
                            ),
                            errorText: (studentAlreadyPesent == true)
                                ? "Roll number already present"
                                : null,
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
                          " Contact No.",
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 139, 56, 255),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (studentContactController.text.isNotEmpty) {
                              try {
                                int num =
                                    int.parse(studentContactController.text);

                                int count = 0;
                                while (num != 0) {
                                  num = num ~/ 10;
                                  count++;
                                }
                                if (count != 10) {
                                  return "Enter valid number";
                                }
                              } catch (e) {
                                return "Enter valid number";
                              }
                            } else {
                              return null;
                            }
                          },
                          controller: studentContactController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "eg. 8956652382",
                            hintStyle: const TextStyle(
                              fontSize: 16,
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
                          height: 5,
                        ),
                        const Text(
                          "  Note: Contact is not compalsory",
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ]),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromARGB(255, 170, 111, 254),
                      fixedSize: const Size(300, 50),
                    ),
                    onPressed: () {
                      studentAlreadyPesent = false;
                      if (addStudentKey.currentState!.validate()) {
                        addStudentInDatabase();
                        isCallTofetchsstudent = true;
                        Future<List> fetchsstudent(String classId) async {
                          final Map<String, dynamic> requestData = {
                            'class_id': classId
                          };
                          print("here to call student list");
                          final response = await http.post(
                            Uri.parse(
                                'http://prasad25.pythonanywhere.com/getstudent'),
                            headers: <String, String>{
                              'Content-Type': 'application/json',
                            },
                            body: jsonEncode(requestData),
                          );
                          if (response.statusCode == 200) {
                            student = jsonDecode(response.body);
                          } /*else {
      throw Exception('Failed to load classes***************');
    }*/

                          sort(student);
                          setState(() {});
                          return student;
                        }

                        setState(() {});
                      }
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
          ),
        );
      },
    );
  }

  Future<void> addStudentInDatabase() async {
    String studentName = studentNameController.text;
    String studentRollNo = studentRollNoController.text;
    String studentContact = studentContactController.text;

    String url = 'http://prasad25.pythonanywhere.com/addStudentIfNotExit';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {
      'studentName': studentName,
      'studentRollNo': studentRollNo,
      'studentContact': studentContact,
      'classId': "${widget.classid}",
    };
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        log('added  successful');
        studentNameController.clear();
        studentRollNoController.clear();
        studentContactController.clear();
      } else {
        studentAlreadyPesent = true;
        Navigator.of(context).pop();
        setState(() {});
        print('student already presnt: ${response.reasonPhrase}');
        getBottomSheet(1);
      }
      setState(() {});
    } catch (error) {
      print('Error: $error');
    }
  }
}
