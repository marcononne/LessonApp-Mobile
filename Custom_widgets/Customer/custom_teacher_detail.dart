import 'package:flutter/material.dart';
import '../../Views/Home/homepage_controller.dart';
import 'package:get/get.dart';

class CustomTeacherDetail extends StatefulWidget {
    const CustomTeacherDetail({Key? key, required this.name, required this.surname, required this.index, required this.label}) : super(key: key);

    final String name;
    final String surname;
    final int index;
    final String label;

    @override
    State<CustomTeacherDetail> createState() => _CustomTeacherDetailState();
}

class _CustomTeacherDetailState extends State<CustomTeacherDetail> {
    HomePageController controller = HomePageController();
    String username = Get.parameters["username"] as String;

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                ),
                onPressed: () {
                    controller.goToDateTimeSelector(username, widget.label, widget.name, widget.surname);
                },
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget> [
                            Expanded(
                                child: Column(
                                    children: <Widget> [
                                        Text(
                                            "${widget.name} ${widget.surname}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).colorScheme.onSecondaryContainer
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
