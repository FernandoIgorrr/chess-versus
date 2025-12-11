// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tournaments => 'Tournaments';

  @override
  String get deleteTournament => 'Delete tournament ?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get registerTournament => 'Register tournament';

  @override
  String get name => 'Name';

  @override
  String get tournamentName => 'Tournament name';

  @override
  String get tournamentDescription => 'Tournament description';

  @override
  String get tournamentNullDescription => 'No description';

  @override
  String get tournamentType => 'Tournament type';

  @override
  String get tournamentStartDate => 'Start date';

  @override
  String get created => 'Created';

  @override
  String get inProgress => 'In progress';

  @override
  String get finished => 'Finished';

  @override
  String get tournamentHasAlreadyEnded => 'The tournament has already ended';

  @override
  String get numberOfRounds => 'Nº of rounds';

  @override
  String get scorePerBye => 'Score per bye';

  @override
  String get notDefined => 'Not defined';

  @override
  String get notInformed => 'Not informed';

  @override
  String get activePlayers => 'Active players';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get byeInactive => 'Bye inactive';

  @override
  String get tournamentHasntStartedYet => 'The tournament hasn\'t started yet';

  @override
  String get tournamentRegisteredSuccessfully =>
      'Tournament registered successfully!';

  @override
  String get invalidData => 'Invalid data';

  @override
  String get emptyTournaments => 'There are no registered tournaments';

  @override
  String get errorWhileDeletingATournament =>
      'Error when trying to delete the tournament';

  @override
  String get successWhileDeletingATournament =>
      'Tournament deleted successfully!';

  @override
  String get score => 'Score';

  @override
  String get scoreNegativeException => 'Score can\'t be negative!';

  @override
  String get classification => 'Classification';

  @override
  String get rounds => 'Rounds';

  @override
  String get round => 'Round';

  @override
  String get result => 'Result';

  @override
  String get tournamentStarted => 'Tournament started';

  @override
  String get tournamentCantBeStarted => 'The tournament can\'t be started';

  @override
  String get tournamentCantBePaired => 'The tournament can\'t be paired';

  @override
  String get lastRoundResultsDontFilled =>
      'The results of the last round were not fully filled in.';

  @override
  String get allRoundsHaveAlreadyBeenPaired =>
      'All rounds have already been paired.';

  @override
  String get startTournament => 'Start  Tournament';

  @override
  String get theTournamentHasFinished => 'The tournament has finished';

  @override
  String get start => 'Start';

  @override
  String get table => 'Table';

  @override
  String get board => 'Board';

  @override
  String get player => 'Player';

  @override
  String get players => 'Players';

  @override
  String get thereAreNoRegisteredPlayers => 'There are no registered players';

  @override
  String get toStartTheTournamentYouNeedAtLeastThreePlayers =>
      'To start the tournament you need at least 3 players.';

  @override
  String get playerAddeddSuccessfully => 'Player added successfully!';

  @override
  String get playerNmae => 'Player name';

  @override
  String get addPlayer => 'Add player';

  @override
  String get add => 'Add';

  @override
  String get informations => 'Informations';

  @override
  String get somethingWentWrong => 'Something went wrong!';

  @override
  String get settings => 'Settings';

  @override
  String get tip => 'Tip';

  @override
  String get addResultTip => 'Tap and hold the match to add the result.';

  @override
  String get language => 'Language';

  @override
  String get switchTheme => 'Switch theme';

  @override
  String get darkMode => 'Dark mode';
}
