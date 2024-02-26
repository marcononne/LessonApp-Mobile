import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'homepage_controller.dart';
import '../../Resources/my_strings.dart';
import '../../Custom_widgets/General/custom_appbar.dart';

class HomePage extends StatelessWidget{

    final homePageController = Get.find<HomePageController>();

    @override
    Widget build(BuildContext context) {
        return SafeArea(child:
            Scaffold(
                appBar: CustomAppBar(label: "Lesson APP", arrow: false),
                body:
                    IntroductionScreen(
                        dotsDecorator: DotsDecorator(
                            activeColor : Theme.of(context).colorScheme.onBackground,
                        ),
                        pages: [
                            PageViewModel(
                                title: " ",
                                bodyWidget: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 150.0, horizontal: 20.0),
                                    child: Text(
                                        My_Strings.description1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 25,
                                            color: Theme.of(context).colorScheme.onBackground
                                        ),
                                    )
                                ),
                            ),
                            PageViewModel(
                                title: " ",
                                bodyWidget: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                            Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 3.0),
                                                child: Text(
                                                    "You will be able to book a lesson of any course, from Monday to Friday!",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 25,
                                                        color: Theme.of(context).colorScheme.onBackground
                                                    ),
                                                ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 3.0),
                                                child: Text(
                                                    "For each course you can book a 1 hour lesson between 15:00 and 19:00.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 25,
                                                        color: Theme.of(context).colorScheme.onBackground
                                                    ),
                                                ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 3.0),
                                                child: Text(
                                                    "Now you know everything you need! Get started",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 25,
                                                        color: Theme.of(context).colorScheme.onBackground
                                                    )
                                                ),
                                            )
                                        ],
                                    )
                                ),
                            ),
                        ],
                        //onDone scrivo dentro cosa devo fare quando clicco su onDone
                        onDone: () => homePageController.goToUserHomePage(),
                        onSkip: () => homePageController.goToUserHomePage(),
                        showBackButton: false,
                        showSkipButton: true,
                        showDoneButton: true,
                        next: Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.onBackground),
                        skip: Text("Skip", style: TextStyle(color: Theme.of(context).colorScheme.onBackground)), //skip button
                        done: Text("Done", style: TextStyle(color: Theme.of(context).colorScheme.onBackground)), //done all'ultima pagina
                    )
                )
        ); //introductionScreen e' la libreria scaricata
    }
}
