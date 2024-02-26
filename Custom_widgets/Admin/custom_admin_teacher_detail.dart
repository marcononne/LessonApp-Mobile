import 'package:flutter/material.dart';

class CustomAdminTeacherDetail extends StatefulWidget {
    const CustomAdminTeacherDetail({Key? key, required this.name, required this.surname, required this.status}) : super(key: key);

    final String name;
    final String surname;
    final bool status;

    @override
    State<CustomAdminTeacherDetail> createState() => _CustomAdminTeacherDetailState();
}

class _CustomAdminTeacherDetailState extends State<CustomAdminTeacherDetail> {

    @override
    Widget build(BuildContext context) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget> [
                            Expanded(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        Icon(
                                            Icons.circle,
                                            color: widget.status ? Colors.greenAccent: Colors.red,
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
