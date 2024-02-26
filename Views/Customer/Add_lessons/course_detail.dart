import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Custom_widgets/General/custom_appbar.dart';
import '../../Home/homepage_controller.dart';
import '../../../Resources/my_strings.dart';

class CourseDetail extends StatefulWidget {
    CourseDetail({Key? key, required this.label, required this.description}) : super(key: key);

    String label;
    String description;

    @override
    State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {

    final HomePageController controller = Get.find<HomePageController>();
    String username = Get.parameters["username"] as String;

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Scaffold(
                appBar: CustomAppBar(label: widget.label, arrow: true),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                    Expanded(
                                        child: Column(
                                            children: [
                                                DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(width: 10),
                                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                                    )
                                                ),
                                                Column(
                                                    children: [
                                                        Padding(
                                                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                                                            child: Text(
                                                                "Course description:",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Theme.of(context).colorScheme.onBackground
                                                                ),
                                                            )
                                                        ),
                                                        Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                                                            child: Padding(
                                                                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                                                                child: Text(
                                                                    widget.description,
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                        color: Theme.of(context).colorScheme.onBackground
                                                                    )
                                                                ),
                                                            )
                                                        ),
                                                    ]
                                                )
                                            ],
                                        )
                                    )
                                ],
                            ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                            ),
                            onPressed: () {
                                controller.goToTeachersList(username, widget.label);
                            },
                            child: Text(My_Strings.bookingButton, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer))
                        )
                    ]
                ),
            ),
        );
    }
}
