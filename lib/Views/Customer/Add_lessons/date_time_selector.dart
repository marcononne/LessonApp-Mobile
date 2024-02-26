import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Custom_widgets/General/custom_appbar.dart';
import '../../../Resources/timeslotsApi.dart';
import '../../Home/homepage_controller.dart';
import 'package:get/get.dart';
import '../../../Resources/color_shemes.dart';


class DateTimeSelector extends StatefulWidget {
    const DateTimeSelector({Key? key}) : super(key: key);

    @override
    State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
    DateTime _selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
    int calls = 0;
    late DateTime _initialDate;
    DateFormat df = DateFormat("dd/MM/yyyy");
    String dateHint = "Date";
    String slotHint = "Time slot";
    HomePageController controller = HomePageController();
    String label = Get.parameters["label"] as String;
    String name = Get.parameters["name"] as String;
    String surname = Get.parameters["surname"] as String;
    String username = Get.parameters["username"] as String;
    List<Slots> _slots = [];
    Slots _timeSlot = Slots(start: -1, end: -1);

    void setInitialDate() {
        setState(() {
            if(DateTime.now().weekday == 6) {
                _initialDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2);
            } else if(DateTime.now().weekday == 7) {
                _initialDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
            } else {
                _initialDate = DateTime.now();
            }
            calls = 1;
        });
    }

    void getData(BuildContext context) async {
        if(calls == 0) {
            setInitialDate();
        }
        var fDate = await showDatePicker(
            context: context,
            initialDate: _initialDate,
            firstDate: DateTime.now(),
            lastDate: DateTime(2030),
            selectableDayPredicate: (DateTime val) =>
                val.weekday == 6 || val.weekday == 7 ? false : true,
            builder: (BuildContext context, Widget? child) {
                return Theme(
                    data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light().copyWith(
                            background: darkColorScheme.onTertiary,
                            primary: darkColorScheme.tertiary,
                            onPrimary: darkColorScheme.onTertiary,
                        ),
                    ),
                    child: child!,
                );
            },
        );
        if(fDate != null) {
            setState(() {
                _selectedDate = fDate;
                _initialDate = _selectedDate;
                dateHint = df.format(_selectedDate);
                _fetchSlots();
            });
        }
    }

    void setTimeSlot(Slots value) {
        setState(() {
            _timeSlot = value;
        });
    }

    Future<void> _fetchSlots() async {
        try {
            List<Slots> slots = await TimeSlotsApi().getTimeSlots(name, surname, _selectedDate.toString().replaceAll("00:00:00.000", "").removeAllWhitespace);
            setState(() {
                if(slots.isNotEmpty) {
                    setState(() {
                        slotHint = "Time slot";
                    });
                    _slots = slots;
                } else {
                    setState(() {
                        slotHint = "No slots available";
                    });
                }
            });
        } on Exception {
            setState(() {
                slotHint = "No slots available";
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Scaffold(
                appBar: CustomAppBar(label: "Date and Time", arrow: true),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                    Expanded(
                                        child: InkWell(
                                            onTap: () {
                                                FocusScope.of(context).requestFocus(FocusNode());
                                                getData(context);
                                            },
                                            child: IgnorePointer(
                                                child: TextFormField(
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                        hintText: dateHint,
                                                        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              width: 1.0,
                                                              color: Theme.of(context).colorScheme.secondaryContainer,
                                                            )
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              width: 1.0,
                                                              color: Theme.of(context).colorScheme.secondaryContainer,
                                                            )
                                                        ),
                                                    ),
                                                ),

                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                            child: DropdownButtonFormField<Slots>(
                                hint: Text(slotHint, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.0,
                                            color: Theme.of(context).colorScheme.secondaryContainer,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.0,
                                            color: Theme.of(context).colorScheme.secondaryContainer,
                                        )
                                    ),
                                ),
                                items: _slots.map((slot) {
                                    return DropdownMenuItem(
                                        value: slot,
                                        child: Text("${slot.start}:00 - ${slot.end}:00", textAlign: TextAlign.center,),
                                    );
                                }).toList(),
                                onChanged: (value) {
                                    setState(() {
                                        setTimeSlot(value!);
                                    });
                                },
                                validator: (value) {
                                    if(value!.start == -1) {
                                        return "Select a time slot";
                                    }
                                    return null;
                                },
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                ),
                                onPressed: () {
                                    if(_timeSlot.start != -1 && dateHint != "Date") {
                                        controller.goToRecap(username, label, name, surname, _selectedDate, "${_timeSlot.start}");
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
                                                                "You have to select both the date and the time slot to procede",
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
                                child: Text("Recap", style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer))
                            ),
                        )
                    ],
                ),
            ),
        );
    }
}
