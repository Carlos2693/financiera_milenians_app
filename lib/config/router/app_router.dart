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
      path: '/register_card/:id',
      builder: (context, state) {
        final cardId = state.pathParameters['id'] ?? 'no-id';
        return ManageCardScreen(cardId : cardId);
      }
    )
  ]
);
