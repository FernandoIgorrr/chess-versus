// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get tournaments => 'טורנירים';

  @override
  String get deleteTournament => 'למחוק טורניר?';

  @override
  String get cancel => 'ביטול';

  @override
  String get delete => 'מחק';

  @override
  String get registerTournament => 'רישום טורניר';

  @override
  String get name => 'שם';

  @override
  String get tournamentName => 'שם הטורניר';

  @override
  String get tournamentDescription => 'תיאור הטורניר';

  @override
  String get tournamentNullDescription => 'אין תיאור';

  @override
  String get tournamentType => 'סוג הטורניר';

  @override
  String get tournamentStartDate => 'תאריך התחלה';

  @override
  String get created => 'נוצר';

  @override
  String get inProgress => 'בתהליך';

  @override
  String get finished => 'הסתיים';

  @override
  String get tournamentHasAlreadyEnded => 'הטורניר כבר הסתיים';

  @override
  String get numberOfRounds => 'מספר סיבובים';

  @override
  String get scorePerBye => 'ניקוד לסיבוב חופשי';

  @override
  String get notDefined => 'לא מוגדר';

  @override
  String get notInformed => 'לא דווח';

  @override
  String get activePlayers => 'שחקנים פעילים';

  @override
  String get active => 'פעיל';

  @override
  String get inactive => 'לא פעיל';

  @override
  String get byeInactive => 'סיבוב חופשי לא פעיל';

  @override
  String get tournamentHasntStartedYet => 'הטורניר טרם החל';

  @override
  String get tournamentRegisteredSuccessfully => 'הטורניר נרשם בהצלחה!';

  @override
  String get invalidData => 'נתונים לא חוקיים';

  @override
  String get emptyTournaments => 'אין טורנירים רשומים';

  @override
  String get errorWhileDeletingATournament => 'שגיאה בניסיון למחוק את הטורניר';

  @override
  String get successWhileDeletingATournament => 'הטורניר נמחק בהצלחה!';

  @override
  String get score => 'ניקוד';

  @override
  String get scoreNegativeException => 'הניקוד לא יכול להיות שלילי!';

  @override
  String get classification => 'סיווג';

  @override
  String get rounds => 'סיבובים';

  @override
  String get round => 'סיבוב';

  @override
  String get result => 'תוצאה';

  @override
  String get tournamentStarted => 'הטורניר החל';

  @override
  String get tournamentCantBeStarted => 'לא ניתן להתחיל את הטורניר';

  @override
  String get tournamentCantBePaired => 'לא ניתן לבצע זיווג בטורניר';

  @override
  String get lastRoundResultsDontFilled =>
      'תוצאות הסיבוב האחרון לא מולאו במלואן.';

  @override
  String get allRoundsHaveAlreadyBeenPaired => 'כל הסיבובים כבר זוווגו.';

  @override
  String get startTournament => 'התחל טורניר';

  @override
  String get theTournamentHasFinished => 'הטורניר הסתיים';

  @override
  String get start => 'התחל';

  @override
  String get table => 'טבלה';

  @override
  String get board => 'לוח';

  @override
  String get player => 'שחקן';

  @override
  String get players => 'שחקנים';

  @override
  String get thereAreNoRegisteredPlayers => 'אין שחקנים רשומים';

  @override
  String get toStartTheTournamentYouNeedAtLeastThreePlayers =>
      'כדי להתחיל את הטורניר אתה צריך לפחות 3 שחקנים.';

  @override
  String get playerAddeddSuccessfully => 'השחקן נוסף בהצלחה!';

  @override
  String get playerNmae => 'שם השחקן';

  @override
  String get addPlayer => 'הוסף שחקן';

  @override
  String get add => 'הוסף';

  @override
  String get informations => 'מידע';

  @override
  String get somethingWentWrong => 'משהו השתבש!';

  @override
  String get settings => 'הגדרות';

  @override
  String get language => 'שפה';

  @override
  String get switchTheme => 'החלף ערכת נושא';

  @override
  String get darkMode => 'מצב כהה';
}
