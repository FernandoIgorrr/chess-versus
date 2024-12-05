import 'package:chess_versus/src/routing/routes.dart';
import 'package:chess_versus/src/ui/home/view_models/home_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../ui/home/widgets/home_screen.dart';

GoRouter router() =>
    GoRouter(initialLocation: Routes.home, debugLogDiagnostics: true, routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          final viewModel = HomeViewModel(
            tournamentRepository: context.read(),
          );
          return HomeScreen(viewModel: viewModel);
        },
      ),
    ]);
