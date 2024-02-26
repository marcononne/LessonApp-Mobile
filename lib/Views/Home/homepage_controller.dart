import 'package:get/get.dart';
import '../../Routes/routes.dart';

class HomePageController extends GetxController {
    goToLogin() {
        Get.toNamed(Routes.loginRoute);
    }
    goToCustomerHomePage(String username) {
        Get.toNamed(Routes.customerHomeRoute, parameters: {"username": username});
    }
    goToUserHomePage() {
        Get.toNamed(Routes.userHomePageRoute);
    }
    goToCourseDetail(String username, String label, String description) {
        Get.toNamed(Routes.courseDetailRoute, parameters: {"username": username, "label": label, "description": description});
    }
    goToTeachersList(String username, String label) {
        Get.toNamed(Routes.teachersListRoute, parameters: {"username": username, "label": label});
    }
    goToDateTimeSelector(String username, String label, String name, String surname) {
        Get.toNamed(Routes.dateTimeSelectorRoute, parameters: {"username": username, "label": label, "name": name, "surname": surname});
    }
    goToRecap(String username, String label, String name, String surname, DateTime date, String hour) {
        Get.toNamed(Routes.recapRoute, parameters: {"username": username, "label": label, "name": name, "surname": surname, "date": date.toString(), "hour": hour});
    }
    goToPersonalArea(String username) {
        Get.toNamed(Routes.personalAreaRoute, parameters: {"username": username});
    }
    goToAdminHome(String username) {
        Get.toNamed(Routes.adminHomeRoute, parameters: {"username": username});
    }
    goToAdminCourse(String username) {
        Get.toNamed(Routes.adminCoursesRoute, parameters: {"username": username});
    }
    goToAdminLessons(String username) {
        Get.toNamed(Routes.adminLessonsRoute, parameters: {"username": username});
    }
    goToAdminTeachers(String username) {
        Get.toNamed(Routes.adminTeachersRoute, parameters: {"username": username});
    }
    goToAdminTeachersPerCourse(String username, String course) {
        Get.toNamed(Routes.adminTeachersPerCourse, parameters: {"username": username, "course": course});
    }
    goToNextLessonPage(String username) {
        Get.toNamed(Routes.nextLessonsRoute, parameters: {"username": username});
    }
    goToOldLessonsPage(String username) {
      Get.toNamed(Routes.oldLessonsRoute, parameters: {"username": username});
    }
    goToDeletedLessonsPage(String username) {
        Get.toNamed(Routes.deletedLessonsRoute, parameters: {"username": username});
    }
}
