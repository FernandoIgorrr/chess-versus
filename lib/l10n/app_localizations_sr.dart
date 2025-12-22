// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get tournaments => 'Турнири';

  @override
  String get deleteTournament => 'Избрисати турнир?';

  @override
  String get deleteRound => 'Obriši rundu?';

  @override
  String get cancel => 'Одустани';

  @override
  String get delete => 'Избриши';

  @override
  String get registerTournament => 'Региструј турнир';

  @override
  String get name => 'Име';

  @override
  String get tournamentName => 'Назив турнира';

  @override
  String get tournamentDescription => 'Опис турнира';

  @override
  String get tournamentNullDescription => 'Без описа';

  @override
  String get tournamentType => 'Тип турнира';

  @override
  String get tournamentStartDate => 'Датум почетка';

  @override
  String get created => 'Направљено';

  @override
  String get inProgress => 'У току';

  @override
  String get finished => 'Завршено';

  @override
  String get tournamentHasAlreadyEnded => 'Турнир је већ завршен';

  @override
  String get numberOfRounds => 'Број рунди';

  @override
  String get scorePerBye => 'Поени по бај-у';

  @override
  String get notDefined => 'Није дефинисано';

  @override
  String get notInformed => 'Није обавештено';

  @override
  String get activePlayers => 'Активни играчи';

  @override
  String get active => 'Активан';

  @override
  String get inactive => 'Неактиван';

  @override
  String get byeInactive => 'Бај неактиван';

  @override
  String get tournamentHasntStartedYet => 'Турнир још није почео';

  @override
  String get tournamentRegisteredSuccessfully => 'Турнир успешно регистрован!';

  @override
  String get invalidData => 'Неважећи подаци';

  @override
  String get emptyTournaments => 'Нема регистрованих турнира';

  @override
  String get errorWhileDeletingATournament =>
      'Грешка приликом покушаја брисања турнира';

  @override
  String get successWhileDeletingATournament => 'Турнир успешно избрисан!';

  @override
  String get score => 'Поени';

  @override
  String get scoreNegativeException => 'Поени не могу бити негативни!';

  @override
  String get classification => 'Класификација';

  @override
  String get rounds => 'Рунде';

  @override
  String get round => 'Рунда';

  @override
  String get result => 'Резултат';

  @override
  String get tournamentStarted => 'Турнир почео';

  @override
  String get tournamentCantBeStarted => 'Турнир не може бити покренут';

  @override
  String get tournamentCantBePaired => 'Турнир не може бити упарен';

  @override
  String get lastRoundResultsDontFilled =>
      'Резултати последње рунде нису у потпуности попуњени.';

  @override
  String get allRoundsHaveAlreadyBeenPaired => 'Све рунде су већ упарене.';

  @override
  String get startTournament => 'Покрени турнир';

  @override
  String get theTournamentHasFinished => 'Турнир је завршен';

  @override
  String get start => 'Покрени';

  @override
  String get table => 'Табела';

  @override
  String get board => 'Табла';

  @override
  String get player => 'Играч';

  @override
  String get players => 'Играчи';

  @override
  String get thereAreNoRegisteredPlayers => 'Нема регистрованих играча';

  @override
  String get toStartTheTournamentYouNeedAtLeastThreePlayers =>
      'Да бисте започели турнир, потребна су вам најмање 3 играча.';

  @override
  String get playerAddeddSuccessfully => 'Играч успешно додат!';

  @override
  String get playerNmae => 'Име играча';

  @override
  String get addPlayer => 'Додај играча';

  @override
  String get add => 'Додај';

  @override
  String get informations => 'Информације';

  @override
  String get somethingWentWrong => 'Нешто је пошло наопако!';

  @override
  String get settings => 'Подешавања';

  @override
  String get tip => 'Савет';

  @override
  String get addResultTip =>
      'Додирните и задржите утакмицу да бисте додали резултат.';

  @override
  String get deleteRoundTip =>
      'Додирните и задржите рунду да бисте је избрисали.';

  @override
  String get language => 'Језик';

  @override
  String get switchTheme => 'Промени тему';

  @override
  String get darkMode => 'Тамни режим';
}
