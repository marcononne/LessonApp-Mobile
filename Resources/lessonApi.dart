import 'dart:convert';
import 'package:http/http.dart';
import 'utils.dart';

class LessonApi {

    String ip = Utils.ip;

    LessonApi();

    Future<String> insertLesson(String title, String name, String surname, String user, DateTime date, int hour) async {
        Response response = await post(
            Uri.parse(
                'http://$ip/ServletController?action=lesson&title=$title&choice=insertLesson&name=$name&surname=$surname&username=$user&date=${date.toString()}&hour=$hour'
            ),
            headers: {
              "Authorization": Utils.token
            }
        );
        if(response.statusCode == 200) {
            final dynamic jsonResult = jsonDecode(response.body);
            String result = jsonResult['result'];
            return result;
        } else {
            throw Exception("Error while trying to insert a lesson");
        }
    }

    Future<bool> deleteLesson(String teacher, String title, String username, String date, int hour) async {
        final my_strings = teacher.split(" ");
        final String name = my_strings[0], surname = my_strings[1];

        Response response = await post(
            Uri.parse(
                'http://$ip/ServletController?action=lesson&choice=deleteLesson&title=$title&name=$name&surname=$surname&username=$username&date=$date&hour=$hour'
            ),
            headers: {
                "Authorization": Utils.token
            }
        );
        if(response.statusCode == 200) {
            final dynamic jsonResult = jsonDecode(response.body);
            String result = jsonResult['result'];
            return result == "Lesson removed successfully";
        } else {
            throw Exception("Error while trying to delete a lesson");
        }
    }

    Future<bool> setAccomplishedLesson(String teacher, String title, String username, String date, int hour) async {
        final my_strings = teacher.split(" ");
        final String name = my_strings[0], surname = my_strings[1];

        Response response = await post(
            Uri.parse(
                'http://$ip/ServletController?action=lesson&choice=setAccomplished&title=$title&name=$name&surname=$surname&username=$username&date=$date&hour=$hour'
            ),
            headers: {
                "Authorization": Utils.token
            }
        );
        if(response.statusCode == 200) {
            final dynamic jsonResult = jsonDecode(response.body);
            String result = jsonResult['result'];
            return result == "Lesson accomplished successfully";
        } else {
            throw Exception("Error while trying to delete a lesson");
        }
    }

    Future<List<Lesson>> fetchUserLessons(String username, String status) async {
        Response response = await get(
            Uri.parse(
                'http://$ip/ServletController?action=lesson&choice=userLessons&username=$username&status=$status'
            ),
            headers: {
                "Authorization": Utils.token
            }
        );
        if (response.statusCode == 200) {
            final dynamic jsonResponse = jsonDecode(response.body);
            if (jsonResponse == null) {
                return [];
            }
            final List<Lesson> lessons = (jsonResponse as List).map((e) => Lesson.fromJson(e)).toList();
            return lessons;
        } else {
            return [];
        }
    }

    Future<List<Lesson>> fetchAllLessons(String username) async {
        Response response = await get(
            Uri.parse('http://$ip/ServletController?action=lesson&choice=allLessons&username=$username'),
            headers: {
                "Authorization": Utils.token
            }
        );
        if (response.statusCode == 200) {
            final dynamic jsonResponse = jsonDecode(response.body);
            if (jsonResponse == null) {
                return [];
            }
            final List<Lesson> lessons = (jsonResponse as List).map((e) => Lesson.fromJson(e)).toList();
            return lessons;
        } else {
            return [];
        }
    }

}

class Lesson {
    String username;
    String teacher;
    String course;
    String date;
    String day;
    int hour;
    String status;

    Lesson({
        required this.username,
        required this.teacher,
        required this.course,
        required this.date,
        required this.day,
        required this.hour,
        required this.status
    });

    factory Lesson.fromJson(Map<String,dynamic> json) => Lesson(
        username: json['username'],
        teacher: json['teacher'],
        course: json['course'],
        date: json['date'],
        day: json['day'],
        hour: json['hour'],
        status: json['status']
    );
}
