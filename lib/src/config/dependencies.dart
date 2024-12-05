import 'package:chess_versus/src/domain/use_cases/tournament.dart/tournament_create_use_case.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

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
    ..._sharedProviders,
  ];
}
