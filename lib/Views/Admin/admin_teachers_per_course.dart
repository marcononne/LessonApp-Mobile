import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Custom_widgets/Admin/custom_admin_teacher_detail.dart';
import '../../Resources/teachersApi.dart';
import '../Home/homepage_controller.dart';

class AdminTeachersPerCourse extends StatefulWidget {
    const AdminTeachersPerCourse({Key? key}) : super(key: key);

    @override
    State<AdminTeachersPerCourse> createState() => _AdminTeachersPerCourseState();
}

class _AdminTeachersPerCourseState extends State<AdminTeachersPerCourse> {
    HomePageController controller = HomePageController();
    String username = Get.parameters["username"] as String;
    String course = Get.parameters["course"] as String;

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    title: Text("$course Teachers", style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                    centerTitle: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiaryContainer),
                        onPressed: () => controller.goToAdminCourse(Get.parameters['username'] as String)
                    )
                ),
                body: FutureBuilder<List<Teacher>>(
                    future: TeachersApi().teachersPerCourse(course),
                    builder: (context, snapshot) {
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                            itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                            itemBuilder: (BuildContext context, int ind) {
                                return CustomAdminTeacherDetail(
                                    name: snapshot.data!.elementAt(ind).name,
                                    surname: snapshot.data!.elementAt(ind).surname,
                                    status: snapshot.data!.elementAt(ind).status,
                                );
                            }
                        );
                    },
                ),
            )
        );
    }
}
