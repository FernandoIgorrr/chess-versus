// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get tournaments => 'Turnieje';

  @override
  String get deleteTournament => 'Usunąć turniej?';

  @override
  String get deleteRound => 'Usunąć rundę?';

  @override
  String get cancel => 'Anuluj';

  @override
  String get delete => 'Usuń';

  @override
  String get registerTournament => 'Zarejestruj turniej';

  @override
  String get name => 'Nazwa';

  @override
  String get tournamentName => 'Nazwa turnieju';

  @override
  String get tournamentDescription => 'Opis turnieju';

  @override
  String get tournamentNullDescription => 'Brak opisu';

  @override
  String get tournamentType => 'Typ turnieju';

  @override
  String get tournamentStartDate => 'Data rozpoczęcia';

  @override
  String get created => 'Utworzono';

  @override
  String get inProgress => 'W trakcie';

  @override
  String get finished => 'Zakończono';

  @override
  String get tournamentHasAlreadyEnded => 'Turniej już się zakończył';

  @override
  String get numberOfRounds => 'Liczba rund';

  @override
  String get scorePerBye => 'Wynik za pauzę';

  @override
  String get notDefined => 'Nie zdefiniowano';

  @override
  String get notInformed => 'Nie podano informacji';

  @override
  String get activePlayers => 'Aktywni gracze';

  @override
  String get active => 'Aktywny';

  @override
  String get inactive => 'Nieaktywny';

  @override
  String get byeInactive => 'Pauza nieaktywna';

  @override
  String get tournamentHasntStartedYet => 'Turniej jeszcze się nie rozpoczął';

  @override
  String get tournamentRegisteredSuccessfully =>
      'Turniej zarejestrowany pomyślnie!';

  @override
  String get invalidData => 'Nieprawidłowe dane';

  @override
  String get emptyTournaments => 'Nie ma zarejestrowanych turniejów';

  @override
  String get errorWhileDeletingATournament =>
      'Błąd podczas próby usunięcia turnieju';

  @override
  String get successWhileDeletingATournament => 'Turniej usunięty pomyślnie!';

  @override
  String get score => 'Wynik';

  @override
  String get scoreNegativeException => 'Wynik nie może być ujemny!';

  @override
  String get classification => 'Klasyfikacja';

  @override
  String get rounds => 'Rundy';

  @override
  String get round => 'Runda';

  @override
  String get result => 'Wynik';

  @override
  String get tournamentStarted => 'Turniej rozpoczęty';

  @override
  String get tournamentCantBeStarted => 'Nie można rozpocząć turnieju';

  @override
  String get tournamentCantBePaired => 'Nie można sparować turnieju';

  @override
  String get lastRoundResultsDontFilled =>
      'Wyniki ostatniej rundy nie zostały w pełni uzupełnione.';

  @override
  String get allRoundsHaveAlreadyBeenPaired =>
      'Wszystkie rundy zostały już sparowane.';

  @override
  String get startTournament => 'Rozpocznij turniej';

  @override
  String get theTournamentHasFinished => 'Turniej się zakończył';

  @override
  String get start => 'Start';

  @override
  String get table => 'Tabela';

  @override
  String get board => 'Plansza';

  @override
  String get player => 'Gracz';

  @override
  String get players => 'Gracze';

  @override
  String get thereAreNoRegisteredPlayers => 'Nie ma zarejestrowanych graczy';

  @override
  String get toStartTheTournamentYouNeedAtLeastThreePlayers =>
      'Aby rozpocząć turniej, potrzebujesz co najmniej 3 graczy.';

  @override
  String get playerAddeddSuccessfully => 'Gracz dodany pomyślnie!';

  @override
  String get playerNmae => 'Imię gracza';

  @override
  String get addPlayer => 'Dodaj gracza';

  @override
  String get add => 'Dodaj';

  @override
  String get informations => 'Informacje';

  @override
  String get somethingWentWrong => 'Coś poszło nie tak!';

  @override
  String get settings => 'Ustawienia';

  @override
  String get tip => 'Wskazówka';

  @override
  String get addResultTip => 'Dotknij i przytrzymaj mecz, aby dodać wynik.';

  @override
  String get deleteRoundTip => 'Dotknij i przytrzymaj rundę, aby ją usunąć.';

  @override
  String get language => 'Język';

  @override
  String get switchTheme => 'Przełącz motyw';

  @override
  String get darkMode => 'Tryb ciemny';
}
