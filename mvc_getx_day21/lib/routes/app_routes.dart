import 'package:day20_mvc_getx/view/onboarding/splash_view.dart' show SplashView;
import 'package:get/get.dart';


import '../view/home_view.dart';
import '../view/mobile_projects_view.dart';
import '../view/website_projects_view.dart';
import '../view/project_detail_view.dart';
import '../view/profile_view.dart';
import '../view/add_project_view.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String mobileProjects = '/mobile-projects';
  static const String websiteProjects = '/website-projects';
  static const String projectDetail = '/project-detail';
  static const String profile = '/profile';
  static const String addProject = '/add-project';

  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: home,
      page: () => const HomeView(),
    ),
    GetPage(
      name: mobileProjects,
      page: () => const MobileProjectsView(),
    ),
    GetPage(
      name: websiteProjects,
      page: () => const WebsiteProjectsView(),
    ),
    GetPage(
      name: projectDetail,
      page: () => const ProjectDetailView(),
    ),
    GetPage(
      name: profile,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: addProject,
      page: () => const AddProjectView(),
    ),
  ];
}