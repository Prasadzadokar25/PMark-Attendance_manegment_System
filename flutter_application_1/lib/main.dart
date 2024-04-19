import 'package:flutter/material.dart';
import 'package:pmark/Information.dart';
import 'package:pmark/userHomePage.dart';
import 'database_connection.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // Widget build(BuildContext context) {
  //   isUserLoggedIn();
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     routes: {
  //       '/login': (context) => const Login(),
  //     },
  //     home: const Login(),
  //   );
  // }

  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"/login": (context) => const Login()},
      title: 'Flutter Demo',
      home: FutureBuilder(
          future: isUserLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ));
            } else {
              bool userLoggedIn = snapshot.data ?? false;
              if (userLoggedIn) {
                return const HomePage();
              } else {
                return const Login();
              }
            }
          }),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<bool> isUserLoggedIn() async {
    List currentUser = await UserInfo.getObject().getCurrentUser();

    if (currentUser.isNotEmpty) {
      Information.getDataObject().setInfo(
          username: currentUser[currentUser.length - 1]["userName"],
          password: currentUser[currentUser.length - 1]["password"]);
    }

    return currentUser.isNotEmpty;
  }
}
