import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';

class ClassDetails extends StatefulWidget {
  const ClassDetails({super.key});
  @override
  State createState() => _ClassDetailsState();
}

class _ClassDetailsState extends State {
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
        title: const Text(
          "Class Anyalatics",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            const Row(
              children: [
                Text(
                  "Total Lecturs : 17",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
              height: 30,
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
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return graphCard(index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget graphCard(int index) {
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
              "${index + 1}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Student Name eg prasad",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget getDrawerButtons({
    required IconData icon,
    required String label,
    required int buttonIndex,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (buttonIndex == selectedDrawerButtonIndex)
            ? const Color.fromRGBO(14, 161, 125, 0.15)
            : null,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      height: 45,
      width: 186,
      alignment: Alignment.center,
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color.fromRGBO(5, 158, 117, 1),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(
            label,
            style: TextStyle(
              color: (buttonIndex == selectedDrawerButtonIndex)
                  ? const Color.fromRGBO(5, 158, 117, 1)
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
