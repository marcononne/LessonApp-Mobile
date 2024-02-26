import 'package:flutter/material.dart';
import '../../Views/Home/homepage_controller.dart';
import 'package:get/get.dart';

class CustomCoursePreview extends StatefulWidget {
    CustomCoursePreview({Key? key, required this.isClickable, required this.title, required this.description, required this.username}) : super(key: key);

    bool isClickable;
    String title;
    String description;
    String username;

    @override
    State<CustomCoursePreview> createState() => _CustomCoursePreviewState();
}

class _CustomCoursePreviewState extends State<CustomCoursePreview> {
    final HomePageController controller = Get.find<HomePageController>();

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                ),
                onPressed: () {
                    widget.isClickable ?
                        controller.goToCourseDetail(widget.username, widget.title, widget.description)
                    :
                        controller.goToLogin();
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget> [
                            Expanded(
                                child: Column(
                                    children: <Widget> [
                                        Text(
                                            widget.title,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).colorScheme.onSecondaryContainer,
                                            ),
                                            textAlign: TextAlign.center,
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
}
