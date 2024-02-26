import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Custom_widgets/General/custom_appbar.dart';
import '../../Resources/lessonApi.dart';
import '../Home/homepage_controller.dart';


class AdminLessons extends StatefulWidget {
    const AdminLessons({Key? key}) : super(key: key);

    @override
    State<AdminLessons> createState() => _AdminLessonsState();
}

class _AdminLessonsState extends State<AdminLessons> {
    final HomePageController controller = Get.find<HomePageController>();
    String username = Get.parameters['username'] as String;
    List<Lesson> _lessons = [];

    void _loadLesson() async {
        _lessons = await LessonApi().fetchAllLessons(username);
        setState(() {});
    }

    @override
    void initState() {
        super.initState();
        _loadLesson();
    }

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Scaffold(
                appBar: CustomAppBar(label: "Admin Lessons", arrow: true),
                body: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                    itemCount: _lessons.isNotEmpty ? _lessons.length : 0,
                    itemBuilder: (BuildContext context, int ind) {
                        return _lessons.elementAt(ind).status == "Active" ?
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 10.0),
                                            child: Column(
                                                children: [
                                                    Text(_lessons.elementAt(ind).username, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer), textAlign: TextAlign.left),
                                                    Text(_lessons.elementAt(ind).teacher, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer), textAlign: TextAlign.left),
                                                    Text(
                                                        _lessons.elementAt(ind).course.length > 20 ?
                                                            "${_lessons.elementAt(ind).course.substring(0, 20)}..." :
                                                            _lessons.elementAt(ind).course,
                                                        style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer), textAlign: TextAlign.left),
                                                    Text(_lessons.elementAt(ind).date, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer), textAlign: TextAlign.left),
                                                    Text(_lessons.elementAt(ind).day, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer), textAlign: TextAlign.left),
                                                    Text("${_lessons.elementAt(ind).hour}:00 - ${_lessons.elementAt(ind).hour+1}:00", style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer), textAlign: TextAlign.left),
                                                ],
                                            ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                            child: IconButton(
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
                                                                            "${_lessons.elementAt(ind).username}\n"
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
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                        TextButton(
                                                                            onPressed: () async {
                                                                                bool res = await LessonApi().deleteLesson(_lessons.elementAt(ind).teacher, _lessons.elementAt(ind).course, _lessons.elementAt(ind).username, _lessons.elementAt(ind).date, _lessons.elementAt(ind).hour);
                                                                                if(res) {
                                                                                    Navigator.pop(context);
                                                                                    _loadLesson();
                                                                                } else {
                                                                                    Navigator.pop(context);
                                                                                }
                                                                            },
                                                                            child: Text("Yes", style: TextStyle(color: Theme.of(context).colorScheme.onTertiary,))
                                                                        ),
                                                                        TextButton(
                                                                            onPressed: () { Navigator.pop(context); },
                                                                            child: Text("No", style: TextStyle(color: Theme.of(context).colorScheme.onTertiary,))
                                                                        ),
                                                                    ],
                                                                ),
                                                            ],
                                                        )
                                                    )
                                                )
                                            ),
                                        )
                                    ],
                                ),
                            ),
                        )
                        :
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 10.0),
                                            child: Column(
                                                children: [
                                                    Text(_lessons.elementAt(ind).username, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer), textAlign: TextAlign.left),
                                                    Text(_lessons.elementAt(ind).teacher, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer), textAlign: TextAlign.left),
                                                    Text(
                                                        _lessons.elementAt(ind).course.length > 20 ?
                                                            "${_lessons.elementAt(ind).course.substring(0, 20)}..." :
                                                            _lessons.elementAt(ind).course,
                                                        style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer), textAlign: TextAlign.left),
                                                    Text(_lessons.elementAt(ind).date, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer), textAlign: TextAlign.left),
                                                    Text(_lessons.elementAt(ind).day, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer), textAlign: TextAlign.left),
                                                    Text("${_lessons.elementAt(ind).hour}:00 - ${_lessons.elementAt(ind).hour+1}:00", style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer), textAlign: TextAlign.left),
                                                ],
                                            ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                            child: _lessons.elementAt(ind).status == "Deleted" ?
                                            const Icon(
                                                CupertinoIcons.clear_thick_circled,
                                                color: Colors.red
                                            )
                                                :
                                            const Icon(
                                                Icons.check_circle,
                                                color: Colors.green
                                            )
                                        )
                                    ],
                                ),
                            ),
                        );
                    }
                ),
            )
        );
    }
}
