import 'dart:convert';
import 'package:http/http.dart';
import 'utils.dart';

class CoursesApi {

    String ip = Utils.ip;

    CoursesApi();

    Future<List<Subject>> getAllCourses(String choice) async {
        Response response = await get(
            Uri.parse('http://$ip/ServletController?action=courses&choice=$choice'),
            headers: {
                "Authorization": Utils.token
            }
        );
        if(response.statusCode == 200) {
            final List<dynamic> jsonCourses = jsonDecode(response.body);
            final List<Subject> courses = jsonCourses.map((e) => Subject.fromJson(e)).toList();
            return courses;
        } else {
            throw Exception("Error fetching courses");
        }
    }

    Future<List<Subject>> getAllActiveCourses(String choice) async {
        Response response = await get(
            Uri.parse('http://$ip/ServletController?action=courses&choice=$choice'),
        );
        if(response.statusCode == 200) {
            final List<dynamic> jsonCourses = jsonDecode(response.body);
            final List<Subject> courses = jsonCourses.map((e) => Subject.fromJson(e)).toList();
            return courses;
        } else {
            throw Exception("Error fetching active courses");
        }
    }
}

class Subject {
    String title;
    String description;
    bool status;

    Subject({
        required this.title,
        required this.description,
        required this.status
    });

    factory Subject.fromJson(Map<String,dynamic> json) => Subject(title: json['title'], description: json['description'], status: json['status']);
}
