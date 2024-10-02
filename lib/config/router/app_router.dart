import 'package:go_router/go_router.dart';

import 'package:financiera_milenians_app/presentation/screen/screens.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    )
  ]
);