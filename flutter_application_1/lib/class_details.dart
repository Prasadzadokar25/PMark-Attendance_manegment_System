import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pmark/Information.dart';
import 'package:pie_chart/pie_chart.dart';

class ClassDetails extends StatefulWidget {
  final ModelClassData classObj;
  const ClassDetails({super.key, required this.classObj});
  @override
  State createState() => _ClassDetailsState();
}

class _ClassDetailsState extends State<ClassDetails> {
  int selectedDrawerButtonIndex = 2;
  Map<String, double> data = {
    "Absent": 20,
    "Leav": 10,
    "Present": 70,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.classObj.class_name} [${widget.classObj.subject_name}]",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PieChart(
                dataMap: data,
                animationDuration: const Duration(milliseconds: 800),
                chartType: ChartType.ring,
                chartRadius: 160,
                ringStrokeWidth: 30,
                centerText: "Attendance\nGraph",

                //colorList: [],
                legendOptions: const LegendOptions(
                  // showLegendsInRow: true,
                  //legendPosition: LegendPosition.right,
                  //showLegends: true,
                  //legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  //showChartValueBackground: true,
                  showChartValues: false,
                  //showChartValuesInPercentage: true,
                  // showChartValuesOutside: true,
                  //decimalPlaces: 1,
                )),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  "Total Lecturs : ${widget.classObj.lectureCount}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Boys count",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "57",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Text(
                        "Girls  count",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "23",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Text(
                        "Total  count",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "80",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Students",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 0.35),
                    ),
                  ),
                ),
                //height: MediaQuery.of(context).size.height * 0.4,
                child: FutureBuilder(
                  future: fetchsStudents(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (studentList.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "No student found",
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 100,
                                width: 100,
                                child:
                                    Image.asset("assets/images/noStudent.png"),
                              )
                            ],
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: studentList.length,
                          itemBuilder: (context, index) {
                            return studentCard(studentList[index]);
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget studentCard(Map studentData) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          const SizedBox(
              //child: Image.asset("accests/images/category_food.png"),
              ),
          const SizedBox(
            width: 10,
          ),
          Container(
            alignment: Alignment.center,
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black12,
            ),
            child: Text(
              "${studentData["roll_no"]}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "${studentData["student_name"]}",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  List<dynamic> studentList = [];

  Future<List> fetchsStudents() async {
    Map<String, dynamic> requestData = {
      'class_id': "${widget.classObj.class_id}"
    };

    Uri uri = Uri.parse("http://prasad25.pythonanywhere.com/getStudents");
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      studentList = jsonDecode(response.body);
      sort(studentList);
    }

    return studentList;
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
}
