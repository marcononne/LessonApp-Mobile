import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Resources/userApi.dart';
import '../../Routes/routes.dart';
import '../../Views/Home/homepage_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
    CustomAppBar({Key? key, required this.label, required this.arrow}) : super(key: key);

    String label;
    bool arrow;
    final HomePageController controller = Get.find<HomePageController>();

    @override
    Size get preferredSize =>  const Size.fromHeight(50.0);

    @override
    Widget build(BuildContext context) {
        if(arrow) {
            return arrowAppBars(context);
        }
        if(label == "Customer Home Page") {
            return AppBar(
                backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                title: Text("Lesson APP", style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                centerTitle: true,
                leading: IconButton(
                    icon: Icon(Icons.account_circle_sharp, color: Theme.of(context).colorScheme.tertiaryContainer),
                    onPressed: () => controller.goToPersonalArea(Get.parameters['username'] as String),
                ),
            );
        }
        if(label == "Personal Area") {
            return AppBar(
                backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                title: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                centerTitle: true,
                leading: IconButton(
                    icon: Icon(Icons.home_sharp, color: Theme.of(context).colorScheme.tertiaryContainer),
                    onPressed: () => controller.goToCustomerHomePage(Get.parameters['username'] as String),
                ),
            );
        }
        if(label == "Admin Home Page") {
            return AppBar(
                backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                title: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                centerTitle: true,
                automaticallyImplyLeading: false,
                actions: [
                    GestureDetector(
                        onTap: () { controller.goToUserHomePage(); },
                        child: IconButton(
                            onPressed: () async {
                                String result = await UserApi().logout();
                                if(result == "Logout successful") {
                                  controller.goToUserHomePage();
                                }
                            },
                            icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.tertiaryContainer),
                        )
                    ),
                ],
            );
        }
        return AppBar(
            title: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
            backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
            centerTitle: true,
        );
    }

    Widget arrowAppBars(BuildContext context) {
        switch (label) {
            case "User Home Page":
                return AppBar(
                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    title: Text("Lesson APP", style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    actions: [
                        GestureDetector(
                            onTap: () {},
                            child: IconButton(
                                onPressed: () {
                                    Get.toNamed(Routes.loginRoute);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                                    shadowColor: Theme.of(context).colorScheme.onTertiaryContainer,
                                    side: BorderSide(
                                        width: 0.0,
                                        color: Theme.of(context).colorScheme.onTertiaryContainer
                                    )
                                ),
                                icon: Icon(Icons.login, color: Theme.of(context).colorScheme.tertiaryContainer),
                            )
                        ),
                    ],
                );
            case "Login":
                return AppBar(
                    backgroundColor: const Color(0xFFD3E4FF),
                    title: Text("Sign In", style: const TextStyle(color: Color(0xFF334863))),
                    centerTitle: true,
                    leading: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color(0xFF334863)),
                        onPressed: () => controller.goToUserHomePage()
                    )
                );
            case "Sign Up":
                return AppBar(
                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    title: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                    centerTitle: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiaryContainer),
                        onPressed: () => controller.goToLogin(),
                    )
                );
            case "Teachers":
                return AppBar(
                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    title: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                    centerTitle: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiaryContainer),
                        onPressed: () => Navigator.pop(context), /// Get.toNamed(CourseDetail)
                    )
                );
            case "Date and Time":
                return AppBar(
                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    title: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                    centerTitle: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiaryContainer),
                        onPressed: () => Navigator.pop(context), /// Get.toNamed(Teachers)
                    )
                );
            case "Recap":
                return AppBar(
                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    title: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                    centerTitle: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiaryContainer),
                        onPressed: () => Navigator.pop(context), /// Get.toNamed(Date and Time)
                    )
                );
            case "Next Lessons":
                return AppBar(
                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    title: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                    centerTitle: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiaryContainer),
                        onPressed: () => controller.goToPersonalArea(Get.parameters['username'] as String)
                    )
                );
            case "Old Lessons":
                return AppBar(
                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    title: Text("Completed Lessons", style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                    centerTitle: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiaryContainer),
                        onPressed: () => controller.goToPersonalArea(Get.parameters['username'] as String)
                    )
                );
            case "Deleted Lessons":
                return AppBar(
                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    title: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                    centerTitle: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiaryContainer),
                        onPressed: () => controller.goToPersonalArea(Get.parameters['username'] as String)
                    )
                );
            case "Admin Courses":
                return AppBar(
                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    title: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                    centerTitle: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiaryContainer),
                        onPressed: () => controller.goToAdminHome(Get.parameters['username'] as String)
                    )
                );
            case "Admin Lessons":
                return AppBar(
                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    title: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                    centerTitle: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiaryContainer),
                        onPressed: () => controller.goToAdminHome(Get.parameters['username'] as String)
                    )
                );
            case "Admin Teachers":
                return AppBar(
                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    title: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                    centerTitle: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiaryContainer),
                        onPressed: () => controller.goToAdminHome(Get.parameters['username'] as String)
                    )
                );
            default:
                return AppBar(
                    backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    title: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
                    centerTitle: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiaryContainer),
                        onPressed: () => controller.goToCustomerHomePage(Get.parameters['username'] as String)
                    )
                );
        }
    }
}
