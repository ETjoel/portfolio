import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'views/main_page.dart';
import 'views/project_detail_page.dart';
import 'views/admin_page.dart';
import 'views/login_page.dart';
import 'views/edit_project_page.dart';

class RouteConstants {
  static const String home = '/';
  static const String projects = '/projects';
  static const String about = '/about';
  static const String projectDetail = 'project';
  static const String admin = 'admin';
  static const String login = 'login';
  static const String editProject = 'edit-project';
}

GoRouter createRouter(AuthController authController) {
  return GoRouter(
    refreshListenable: authController,
    routes: [
      GoRoute(
        path: RouteConstants.home,
        name: RouteConstants.home,
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
          path: '/project/:id',
          name: RouteConstants.projectDetail,
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return ProjectDetailPage(projectId: id ?? '');
          }),
      GoRoute(
        path: '/${RouteConstants.admin}',
        name: RouteConstants.admin,
        builder: (context, state) => const AdminPage(),
        redirect: (context, state) {
          if (!authController.loggedIn) {
            return '/${RouteConstants.login}';
          }
          return null;
        },
      ),
      GoRoute(
        path: '/${RouteConstants.login}',
        name: RouteConstants.login,
        builder: (context, state) => const LoginPage(),
        redirect: (context, state) {
          if (authController.loggedIn) {
            return '/${RouteConstants.admin}';
          }
          return null;
        },
      ),
      GoRoute(
          path: '/${RouteConstants.editProject}/:id',
          name: RouteConstants.editProject,
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return EditProjectPage(projectId: id ?? '');
          }),
    ],
  );
}
