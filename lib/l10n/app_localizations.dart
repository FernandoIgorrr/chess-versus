import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ha.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sr.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('ha'),
    Locale('he'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('sr'),
    Locale('sw'),
    Locale('zh'),
  ];

  /// Title for page showing tournaments
  ///
  /// In en, this message translates to:
  /// **'Tournaments'**
  String get tournaments;

  /// Title for delete tournament alert
  ///
  /// In en, this message translates to:
  /// **'Delete tournament ?'**
  String get deleteTournament;

  /// Title for cancel
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Title for delete
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Title for tournament registration button/form
  ///
  /// In en, this message translates to:
  /// **'Register tournament'**
  String get registerTournament;

  /// Label/hint for name
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Label/hint for tournament name
  ///
  /// In en, this message translates to:
  /// **'Tournament name'**
  String get tournamentName;

  /// Label/hint for tournament description
  ///
  /// In en, this message translates to:
  /// **'Tournament description'**
  String get tournamentDescription;

  /// Default description of a tournament without description
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get tournamentNullDescription;

  /// Label/hint for tournament type
  ///
  /// In en, this message translates to:
  /// **'Tournament type'**
  String get tournamentType;

  /// Label/hint for tournament start date
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get tournamentStartDate;

  /// Label/hint for created
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// Label/hint for in progress
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgress;

  /// Label/hint for finished
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finished;

  /// Label/hint for tournament has already ended
  ///
  /// In en, this message translates to:
  /// **'The tournament has already ended'**
  String get tournamentHasAlreadyEnded;

  /// Label/hint for rounds number
  ///
  /// In en, this message translates to:
  /// **'Nº of rounds'**
  String get numberOfRounds;

  /// Label/hint for score per bye
  ///
  /// In en, this message translates to:
  /// **'Score per bye'**
  String get scorePerBye;

  /// Label/hint for not defined
  ///
  /// In en, this message translates to:
  /// **'Not defined'**
  String get notDefined;

  /// Label/hint for not informed
  ///
  /// In en, this message translates to:
  /// **'Not informed'**
  String get notInformed;

  /// Label/hint for active players
  ///
  /// In en, this message translates to:
  /// **'Active players'**
  String get activePlayers;

  /// Label/hint for active
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// Label/hint para inativo
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// Label/hint for Bye inactive
  ///
  /// In en, this message translates to:
  /// **'Bye inactive'**
  String get byeInactive;

  /// Label/hint for the tournament hasn't started yet
  ///
  /// In en, this message translates to:
  /// **'The tournament hasn\'t started yet'**
  String get tournamentHasntStartedYet;

  /// Mensagem de sucesso para quando um torneio for cadastrado.
  ///
  /// In en, this message translates to:
  /// **'Tournament registered successfully!'**
  String get tournamentRegisteredSuccessfully;

  /// Invalid data message
  ///
  /// In en, this message translates to:
  /// **'Invalid data'**
  String get invalidData;

  /// Message for when there are no tournaments registered.
  ///
  /// In en, this message translates to:
  /// **'There are no registered tournaments'**
  String get emptyTournaments;

  /// Error message when trying to delete a tournament.
  ///
  /// In en, this message translates to:
  /// **'Error when trying to delete the tournament'**
  String get errorWhileDeletingATournament;

  /// Success message for deleting a tournament.
  ///
  /// In en, this message translates to:
  /// **'Tournament deleted successfully!'**
  String get successWhileDeletingATournament;

  /// Title for score/points of something
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// Exception message for when score is negative.
  ///
  /// In en, this message translates to:
  /// **'Score can\'t be negative!'**
  String get scoreNegativeException;

  /// Title for classification
  ///
  /// In en, this message translates to:
  /// **'Classification'**
  String get classification;

  /// Title for rounds
  ///
  /// In en, this message translates to:
  /// **'Rounds'**
  String get rounds;

  /// Title for round
  ///
  /// In en, this message translates to:
  /// **'Round'**
  String get round;

  /// Title for result
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// Success message for when a tournament is started.
  ///
  /// In en, this message translates to:
  /// **'Tournament started'**
  String get tournamentStarted;

  /// Error message for when a tournament can't be started.
  ///
  /// In en, this message translates to:
  /// **'The tournament can\'t be started'**
  String get tournamentCantBeStarted;

  /// Error message for when a tournament can't be paired.
  ///
  /// In en, this message translates to:
  /// **'The tournament can\'t be paired'**
  String get tournamentCantBePaired;

  /// Error message for when the results of the last round were not fully filled in
  ///
  /// In en, this message translates to:
  /// **'The results of the last round were not fully filled in.'**
  String get lastRoundResultsDontFilled;

  /// Error message for when all rounds have already been paired
  ///
  /// In en, this message translates to:
  /// **'All rounds have already been paired.'**
  String get allRoundsHaveAlreadyBeenPaired;

  /// Title for start tournament button/form
  ///
  /// In en, this message translates to:
  /// **'Start  Tournament'**
  String get startTournament;

  /// Title for when the tournament has finished
  ///
  /// In en, this message translates to:
  /// **'The tournament has finished'**
  String get theTournamentHasFinished;

  /// Title for start button/form
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// Title for table
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get table;

  /// Title for board
  ///
  /// In en, this message translates to:
  /// **'Board'**
  String get board;

  /// Title for player
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get player;

  /// Title for players
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get players;

  /// Message for when there are no players registered.
  ///
  /// In en, this message translates to:
  /// **'There are no registered players'**
  String get thereAreNoRegisteredPlayers;

  /// Message for when there are not enough players.
  ///
  /// In en, this message translates to:
  /// **'To start the tournament you need at least 3 players.'**
  String get toStartTheTournamentYouNeedAtLeastThreePlayers;

  /// Success message for when a player is added.
  ///
  /// In en, this message translates to:
  /// **'Player added successfully!'**
  String get playerAddeddSuccessfully;

  /// Label/hint for player name
  ///
  /// In en, this message translates to:
  /// **'Player name'**
  String get playerNmae;

  /// Title for add player button/form
  ///
  /// In en, this message translates to:
  /// **'Add player'**
  String get addPlayer;

  /// Title for add button/form
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Title for informations
  ///
  /// In en, this message translates to:
  /// **'Informations'**
  String get informations;

  /// Title for generic errors.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get somethingWentWrong;

  /// Title for settings button/icon
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// word 'tip' to place before a tip text
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get tip;

  /// a specific tip
  ///
  /// In en, this message translates to:
  /// **'Tap and hold the match to add the result.'**
  String get addResultTip;

  /// Label/hint for language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Switch theme
  ///
  /// In en, this message translates to:
  /// **'Switch theme'**
  String get switchTheme;

  /// Dark mode
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fa',
    'fr',
    'ha',
    'he',
    'hi',
    'it',
    'ja',
    'ko',
    'nl',
    'pl',
    'pt',
    'ru',
    'sr',
    'sw',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fr':
      return AppLocalizationsFr();
    case 'ha':
      return AppLocalizationsHa();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'sr':
      return AppLocalizationsSr();
    case 'sw':
      return AppLocalizationsSw();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
