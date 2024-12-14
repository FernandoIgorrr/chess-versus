import 'package:chess_versus/src/config/local_storage.dart';
import 'package:chess_versus/src/data/repositories/player/player_raw_dto_repository_local.dart';
import 'package:chess_versus/src/data/repositories/player/player_repository.dart';
import 'package:chess_versus/src/data/repositories/theme/theme_repository.dart';
import 'package:chess_versus/src/data/repositories/tournament/tournament_repository.dart';
import 'package:chess_versus/src/data/services/theme_service.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/player_create_use_case.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/tournament_create_use_case.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

import '../data/repositories/player/player_raw_dto_repository.dart';
import '../data/repositories/player/player_repository_local.dart';
import '../data/repositories/tournament/tournament_repository_local.dart';

/// Shared providers for all configurations.
List<SingleChildWidget> _sharedProviders = [
  Provider(
    lazy: true,
    create: (context) => TournamentCreateUseCase(
      tournamentRepository: context.read(),
    ),
  ),
  Provider(
      lazy: true,
      create: (context) => PlayerCreateUseCase(
          playerRepository: context.read(),
          tournamentRepository: context.read())),
];

/// Configure dependencies for local data.
/// This dependency list uses repositories that provide local data.
/// The user is always logged in.
List<SingleChildWidget> get providersLocal {
  return [
    Provider(create: (_) => ThemeRepository(ThemeService())),
    Provider(
        create: (context) =>
            TournamentRepositoryLocal(LocalStorageKeys.kTournaments)
                as TournamentRepository),
    Provider(
      create: (_) => PlayerRawDtoRepositoryLocal(LocalStorageKeys.kPlayers)
          as PlayerRawDtoRepository,
    ),
    Provider(
      create: (context) =>
          PlayerRepositoryLocal(context.read()) as PlayerRepository,
    ),
    ..._sharedProviders,
  ];
}
