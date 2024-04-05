// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ModelCard {
  String className;
  String strength;
  String date;
  String image;
  String subject;

  ModelCard(
      {required this.className,
      required this.strength,
      required this.date,
      required this.subject,
      this.image = "assets/images/Group 43.png"});
}

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
  List<ModelCard> cardList = [
    ModelCard(
        className: 'TE - IT',
        strength: "70 ",
        date: '10 July 2023',
        subject: "Mathematics",
        image: "assets/images/Group 43.png"),
    ModelCard(
        className: 'SE - IT',
        strength: "80  ",
        date: '10 July 2023',
        subject: "Mathematics",
        image: "assets/images/Group 43.png"),
  ];
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cardList.length,
                  itemBuilder: ((context, index) {
                    return getCard(context, index);
                  }),
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
                          child: Image.asset(cardList[index].image),
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
                          cardList[index].className,
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
                          "Strength : ${cardList[index].strength}",
                          style: GoogleFonts.quicksand(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: 230,
                        child: Text(
                          "Subject : ${cardList[index].subject}",
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
                    "Created on\n${cardList[index].date}",
                    style: GoogleFonts.quicksand(
                        color: const Color.fromARGB(224, 116, 114, 114),
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 6,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      (dateController.text.isNotEmpty)
                          ? Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 300),
                                pageBuilder: (context, animation, _) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: StartAttendace(
                                      className: cardList[index].className,
                                      subjcetName: cardList[index].subject,
                                    ),
                                  );
                                },
                              ),
                            )
                          : setState(() {
                              startButtonPressed = true;
                            });
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
            ]))
      ],
    );
  }
}

class StartAttendace extends StatefulWidget {
  String className;
  String subjcetName;
  StartAttendace(
      {required this.className, required this.subjcetName, super.key});

  @override
  State createState() =>
      _StartAttendaceState(className: className, subjcetName: subjcetName);
}

class _StartAttendaceState extends State {
  String className;
  String subjcetName;
  _StartAttendaceState({
    required this.className,
    required this.subjcetName,
  });
  List classes = [
    [
      {
        'name': 'prasad Zadokar',
        'rollNo': '3310578579',
        'image': "assets/images/Group 43.png"
      },
      {
        'name': 'Soham landge',
        'rollNo': '3310578579',
        'image': "assets/images/Group 43.png"
      },
      {
        'name': 'Ankush Bhechewar',
        'rollNo': '3310578579',
        'image': "assets/images/Group 43.png"
      },
      {
        'name': 'Srushti dadas',
        'rollNo': '3310578579',
        'image': "assets/images/Group 43.png"
      },
      {
        'name': 'prasad Zadokar',
        'rollNo': '3310578579',
        'image': "assets/images/Group 43.png"
      },
      {
        'name': 'prasad zadokar',
        'rollNo': '3310578579',
        'image': "assets/images/Group 43.png"
      },
    ],
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 166, 119, 254),
        title: Text(
          "$className ( $subjcetName )",
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w700,
              fontSize: 23,
              color: const Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 6),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                  ]),
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
                              child: Image.asset(classes[0][index]['image']),
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
                              classes[0][index]['name'],
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
                              "Roll No: : ${classes[0][index]['rollNo']}",
                              style: GoogleFonts.quicksand(
                                  fontSize: 14, fontWeight: FontWeight.w500),
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
                    index++;
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
                    index++;
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
        ),
      ),
    );
  }
}
