import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Custom_widgets/General/custom_appbar.dart';
import '../../Resources/teachersApi.dart';

class AdminTeachers extends StatefulWidget {
    const AdminTeachers({Key? key}) : super(key: key);

    @override
    State<AdminTeachers> createState() => _AdminTeachersState();
}

class _AdminTeachersState extends State<AdminTeachers> {
    String username = Get.parameters["username"] as String;

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Scaffold(
                appBar: CustomAppBar(label: "Admin Teachers", arrow: true),
                body: FutureBuilder<List<Teacher>>(
                    future: TeachersApi().getAllTeachers(username),
                    builder: (context, snapshot) {
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                            itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                            itemBuilder: (BuildContext context, int ind) {
                                return Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.secondaryContainer,
                                            border: Border.all(
                                                width: 1.5,
                                                color: Theme.of(context).colorScheme.onSecondaryContainer
                                            ),
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget> [
                                                    Expanded(
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                                Text(
                                                                    "${snapshot.data!.elementAt(ind).name} ${snapshot.data!.elementAt(ind).surname}",
                                                                    style: TextStyle(
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Theme.of(context).colorScheme.onSecondaryContainer
                                                                    ),
                                                                    textAlign: TextAlign.center,
                                                                ),
                                                                Icon(
                                                                    Icons.circle,
                                                                    color: snapshot.data!.elementAt(ind).status ?
                                                                    Colors.greenAccent: Colors.red,
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
                        );
                    },
                ),
            )
        );
    }
}
