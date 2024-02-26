import 'package:flutter/material.dart';
import '../../../Custom_widgets/General/custom_appbar.dart';
import '../../../Custom_widgets/General/custom_course_preview.dart';
import '../../../Resources/coursesApi.dart';
import '../../Home/homepage_controller.dart';
import 'package:get/get.dart';

/// Customer --> Utente loggato / registrato

class CustomerHome extends StatefulWidget {
    CustomerHome({Key? key}) : super(key: key);

    @override
    State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {

    HomePageController controller = HomePageController();
    String username = Get.parameters["username"] as String;

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: ScaffoldMessenger(
                child: Scaffold(
                    appBar: CustomAppBar(label: "Customer Home Page", arrow: false),
                    body: FutureBuilder<List<Subject>>(
                        future: CoursesApi().getAllActiveCourses('getAllActiveCourses'),
                        builder: (context, snapshot) {
                            return ListView.builder(
                                padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
                                itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                                itemBuilder: (BuildContext context, int ind) {
                                    return CustomCoursePreview(isClickable: true, title: snapshot.data!.elementAt(ind).title, description: snapshot.data!.elementAt(ind).description, username: username);
                                }
                            );
                        },
                    ),
                )
            ),
        );
    }
}
