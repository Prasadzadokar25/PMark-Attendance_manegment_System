import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'Information.dart';

class TakeAttendance extends StatefulWidget {
  const TakeAttendance({super.key});

  @override
  State createState() => _TakeAttendanceState();
}

class _TakeAttendanceState extends State {
  TextEditingController dateController = TextEditingController();
  bool startButtonPressed = false;
  List colors = [
    const Color.fromARGB(255, 250, 232, 232),
    const Color.fromARGB(255, 230, 236, 255),
    const Color.fromARGB(255, 250, 249, 232),
    const Color.fromARGB(255, 250, 232, 250)
  ];

  List cardList = Information.getDataObject().classes;

  Future<void> showCalender() async {
    DateTime? pickdate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );

    String formatedDate = DateFormat.yMMMd().format(pickdate!);
    setState(() {
      dateController.text = formatedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 166, 119, 254),
        title: Text(
          "Attendance",
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w700,
              fontSize: 23,
              color: const Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: (cardList.isNotEmpty)
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    onChanged: (value) {
                      dateController.text;

                      setState(() {});
                    },
                    readOnly: true,
                    onTap: showCalender,
                    controller: dateController,
                    decoration: InputDecoration(
                      hintText: "select date",
                      errorText:
                          (dateController.text.isEmpty && startButtonPressed)
                              ? "Please select date"
                              : null,
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(15, 15, 15, 0.466),
                      ),
                      suffixIcon: GestureDetector(
                        child: const Icon(Icons.calendar_month),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1),
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
                ),
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cardList.length,
                      itemBuilder: ((context, index) {
                        return getCard(context, index);
                      }),
                    ),
                  ),
                )
              ],
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
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 14,
                  offset: const Offset(0, 15),
                ),
              ]),
          child: Column(
            children: [
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
                          cardList[index]['class_name'],
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
                          "Strength : ${cardList[index]["strength"]}",
                          style: GoogleFonts.quicksand(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: 230,
                        child: Text(
                          "Subject : ${cardList[index]['subject_name']}",
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
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      await fetchsstudent(("${cardList[index]['class_id']}"));
                      (dateController.text.isNotEmpty)
                          ? {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 300),
                                  pageBuilder: (context, animation, _) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: StartAttendace(
                                          className: cardList[index]
                                              ['class_name'],
                                          subjcetName: cardList[index]
                                              ['subject_name'],
                                          student: student,
                                          date: dateController.text),
                                    );
                                  },
                                ),
                              )
                            }
                          : setState(
                              () {
                                startButtonPressed = true;
                                // fetchsstudent();
                              },
                            );
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(160, 10)),
                    child: const Text(
                      "Start Attendance",
                      style: TextStyle(fontSize: 14.5),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  List<dynamic> student = [];

  Future<List> fetchsstudent(String classId) async {
    final Map<String, dynamic> requestData = {'class_id': classId};
    print("here to call student list");
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
    } else {
      throw Exception('Failed to load classes***************');
    }

    setState(() {});
    print(student);
    return student;
  }
}

class StartAttendace extends StatefulWidget {
  String className;
  String subjcetName;
  List student;
  List status = [-1];
  String date;
  StartAttendace(
      {required this.className,
      required this.subjcetName,
      super.key,
      required this.student,
      required this.date});

  @override
  State createState() => _StartAttendaceState();
}

class _StartAttendaceState extends State<StartAttendace> {
  int index = 0;
  int presentCount = 0;
  int absentCount = 0;
  String date = DateFormat.yMMMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 166, 119, 254),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Text(
                    "${widget.className} ( ${widget.subjcetName} )   ",
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                Text(
                  " Attendance for  ${widget.date}  ",
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: const Color.fromARGB(255, 255, 255, 255)),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: (widget.student.isNotEmpty)
            ? Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        top: 5, left: 5, right: 5, bottom: 6),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 250, 232, 232),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(5, 8),
                        ),
                      ],
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
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1.2,
                                            blurRadius: 14,
                                          ),
                                        ],
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Image.asset(
                                        "assets/images/Group 43.png"),
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
                                    "${widget.student[index]['student_name']}",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                  width: 230,
                                  child: Text(
                                    "Roll No: : ${widget.student[index]['roll_no']}",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          attendeceProcces();
                          presentCount++;
                          widget.status.add(1);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            fixedSize: const Size(180, 180),
                            backgroundColor:
                                const Color.fromARGB(255, 176, 255, 199)),
                        child: const Text(
                          "Present",
                          style: TextStyle(fontSize: 23),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          attendeceProcces();
                          absentCount++;
                          widget.status.add(1);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            fixedSize: const Size(180, 180),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 176, 176)),
                        child: const Text(
                          "Absent",
                          style: TextStyle(fontSize: 23),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.arrow_back,
                          size: 35,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Image.asset("assets/images/noClassFound.png"),
                    ),
                    const Text(
                      "class is empty",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  void attendeceProcces() {
    if (index == widget.student.length - 1) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            //clipBehavior: Clip.antiAliasWithSaveLayer,
            title: const Text(
              "Attendence completed",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Attendence of ${widget.className} class for ${widget.subjcetName} is marked succefuly",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Present count: $presentCount",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Apsent count: $absentCount",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    /*Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return TakeAttendance();
                      }),
                    );*/
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 137, 230, 140)),
                  child: const Text("Conform"),
                )
              ],
            ),
          );
        },
      );
    } else {
      index++;
    }
  }
}
