import 'package:chess_versus/src/routing/routes.dart';
import 'package:chess_versus/src/ui/home/view_models/home_view_model.dart';
import 'package:chess_versus/src/ui/tournament/view_models/tournament_page_view_view_model.dart';
import 'package:chess_versus/src/ui/tournament/view_models/tournament_view_model.dart';
import 'package:chess_versus/src/ui/tournament/view_models/players/players_view_model.dart';
import 'package:chess_versus/src/ui/tournament/widgets/tournament_page.dart';
import 'package:flutter/material.dart';
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
              final tournamentViewModel = TournamentViewModel(
                tournamentRepository: context.read(),
                playerRepository: context.read(),
                roundRepository: context.read(),
                matchRepository: context.read(),
              );
              final playersViewModel =
                  PlayersViewModel(playerRepository: context.read());
              final pageViewViewModel =
                  TournamentPageViewViewModel(PageController(initialPage: 3));
              return TournamentPage(
                tournamentViewModel: tournamentViewModel,
                tournamentPageViewViewModel: pageViewViewModel,
                playersViewModel: playersViewModel,
              );
            },
            routes: [
              GoRoute(
                path: ":id",
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  final tournamentViewModel = TournamentViewModel(
                      tournamentRepository: context.read(),
                      playerRepository: context.read(),
                      roundRepository: context.read(),
                      matchRepository: context.read());

                  final pageViewViewModel = TournamentPageViewViewModel(
                      PageController(initialPage: 3));
                  final playersViewModel =
                      PlayersViewModel(playerRepository: context.read());
                  tournamentViewModel.getTournament(id);
                  return TournamentPage(
                    tournamentViewModel: tournamentViewModel,
                    tournamentPageViewViewModel: pageViewViewModel,
                    playersViewModel: playersViewModel,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ]);
