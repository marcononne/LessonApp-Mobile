import 'dart:convert';
import 'package:http/http.dart';
import 'utils.dart';

class TeachersApi {

    String ip = Utils.ip;

    TeachersApi();

    Future<List<Teacher>> teachersAvailable(String title) async {
        Response response = await get(
            Uri.parse('http://$ip/ServletController?action=lesson&choice=teachersAvailable&title=$title'),
            headers: {
                "Authorization": Utils.token
            }
        );
        if(response.statusCode == 200) {
            final List<dynamic> jsonTeachers = jsonDecode(response.body);
            final List<Teacher> teachers = jsonTeachers.map((e) => Teacher.fromJson(e)).toList();
            return teachers;
        } else {
            throw Exception("Error fetching available teachers");
        }
    }

    Future<List<Teacher>> teachersPerCourse(String title) async {
        Response response = await get(
            Uri.parse('http://$ip/ServletController?action=teaching&choice=teachersPerCourse&title=$title'),
            headers: {
                "Authorization": Utils.token
            }
        );
        if(response.statusCode == 200) {
            final List<dynamic> jsonTeachers = jsonDecode(response.body);
            final List<Teacher> teachers = jsonTeachers.map((e) => Teacher.fromJson(e)).toList();
            return teachers;
        } else {
            throw Exception("Error fetching teachers per course");
        }
    }

    Future<List<Teacher>> getAllTeachers(String username) async {
        Response response = await get(
            Uri.parse('http://$ip/ServletController?action=teacher&choice=getAllTeachers&username=$username'),
            headers: {
                "Authorization": Utils.token
            }
        );
        if(response.statusCode == 200) {
            final List<dynamic> jsonTeachers = jsonDecode(response.body);
            final List<Teacher> teachers = jsonTeachers.map((e) => Teacher.fromJson(e)).toList();
            return teachers;
        } else {
            throw Exception("Error fetching all the teachers");
        }
    }

}

class Teacher {
    String name;
    String surname;
    bool status;

    Teacher({
        required this.name,
        required this.surname,
        required this.status
    });

    factory Teacher.fromJson(Map<String,dynamic> json) => Teacher(name: json['name'], surname: json['surname'], status: json['status']);
}
