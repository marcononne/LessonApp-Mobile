import 'package:flutter/material.dart';
import '../../../Custom_widgets/General/custom_appbar.dart';
import '../../../Custom_widgets/Customer/custom_teacher_detail.dart';
import 'package:get/get.dart';

import '../../../Resources/teachersApi.dart';

class TeachersList extends StatefulWidget {
    const TeachersList({Key? key}) : super(key: key);

    @override
    State<TeachersList> createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
    String label = Get.parameters["label"] as String;

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Scaffold(
                appBar: CustomAppBar(label: "Teachers", arrow: true),
                body: FutureBuilder<List<Teacher>>(
                    future: TeachersApi().teachersAvailable(label),
                    builder: (context, snapshot) {
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                            itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                            itemBuilder: (BuildContext context, int ind) {
                                return CustomTeacherDetail(
                                    name: snapshot.data!.elementAt(ind).name,
                                    surname: snapshot.data!.elementAt(ind).surname,
                                    index: ind,
                                    label: label,
                                );
                            }
                        );
                    },
                ),
            )
        );
    }
}
