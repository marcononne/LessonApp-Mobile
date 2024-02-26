import 'package:get/get.dart';
import '../Views/Customer/Personal_Area/next_lessons.dart';
import '../Views/Customer/Personal_Area/old_lessons.dart';
import '../Views/Customer/Personal_Area/deleted_lessons.dart';
import '../Views/Admin/admin_teachers_per_course.dart';
import '../Views/Home/homepage.dart';
import '../Views/Home/user_home.dart';
import '../Views/Home/homepage_bindings.dart';
import '../Views/Input_views/Login/login.dart';
import '../Views/Customer/Add_lessons/customer_home.dart';
import '../Views/Customer/Add_lessons/course_detail.dart';
import '../Views/Customer/Add_lessons/teachers_list.dart';
import '../Views/Customer/Add_lessons/date_time_selector.dart';
import '../Views/Customer/Add_lessons/recap.dart';
import '../Views/Customer/Personal_Area/personal_area.dart';
import '../Views/Admin/admin_home.dart';
import '../Views/Admin/admin_courses.dart';
import '../Views/Admin/admin_lessons.dart';
import '../Views/Admin/admin_teachers.dart';

class Routes {

    static const String homepageRoute = '/onBoardingPage';
    static const String userHomePageRoute = '/user_home';
    static const String loginRoute = '/login';
    static const String customerHomeRoute = '/customer_home';
    static const String courseDetailRoute = '/course_detail';
    static const String teachersListRoute = '/teachers_list';
    static const String dateTimeSelectorRoute = '/date_time_selector';
    static const String recapRoute = '/recap';
    static const String personalAreaRoute = '/personal_area';
    static const String adminHomeRoute = '/admin_home';
    static const String adminCoursesRoute = '/admin_courses';
    static const String adminLessonsRoute = '/admin_lessons';
    static const String adminTeachersRoute = '/admin_teachers';
    static const String adminTeachersPerCourse = '/admin_teachers_per_course';
    static const String nextLessonsRoute = '/next_lessons';
    static const String oldLessonsRoute = '/old_lessons';
    static const String deletedLessonsRoute = '/deleted_lessons';

    static List<GetPage> pages = [
        GetPage(
            name: homepageRoute,
            page: () => HomePage(), //metodo
            binding: HomePageBindings(),
        ),
        GetPage(
            name: loginRoute,
            page: () => const Login(), //metodo
            binding: HomePageBindings(),
        ),
        GetPage(
            name: adminHomeRoute,
            page: () => const AdminHome(), //metodo
            binding: HomePageBindings(),
        ),
        GetPage(
            name: customerHomeRoute,
            page: () => CustomerHome(), //metodo
            binding: HomePageBindings(),
        ),
        GetPage(
            name: userHomePageRoute,
            page: () => const UserHome(), //metodo
            binding: HomePageBindings(),
        ),
        GetPage(
            name: courseDetailRoute,
            page: () => CourseDetail(label: Get.parameters["label"]!, description: Get.parameters["description"]!), //metodo
            binding: HomePageBindings(),
        ),
        GetPage(
            name: teachersListRoute,
            page: () => const TeachersList(),
            binding: HomePageBindings()
        ),
        GetPage(
            name: dateTimeSelectorRoute,
            page: () => const DateTimeSelector(),
            binding: HomePageBindings()
        ),
        GetPage(
            name: recapRoute,
            page: () => const Recap(),
            binding: HomePageBindings()
        ),
        GetPage(
            name: personalAreaRoute,
            page: () => const PersonalArea(),
            binding: HomePageBindings()
        ),
        GetPage(
            name: adminCoursesRoute,
            page: () => const AdminCourse(),
            binding: HomePageBindings()
        ),
        GetPage(
            name: adminLessonsRoute,
            page: () => const AdminLessons(),
            binding: HomePageBindings()
        ),
        GetPage(
            name: adminTeachersRoute,
            page: () => const AdminTeachers(),
            binding: HomePageBindings()
        ),
        GetPage(
            name: adminTeachersPerCourse,
            page: () => const AdminTeachersPerCourse(),
            binding: HomePageBindings()
        ),
        GetPage(
            name: nextLessonsRoute,
            page: () => const NextLessons(),
            binding: HomePageBindings()
        ),
        GetPage(
            name: oldLessonsRoute,
            page: () => const OldLessons(),
            binding: HomePageBindings()
        ),
        GetPage(
            name: deletedLessonsRoute,
            page: () => const DeletedLessons(),
            binding: HomePageBindings()
        ),
    ];
}
