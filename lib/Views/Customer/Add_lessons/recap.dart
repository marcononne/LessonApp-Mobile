import 'package:flutter/material.dart';
import '../../../Resources/lessonApi.dart';
import '../../../Custom_widgets/General/custom_appbar.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../Home/homepage_controller.dart';

class Recap extends StatefulWidget {
    const Recap({Key? key}) : super(key: key);

    @override
    State<Recap> createState() => _RecapState();
}

class _RecapState extends State<Recap> {
    String username = Get.parameters["username"] as String;
    String label = Get.parameters["label"] as String;
    String name = Get.parameters["name"] as String;
    String surname = Get.parameters["surname"] as String;
    String tempDate = Get.parameters["date"] as String;
    String hour = Get.parameters["hour"] as String;

    final HomePageController controller = Get.find<HomePageController>();

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Scaffold(
                appBar: CustomAppBar(label: "Recap", arrow: true),
                body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                            Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        DecoratedBox(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 3, color: Theme.of(context).colorScheme.onBackground),
                                                borderRadius: const BorderRadius.all(Radius.circular(20))
                                            ),
                                            child: Padding(
                                                padding: const EdgeInsets.fromLTRB(40.0, 30.0, 30.0, 30.0),
                                                child: Text(
                                                    "$label \n\n\n"
                                                    "$name $surname \n\n\n"
                                                    "${DateTime.parse(tempDate).toString().replaceAll("00:00:00.000", "")} \n\n\n"
                                                    "$hour:00 - ${int.parse(hour)+1}:00",
                                                    style: TextStyle(
                                                        color: Theme.of(context).colorScheme.onBackground
                                                    ),
                                                ),
                                            ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(top: 30.0),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                                ),
                                                onPressed: () async {
                                                    String ris = await LessonApi().insertLesson(label, name, surname, username, DateTime.parse(tempDate), int.parse(hour));
                                                    if(ris == "Lesson added successfully") {
                                                        const countdownDuration = Duration(seconds: 1, milliseconds: 500);
                                                        int countdownValue = countdownDuration.inSeconds;
                                                        Timer countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
                                                            if (countdownValue == 0) {
                                                                timer.cancel();
                                                                Navigator.of(context).pop();
                                                            } else {
                                                                countdownValue--;
                                                            }
                                                        });
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                                return AlertDialog(
                                                                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                                                                    title: Text('Lesson booked successfully', style: TextStyle(color: Theme.of(context).colorScheme.onTertiary)),
                                                                    content: Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                            Text('You will be redirected to the homepage in a few seconds... ', style: TextStyle(color: Theme.of(context).colorScheme.onTertiary)),
                                                                        ],
                                                                    ),
                                                                );
                                                            }
                                                        ).whenComplete(() { countdownTimer.cancel(); controller.goToCustomerHomePage(username); });
                                                    } else {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) => Dialog(
                                                                backgroundColor: Theme.of(context).colorScheme.onError,
                                                                child: Column(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                    children: [
                                                                         Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: Text(
                                                                                "Booking error",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                    color: Theme.of(context).colorScheme.error,
                                                                                    fontStyle: FontStyle.italic,
                                                                                    fontWeight: FontWeight.bold
                                                                                )
                                                                            ),
                                                                        ),
                                                                        Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: Text(
                                                                                ris,
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                    color: Theme.of(context).colorScheme.error,
                                                                                    fontStyle: FontStyle.italic,
                                                                                ),
                                                                            ),
                                                                        )
                                                                    ],
                                                                ),
                                                            )
                                                        );
                                                    }
                                                },
                                                child: Text("Book this lesson", style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer))
                                            ),
                                        )
                                    ],
                                ),
                            ),
                        ],
                    ),
                )
            )
        );
    }
}
