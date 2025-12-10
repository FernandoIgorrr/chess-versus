import 'package:chess_versus/src/domain/use_cases/tournament/tournament_match_result_update_use_case.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/tournament_pairing_use_case.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/tournament_delete_use_case.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/tournament_load_use_case.dart';
import 'package:chess_versus/src/domain/use_cases/tournament/tournament_update_use_case.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

import '../data/repositories/match/match_raw_dto_repository.dart';
import '../data/repositories/match/match_raw_dto_repository_local.dart';
import '../data/repositories/match/match_repository.dart';
import '../data/repositories/match/match_repository_local.dart';
import '../data/repositories/player/player_raw_dto_repository.dart';
import '../data/repositories/player/player_raw_dto_repository_local.dart';
import '../data/repositories/player/player_repository.dart';
import '../data/repositories/player/player_repository_local.dart';
import '../data/repositories/round/round_raw_dto_repository.dart';
import '../data/repositories/round/round_raw_dto_repository_local.dart';
import '../data/repositories/round/round_repository.dart';
import '../data/repositories/round/round_repository_local.dart';
import '../data/repositories/theme/theme_repository.dart';
import '../data/repositories/tournament/tournament_repository.dart';
import '../data/repositories/tournament/tournament_repository_local.dart';
import '../data/services/theme_service.dart';
import '../domain/use_cases/tournament/player_create_use_case.dart';
import '../domain/use_cases/tournament/tournament_create_use_case.dart';
import 'local_storage.dart';

/// Shared providers for all configurations.
List<SingleChildWidget> _sharedProviders = [
  Provider(
    lazy: true,
    create: (context) =>
        TournamentCreateUseCase(tournamentRepository: context.read()),
  ),
  Provider(
    lazy: true,
    create: (context) => PlayerCreateUseCase(
      playerRepository: context.read(),
      tournamentRepository: context.read(),
    ),
  ),
  Provider(
    lazy: true,
    create: (context) => TournamentLoadUseCase(
      tournamentRepository: context.read(),
      playerRepository: context.read(),
      roundRepository: context.read(),
      matchRepository: context.read(),
    ),
  ),

  Provider(
    lazy: true,
    create: (context) => TournamentUpdateUseCase(
      tournamentRepository: context.read(),
      playerRepository: context.read(),
      roundRepository: context.read(),
      matchRepository: context.read(),
    ),
  ),
  Provider(
    lazy: true,
    create: (context) => TournamentPairingUseCase(
      tournamentRepository: context.read(),
      playerRepository: context.read(),
      matchRepository: context.read(),
      roundRepository: context.read(),
      tournamentUpdateUseCase: context.read(),
    ),
  ),
  Provider(
    lazy: true,
    create: (context) => TournamentMatchResultUpdateUseCase(
      matchRepository: context.read(),
      playerRepository: context.read(),
    ),
  ),
  Provider(
    lazy: true,
    create: (context) =>
        TournamentDeleteUseCase(tournamentRepository: context.read()),
  ),
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
              as TournamentRepository,
    ),
    Provider(
      create: (_) =>
          PlayerRawDtoRepositoryLocal(LocalStorageKeys.kPlayers)
              as PlayerRawDtoRepository,
    ),
    Provider(
      create: (context) =>
          PlayerRepositoryLocal(context.read()) as PlayerRepository,
    ),
    Provider(
      create: (_) =>
          RoundRawDtoRepositoryLocal(LocalStorageKeys.kRounds)
              as RoundRawDtoRepository,
    ),
    Provider(
      create: (context) =>
          RoundRepositoryLocal(context.read()) as RoundRepository,
    ),
    Provider(
      create: (_) =>
          MatchRawDtoRepositoryLocal(LocalStorageKeys.kMatches)
              as MatchRawDtoRepository,
    ),
    Provider(
      create: (context) =>
          MatchRepositoryLocal(context.read()) as MatchRepository,
    ),
    ..._sharedProviders,
  ];
}
