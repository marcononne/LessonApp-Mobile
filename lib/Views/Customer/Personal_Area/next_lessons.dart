import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Custom_widgets/General/custom_appbar.dart';
import '../../../Resources/lessonApi.dart';
import '../../Home/homepage_controller.dart';

class NextLessons extends StatefulWidget {
    const NextLessons({Key? key}) : super(key: key);

    @override
    State<NextLessons> createState() => _NextLessonsState();
}

class _NextLessonsState extends State<NextLessons> {
    final HomePageController controller = Get.find<HomePageController>();
    String username = Get.parameters['username'] as String;
    List<Lesson> _lessons = [];

    void _loadLesson() async {
        _lessons = await LessonApi().fetchUserLessons(username, "Active");
        setState(() {});
    }

    @override
    void initState() {
        super.initState();
        _loadLesson();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: CustomAppBar(
                label: "Next Lessons",
                arrow: true,
            ),
            body: _lessons.isNotEmpty ?
                ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
                itemCount: _lessons.isNotEmpty ? _lessons.length : 0,
                itemBuilder: (BuildContext context, int ind) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondaryContainer,
                                border: Border.all(
                                    width: 1.5,
                                    color: Theme.of(context).colorScheme.onSecondaryContainer
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                    Padding(
                                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                Text(
                                                    _lessons.elementAt(ind).teacher,
                                                    style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)
                                                ),
                                                Text(
                                                    _lessons.elementAt(ind).course.length > 30 ?
                                                    "${_lessons.elementAt(ind).course.substring(0, 30)}..." :
                                                    _lessons.elementAt(ind).course,
                                                    style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)
                                                ),
                                                Text(
                                                    _lessons.elementAt(ind).date,
                                                    style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)
                                                ),
                                                Text(
                                                    _lessons.elementAt(ind).day,
                                                    style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)
                                                ),
                                                Column(
                                                    children: <Widget> [
                                                      Text(
                                                          "${_lessons.elementAt(ind).hour}:00 - ${_lessons.elementAt(ind).hour+1}:00",
                                                          style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)
                                                      )
                                                    ]
                                                ),
                                            ],
                                        ),
                                    ),
                                    Column(
                                        children: [
                                            IconButton(
                                                icon: Icon(
                                                Icons.check_circle,
                                                    size: 25.0,
                                                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                                                ),
                                                onPressed: () => showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) => Dialog(
                                                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                                                        child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                                Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Text(
                                                                        "Are your sure you want to complete the following lesson?",
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(
                                                                            color: Theme.of(context).colorScheme.onTertiary,
                                                                            fontStyle: FontStyle.italic,
                                                                            fontWeight: FontWeight.bold
                                                                        ),
                                                                    ),
                                                                ),
                                                                Padding(
                                                                    padding: const EdgeInsets.all(3.0),
                                                                    child: Text(
                                                                        "${_lessons.elementAt(ind).teacher}\n"
                                                                        "${_lessons.elementAt(ind).course}\n"
                                                                        "${_lessons.elementAt(ind).date}\n"
                                                                        "${_lessons.elementAt(ind).day}\n"
                                                                        "${_lessons.elementAt(ind).hour}:00 - ${_lessons.elementAt(ind).hour+1}:00",
                                                                        style: TextStyle(
                                                                          color: Theme.of(context).colorScheme.onTertiary
                                                                        )
                                                                    ),
                                                                ),
                                                                Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                        TextButton(
                                                                            onPressed: () async {
                                                                                bool res = await LessonApi().setAccomplishedLesson(_lessons.elementAt(ind).teacher, _lessons.elementAt(ind).course, username, _lessons.elementAt(ind).date, _lessons.elementAt(ind).hour);
                                                                                if(res) {
                                                                                    Navigator.pop(context);
                                                                                    _loadLesson();
                                                                                } else {
                                                                                    Navigator.pop(context);
                                                                                }
                                                                            },
                                                                            child: Text("Yes", style: TextStyle(color: Theme.of(context).colorScheme.onTertiary))
                                                                        ),
                                                                        TextButton(
                                                                            onPressed: () { Navigator.pop(context); },
                                                                            child: Text("No", style: TextStyle(color: Theme.of(context).colorScheme.onTertiary))
                                                                        ),
                                                                    ],
                                                                ),
                                                            ],
                                                        )
                                                    )
                                                )
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                    Icons.delete,
                                                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                                                ),
                                                onPressed: () => showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) => Dialog(
                                                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                                                        child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                                 Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Text(
                                                                        "Are your sure you want to delete the following lesson?",
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(
                                                                            color: Theme.of(context).colorScheme.onTertiary,
                                                                            fontStyle: FontStyle.italic,
                                                                            fontWeight: FontWeight.bold
                                                                        ),
                                                                    ),
                                                                ),
                                                                Padding(
                                                                    padding: const EdgeInsets.all(3.0),
                                                                    child: Text(
                                                                        "${_lessons.elementAt(ind).teacher}\n"
                                                                        "${_lessons.elementAt(ind).course}\n"
                                                                        "${_lessons.elementAt(ind).date}\n"
                                                                        "${_lessons.elementAt(ind).day}\n"
                                                                        "${_lessons.elementAt(ind).hour}:00 - ${_lessons.elementAt(ind).hour+1}:00",
                                                                        style: TextStyle(
                                                                            color: Theme.of(context).colorScheme.onTertiary,
                                                                        )
                                                                    ),
                                                                ),
                                                                Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                        TextButton(
                                                                            onPressed: () async {
                                                                                bool res = await LessonApi().deleteLesson(_lessons.elementAt(ind).teacher, _lessons.elementAt(ind).course, username, _lessons.elementAt(ind).date, _lessons.elementAt(ind).hour);
                                                                                if(res) {
                                                                                    Navigator.pop(context);
                                                                                    _loadLesson();
                                                                                } else {
                                                                                    Navigator.pop(context);
                                                                                }
                                                                            },
                                                                            child: Text("Yes", style: TextStyle(color: Theme.of(context).colorScheme.onTertiary))
                                                                        ),
                                                                        TextButton(
                                                                            onPressed: () { Navigator.pop(context); },
                                                                            child: Text("No", style: TextStyle(color: Theme.of(context).colorScheme.onTertiary))
                                                                        ),
                                                                    ],
                                                                ),
                                                            ],
                                                        )
                                                    )
                                                )
                                            )
                                        ],
                                    )
                                ],
                            ),
                        ),
                    );
                }
            )
            :
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                            "$username, you do not have any incoming lessons",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground),
                        ),
                    ),
                ],
            ),
        );
    }
}
