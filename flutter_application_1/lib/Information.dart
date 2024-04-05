import 'dart:convert';

import 'package:http/http.dart' as http;

class Information {
  String username = "prasadzadokars";
  String password = "";
  int teacherid = 0;

  Information() {}

  static Information obj = Information();

  static Information getDataObject() {
    return obj;
  }

  int setInfo({required String username, required String password}) {
    obj.username = username;
    obj.password = password;
    fetchTeacherId();
    fetchClasses(obj.username);
    return 1;
  }

  String getUsername() {
    return obj.username;
  }

  String getPassword() {
    return obj.password;
  }

  String getTeacherId() {
    return "${obj.teacherid}";
  }

  Future<void> fetchTeacherId() async {
    final Map<String, dynamic> requestData = {'username': obj.username};

    final response = await http.post(
      Uri.parse('http://prasad25.pythonanywhere.com/get_teacher_id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      teacherid = responseData['id'];
      print(
          "-------------------------------------------------------------------$teacherid");
    } else {
      throw Exception('Failed to load teacher id');
    }
  }

  List<dynamic> classes = [];

  Future<void> fetchClasses(String teacherName) async {
    final Map<String, dynamic> requestData = {'username': obj.username};
    print("here to call");
    final response = await http.post(
      Uri.parse('http://prasad25.pythonanywhere.com/classes'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );
    print("+++++++++++++++++++++++");
    if (response.statusCode == 200) {
      print("in if===============");
      classes = jsonDecode(response.body);
    } else {
      throw Exception('Failed to load classes');
    }
    print('Class ID: ${classes[0]['class_id']}');
    print('Class ID: ${classes[0]['class_name']}');
  }
}
