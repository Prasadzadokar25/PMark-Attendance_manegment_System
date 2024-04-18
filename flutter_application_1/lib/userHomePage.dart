import 'package:flutter/material.dart';
import 'package:pmark/Information.dart';
import 'package:pmark/classInfo.dart';
import 'package:pmark/class_analytic.dart';
import 'package:intl/intl.dart';

import 'profilePage.dart';
import 'take_attendance.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<HomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const ClassInfo(),
    const EditProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_rounded),
            label: "My Class's",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 139, 56, 255),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        onTap: _onItemTapped,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State createState() => _HomeState();
}

class _HomeState extends State {
  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //backgroundColor: Color.fromARGB(255, 188, 147, 255),
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        //   leading: const Icon(Icons.menu_outlined),
        actions: [
          GestureDetector(
            child: const Icon(
              Icons.notifications_active,
              weight: 800,
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      drawer: Drawer(
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 163, 133, 255),
                  shape: BoxShape.rectangle),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 130, 127, 127),
                      radius: 40,
                      child: Image.asset(
                        "assets/images/user.png",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    Information.getDataObject().getUsername(),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Email: prasadzadokar25@gmail.com',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  )
                ],
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Handle item 1 tap
              },
            ),
            ListTile(
              title: const Text('To do'),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Today's attendance"),
              onTap: () {},
            ),
            ListTile(
              title: const Text('My classes'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (contex) {
                  return const ClassInfo();
                }));
              },
            ),
            ListTile(
              title: const Text("Time table"),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            ListTile(
              title: const Text('Print attendence'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('FeedBack'),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            ListTile(
              title: const Text('About Us'), onTap: () {},
              // Handle item 2 ta
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
      body:
          //padding: MediaQuery.of(context).viewInsets,
          Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 1,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 23,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F5FF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 10)
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          Information.getDataObject().getUsername(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          DateFormat.yMMMMEEEEd().format(DateTime.now()),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                height: 105,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                  border: Border.all(
                    color: const Color.fromARGB(255, 37, 47, 112),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 178, 118, 255),
                            ),
                          ),
                          SizedBox(
                            width: 190,
                            child: Text(
                              "Let's make SITS proud together, Prasad and Team ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 26, 26, 26),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 100,
                        width: 95,
                        child: Image.asset("assets/images/teacherlogin.jpg"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Acadamic",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 55, 29, 90),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(44, 0, 0, 0),
                              blurRadius: 7,
                              offset: Offset(5, 5),
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const TakeAttendance()));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            fixedSize: const Size(150, 110),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 252, 113, 113),
                            //shadowColor: Color.fromARGB(255, 87, 34, 247),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: Image.asset(
                                        "assets/images/attendaceIcon.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                const Text(
                                  "Take\nAttendance",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(44, 0, 0, 0),
                              blurRadius: 7,
                              offset: Offset(5, 5),
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const ClassAnalytic()));
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              fixedSize: const Size(150, 110),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 163, 133, 255),
                              //shadowColor: Color.fromARGB(255, 87, 34, 247),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        width: 35,
                                        child: Image.asset(
                                          "assets/images/analyticIcon.png",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  const Text(
                                    "Class\nAnalytic",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            /* gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.4, 0.6],
                              colors: [Colors.orange, Colors.green],
                            ),*/
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(45, 0, 0, 0),
                                  blurRadius: 7,
                                  offset: Offset(5, 5)),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            )),
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              fixedSize: const Size(150, 110),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              backgroundColor:
                                  const Color.fromRGBO(208, 215, 250, 1),
                              //shadowColor: Color.fromARGB(255, 87, 34, 247),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        width: 35,
                                        child: Image.asset(
                                          "assets/images/studentInfo.png",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  const Text(
                                    "Student\nInformation",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                      const Spacer(),
                      Container(
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(45, 0, 0, 0),
                                  blurRadius: 7,
                                  offset: Offset(5, 5)),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            )),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            fixedSize: const Size(150, 110),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 224, 84),
                            //shadowColor: Color.fromARGB(255, 87, 34, 247),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: Image.asset(
                                        "assets/images/printAttendance.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                const Text(
                                  "Print\nAttendance",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            /* gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.4, 0.6],
                              colors: [Colors.orange, Colors.green],
                            ),*/
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(45, 0, 0, 0),
                                  blurRadius: 7,
                                  offset: Offset(5, 5)),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            )),
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              fixedSize: const Size(150, 110),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 96, 253, 206),
                              //shadowColor: Color.fromARGB(255, 87, 34, 247),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        width: 35,
                                        child: Image.asset(
                                          "assets/images/NewStuddentIcon.png",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  const Text(
                                    "Add\nStudent",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                      const Spacer(),
                      Container(
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(45, 0, 0, 0),
                                  blurRadius: 7,
                                  offset: Offset(5, 5)),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            )),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            fixedSize: const Size(150, 110),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 115, 225, 255),
                            //shadowColor: Color.fromARGB(255, 87, 34, 247),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: Image.asset(
                                        "assets/images/newClassIcon.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                const Text(
                                  "Create\nNew class",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*

*/