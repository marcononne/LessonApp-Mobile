import 'package:flutter/material.dart';
import '../../Custom_widgets/General/custom_appbar.dart';
import '../../Custom_widgets/General/custom_course_preview.dart';
import 'package:get/get.dart';
import 'homepage_controller.dart';
import '../../Resources/coursesApi.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
    final homePageController = Get.find<HomePageController>();

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: WillPopScope(
                onWillPop: () async {
                    return false;
                },
                child: Scaffold(
                    appBar: CustomAppBar(label: "User Home Page", arrow: true),
                    body: FutureBuilder<List<Subject>>(
                        future: CoursesApi().getAllActiveCourses('getAllActiveCourses'),
                        builder: (context, snapshot) {
                            return ListView.builder(
                                padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
                                itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                                itemBuilder: (BuildContext context, int ind) {
                                    return CustomCoursePreview(isClickable: false, title: snapshot.data!.elementAt(ind).title, description: snapshot.data!.elementAt(ind).description, username:"");
                                }
                            );
                        },
                    ),
                ),
            ),
        );
    }
}
