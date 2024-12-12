import 'package:chess_versus/src/routing/routes.dart';
import 'package:chess_versus/src/ui/home/view_models/home_view_model.dart';
import 'package:chess_versus/src/ui/tournament/view_models/tournament_view_model.dart';
import 'package:chess_versus/src/ui/tournament/widgets/tournament_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../ui/home/widgets/home_page.dart';

GoRouter router() =>
    GoRouter(initialLocation: Routes.home, debugLogDiagnostics: true, routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          final viewModel = HomeViewModel(
            tournamentRepository: context.read(),
          );
          return HomePage(viewModel: viewModel);
        },
        routes: [
          GoRoute(
            path: Routes.tournamentRelative,
            builder: (context, state) {
              final viewModel = TournamentViewModel(
                tournamentRepository: context.read(),
              );

              return TournamentPage(viewModel: viewModel);
            },
            routes: [
              GoRoute(
                path: ":id",
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  final viewModel =
                      TournamentViewModel(tournamentRepository: context.read());

                  viewModel.getTournament(id);
                  return TournamentPage(viewModel: viewModel);
                },
              ),
            ],
          ),
        ],
      ),
    ]);
