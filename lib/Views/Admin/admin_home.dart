import 'package:flutter/material.dart';
import '../../../Custom_widgets/General/custom_appbar.dart';
import '../Home/homepage_controller.dart';
import 'package:get/get.dart';

class AdminHome extends StatefulWidget {
    const AdminHome({Key? key}) : super(key: key);

    @override
    State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

    final HomePageController controller = Get.find<HomePageController>();
    String username = Get.parameters['username'] as String;

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Scaffold(
                appBar: CustomAppBar(label: "Admin Home Page", arrow: false),
                body: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
                    child: Column(
                        children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                                    onPressed: () {
                                        controller.goToAdminCourse(username);
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                                Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                                    child: Text(
                                                        "Courses",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            color: Theme.of(context).colorScheme.onSecondaryContainer
                                                        ),
                                                        textAlign: TextAlign.center,
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                                    onPressed: () {
                                        controller.goToAdminTeachers(username);
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                                Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                                    child: Text(
                                                        "Teachers",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            color: Theme.of(context).colorScheme.onSecondaryContainer
                                                        ),
                                                        textAlign: TextAlign.center,
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                                    onPressed: () {
                                      controller.goToAdminLessons(username);
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                                Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                                    child: Text(
                                                        "Lessons",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            color: Theme.of(context).colorScheme.onSecondaryContainer
                                                        ),
                                                        textAlign: TextAlign.center,
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
