import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Custom_widgets/General/custom_appbar.dart';
import '../../../Resources/lessonApi.dart';
import '../../Home/homepage_controller.dart';

class DeletedLessons extends StatefulWidget {
    const DeletedLessons({Key? key}) : super(key: key);

    @override
    State<DeletedLessons> createState() => _DeletedLessons();
}

class _DeletedLessons extends State<DeletedLessons> {
    final HomePageController controller = Get.find<HomePageController>();
    String username = Get.parameters['username'] as String;
    List<Lesson> _lessons = [];

    void _loadLesson() async {
        _lessons = await LessonApi().fetchUserLessons(username, "Deleted");
        if(_lessons == null)
            _lessons = [];
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
                label: "Deleted Lessons",
                arrow: true,
            ),
            body: _lessons.isNotEmpty ?
            ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.5),
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
                                            children: [
                                                Text(_lessons.elementAt(ind).teacher, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)),
                                                Text(
                                                    _lessons.elementAt(ind).course.length > 30 ?
                                                        "${_lessons.elementAt(ind).course.substring(0, 30)}..." :
                                                        _lessons.elementAt(ind).course,
                                                    style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)),
                                                Text(_lessons.elementAt(ind).date, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)),
                                                Text(_lessons.elementAt(ind).day, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)),
                                                Text("${_lessons.elementAt(ind).hour}:00 - ${_lessons.elementAt(ind).hour+1}:00", style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer))
                                            ],
                                        ),
                                    ),
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
                            "$username, you do not have any deleted lessons",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground),
                        ),
                    ),
                ],
            ),
        );
    }
}
