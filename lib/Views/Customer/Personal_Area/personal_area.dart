import 'package:flutter/material.dart';
import 'package:lesson_app/Resources/userApi.dart';
import 'package:lesson_app/Resources/utils.dart';
import '../../../Custom_widgets/General/custom_appbar.dart';
import '../../Home/homepage_controller.dart';
import 'package:get/get.dart';

class PersonalArea extends StatefulWidget {
    const PersonalArea({Key? key}) : super(key: key);

    @override
    State<PersonalArea> createState() => _PersonalAreaState();
}

class _PersonalAreaState extends State<PersonalArea> {
    bool switchState = false;
    final HomePageController controller = Get.find<HomePageController>();
    String username = Get.parameters["username"] as String;

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Scaffold(
                appBar: CustomAppBar(label: "Personal Area", arrow: false),
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
                                        controller.goToNextLessonPage(username);
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                                Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                                    child: Text(
                                                        "Next lessons",
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
                                        controller.goToOldLessonsPage(username);
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                                Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                                    child: Text(
                                                        "Completed lessons",
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
                                        controller.goToDeletedLessonsPage(username);
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                                Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                                    child: Text(
                                                        "Deleted lessons",
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
                                padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 70.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                                    ),
                                    onPressed: () async {
                                        String result = await UserApi().logout();
                                        if(result == "Logout successful") {
                                            controller.goToUserHomePage();
                                        }
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                                Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                    child: Text(
                                                        "Logout",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            color:Theme.of(context).colorScheme.onTertiary
                                                        ),
                                                        textAlign: TextAlign.center,
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ),
                            )
                        ],
                    ),
                ),
            )
        );
    }
}
