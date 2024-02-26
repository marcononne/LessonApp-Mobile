import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Custom_widgets/General/custom_appbar.dart';
import '../../Resources/coursesApi.dart';
import '../Home/homepage_controller.dart';

class AdminCourse extends StatefulWidget {
    const AdminCourse({Key? key}) : super(key: key);

    @override
    State<AdminCourse> createState() => _AdminCourseState();
}

class _AdminCourseState extends State<AdminCourse> {
    HomePageController controller = HomePageController();
    String username = Get.parameters["username"] as String;

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Scaffold(
                appBar: CustomAppBar(label: "Admin Courses", arrow: true),
                body: FutureBuilder<List<Subject>>(
                    future: CoursesApi().getAllCourses('getAllCourses'),
                    builder: (context, snapshot) {
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                            itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                            itemBuilder: (BuildContext context, int ind) {
                                return Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                        ),
                                        onPressed: () {
                                            controller.goToAdminTeachersPerCourse(username, snapshot.data!.elementAt(ind).title);
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget> [
                                                    Expanded(
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: <Widget> [
                                                                Text(
                                                                    snapshot.data!.elementAt(ind).title.length > 15 ?
                                                                        "${snapshot.data!.elementAt(ind).title.substring(0, 15)}..." :
                                                                        snapshot.data!.elementAt(ind).title,
                                                                    style: TextStyle(
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Theme.of(context).colorScheme.onSecondaryContainer
                                                                    ),
                                                                    textAlign: TextAlign.center,
                                                                ),
                                                                Icon(
                                                                    Icons.circle,
                                                                    color: snapshot.data!.elementAt(ind).status ?
                                                                        Colors.greenAccent: Colors.red,
                                                                ),
                                                            ],
                                                        )
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                );
                            }
                        );
                    },
                ),
            )
        );
    }
}
