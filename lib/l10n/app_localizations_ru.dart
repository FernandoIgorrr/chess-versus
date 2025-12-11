// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get tournaments => 'Турниры';

  @override
  String get deleteTournament => 'Удалить турнир?';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get registerTournament => 'Зарегистрировать турнир';

  @override
  String get name => 'Имя';

  @override
  String get tournamentName => 'Название турнира';

  @override
  String get tournamentDescription => 'Описание турнира';

  @override
  String get tournamentNullDescription => 'Без описания';

  @override
  String get tournamentType => 'Тип турнира';

  @override
  String get tournamentStartDate => 'Дата начала';

  @override
  String get created => 'Создан';

  @override
  String get inProgress => 'В процессе';

  @override
  String get finished => 'Завершён';

  @override
  String get tournamentHasAlreadyEnded => 'Турнир уже завершён';

  @override
  String get numberOfRounds => 'Количество раундов';

  @override
  String get scorePerBye => 'Очки за бай';

  @override
  String get notDefined => 'Не определено';

  @override
  String get notInformed => 'Не указано';

  @override
  String get activePlayers => 'Активные игроки';

  @override
  String get active => 'Активный';

  @override
  String get inactive => 'Неактивный';

  @override
  String get byeInactive => 'Бай неактивен';

  @override
  String get tournamentHasntStartedYet => 'Турнир ещё не начался';

  @override
  String get tournamentRegisteredSuccessfully =>
      'Турнир успешно зарегистрирован!';

  @override
  String get invalidData => 'Неверные данные';

  @override
  String get emptyTournaments => 'Нет зарегистрированных турниров';

  @override
  String get errorWhileDeletingATournament =>
      'Ошибка при попытке удалить турнир';

  @override
  String get successWhileDeletingATournament => 'Турнир успешно удалён!';

  @override
  String get score => 'Счёт';

  @override
  String get scoreNegativeException => 'Счёт не может быть отрицательным!';

  @override
  String get classification => 'Классификация';

  @override
  String get rounds => 'Раунды';

  @override
  String get round => 'Раунд';

  @override
  String get result => 'Результат';

  @override
  String get tournamentStarted => 'Турнир начался';

  @override
  String get tournamentCantBeStarted => 'Турнир не может быть начат';

  @override
  String get tournamentCantBePaired => 'Турнир не может быть спарен';

  @override
  String get lastRoundResultsDontFilled =>
      'Результаты последнего раунда не заполнены полностью.';

  @override
  String get allRoundsHaveAlreadyBeenPaired => 'Все раунды уже спарены.';

  @override
  String get startTournament => 'Начать турнир';

  @override
  String get theTournamentHasFinished => 'Турнир завершён';

  @override
  String get start => 'Начать';

  @override
  String get table => 'Таблица';

  @override
  String get board => 'Доска';

  @override
  String get player => 'Игрок';

  @override
  String get players => 'Игроки';

  @override
  String get thereAreNoRegisteredPlayers => 'Нет зарегистрированных игроков';

  @override
  String get toStartTheTournamentYouNeedAtLeastThreePlayers =>
      'Чтобы начать турнир, вам нужно как минимум 3 игрока.';

  @override
  String get playerAddeddSuccessfully => 'Игрок успешно добавлен!';

  @override
  String get playerNmae => 'Имя игрока';

  @override
  String get addPlayer => 'Добавить игрока';

  @override
  String get add => 'Добавить';

  @override
  String get informations => 'Информация';

  @override
  String get somethingWentWrong => 'Что-то пошло не так!';

  @override
  String get settings => 'Настройки';

  @override
  String get tip => 'Подсказка';

  @override
  String get addResultTip =>
      'Нажмите и удерживайте матч, чтобы добавить результат.';

  @override
  String get language => 'Язык';

  @override
  String get switchTheme => 'Сменить тему';

  @override
  String get darkMode => 'Тёмный режим';
}
