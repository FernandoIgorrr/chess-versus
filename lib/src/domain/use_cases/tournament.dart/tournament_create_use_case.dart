import '../../../data/repositories/tournament/tournament_repository.dart';

class TournamentCreateUseCase {
  TournamentCreateUseCase({
    required TournamentRepository tournamentRepository,
  }) : _tournamentRepository = tournamentRepository;

  final TournamentRepository _tournamentRepository;
  //final _log = Logger('TournamentCreateUseCase');
}
