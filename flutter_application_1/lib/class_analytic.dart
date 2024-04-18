import 'package:flutter/material.dart';
import 'package:pmark/Information.dart';
import 'package:pmark/class_details.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassAnalytic extends StatefulWidget {
  const ClassAnalytic({super.key});

  @override
  State createState() => _ClassAnalyticState();
}

class _ClassAnalyticState extends State<ClassAnalytic> {
  List classes = Information.getDataObject().classesObjList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 166, 119, 254),
        title: Text(
          "Classe's ",
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: const Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: SizedBox(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: classes.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ClassDetails(
                          classObj: classes[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    height: 165,
                    width: 165,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 9,
                          spreadRadius: 2,
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          offset: Offset(3, 3),
                        )
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 74,
                          width: 74,
                          child: Image.asset(
                            "assets/images/classRoom.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          classes[index].class_name,
                          style: const TextStyle(
                            color: Color.fromRGBO(33, 33, 33, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          classes[index].subject_name,
                          style: const TextStyle(
                            color: Color.fromRGBO(33, 33, 33, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
