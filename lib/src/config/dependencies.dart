import 'package:chess_versus/src/config/local_storage.dart';
import 'package:chess_versus/src/data/repositories/theme/theme_repository.dart';
import 'package:chess_versus/src/data/repositories/tournament/tournament_repository.dart';
import 'package:chess_versus/src/data/services/theme_service.dart';
import 'package:chess_versus/src/domain/use_cases/tournament.dart/tournament_create_use_case.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

import '../data/repositories/tournament/tournament_repository_local.dart';

/// Shared providers for all configurations.
List<SingleChildWidget> _sharedProviders = [
  Provider(
    lazy: true,
    create: (context) => TournamentCreateUseCase(
      tournamentRepository: context.read(),
    ),
  ),
];

/// Configure dependencies for local data.
/// This dependency list uses repositories that provide local data.
/// The user is always logged in.
List<SingleChildWidget> get providersLocal {
  return [
    Provider(create: (_) => ThemeRepository(ThemeService())),
    // ChangeNotifierProvider(
    // create: (_) => ThemeSwitchViewModel(ThemeRepository(ThemeService()))),
    Provider(
        create: (context) =>
            TournamentRepositoryLocal(LocalStorageKeys.kTournaments)
                as TournamentRepository),
    ..._sharedProviders,
  ];
}
