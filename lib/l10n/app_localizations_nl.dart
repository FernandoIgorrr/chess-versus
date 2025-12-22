// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get tournaments => 'Toernooien';

  @override
  String get deleteTournament => 'Toernooi verwijderen?';

  @override
  String get deleteRound => 'Ronde verwijderen?';

  @override
  String get cancel => 'Annuleren';

  @override
  String get delete => 'Verwijderen';

  @override
  String get registerTournament => 'Toernooi registreren';

  @override
  String get name => 'Naam';

  @override
  String get tournamentName => 'Naam van het toernooi';

  @override
  String get tournamentDescription => 'Toernooibeschrijving';

  @override
  String get tournamentNullDescription => 'Geen beschrijving';

  @override
  String get tournamentType => 'Type toernooi';

  @override
  String get tournamentStartDate => 'Startdatum';

  @override
  String get created => 'Aangemaakt';

  @override
  String get inProgress => 'Bezig';

  @override
  String get finished => 'Voltooid';

  @override
  String get tournamentHasAlreadyEnded => 'Het toernooi is al beëindigd';

  @override
  String get numberOfRounds => 'Aantal rondes';

  @override
  String get scorePerBye => 'Score per bye';

  @override
  String get notDefined => 'Niet gedefinieerd';

  @override
  String get notInformed => 'Niet ingevuld';

  @override
  String get activePlayers => 'Actieve spelers';

  @override
  String get active => 'Actief';

  @override
  String get inactive => 'Inactief';

  @override
  String get byeInactive => 'Bye inactief';

  @override
  String get tournamentHasntStartedYet => 'Het toernooi is nog niet gestart';

  @override
  String get tournamentRegisteredSuccessfully =>
      'Toernooi succesvol geregistreerd!';

  @override
  String get invalidData => 'Ongeldige gegevens';

  @override
  String get emptyTournaments => 'Er zijn geen geregistreerde toernooien';

  @override
  String get errorWhileDeletingATournament =>
      'Fout bij het verwijderen van het toernooi';

  @override
  String get successWhileDeletingATournament =>
      'Toernooi succesvol verwijderd!';

  @override
  String get score => 'Score';

  @override
  String get scoreNegativeException => 'Score mag niet negatief zijn!';

  @override
  String get classification => 'Klassement';

  @override
  String get rounds => 'Rondes';

  @override
  String get round => 'Ronde';

  @override
  String get result => 'Resultaat';

  @override
  String get tournamentStarted => 'Toernooi gestart';

  @override
  String get tournamentCantBeStarted => 'Het toernooi kan niet worden gestart';

  @override
  String get tournamentCantBePaired => 'Het toernooi kan niet worden gepaard';

  @override
  String get lastRoundResultsDontFilled =>
      'De resultaten van de laatste ronde zijn niet volledig ingevuld.';

  @override
  String get allRoundsHaveAlreadyBeenPaired => 'Alle rondes zijn al gepaard.';

  @override
  String get startTournament => 'Start Toernooi';

  @override
  String get theTournamentHasFinished => 'Het toernooi is afgelopen';

  @override
  String get start => 'Start';

  @override
  String get table => 'Tabel';

  @override
  String get board => 'Bord';

  @override
  String get player => 'Speler';

  @override
  String get players => 'Spelers';

  @override
  String get thereAreNoRegisteredPlayers =>
      'Er zijn geen geregistreerde spelers';

  @override
  String get toStartTheTournamentYouNeedAtLeastThreePlayers =>
      'Om het toernooi te starten heb je minimaal 3 spelers nodig.';

  @override
  String get playerAddeddSuccessfully => 'Speler succesvol toegevoegd!';

  @override
  String get playerNmae => 'Naam van de speler';

  @override
  String get addPlayer => 'Speler toevoegen';

  @override
  String get add => 'Toevoegen';

  @override
  String get informations => 'Informatie';

  @override
  String get somethingWentWrong => 'Er is iets fout gegaan!';

  @override
  String get settings => 'Instellingen';

  @override
  String get tip => 'Tip';

  @override
  String get addResultTip =>
      'Tik en houd ingedrukt op de wedstrijd om het resultaat toe te voegen.';

  @override
  String get deleteRoundTip =>
      'Tik en houd ingedrukt op de ronde om deze te verwijderen.';

  @override
  String get language => 'Taal';

  @override
  String get switchTheme => 'Thema wisselen';

  @override
  String get darkMode => 'Donkere modus';
}
