import 'package:financiera_milenians_app/presentation/screen/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/register_card',
      builder: (context, state) => const RegisterCardScreen(),
    )
  ]
);
