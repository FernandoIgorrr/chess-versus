// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get tournaments => 'Torneos';

  @override
  String get deleteTournament => '¿Eliminar torneo?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get registerTournament => 'Registrar torneo';

  @override
  String get name => 'Nombre';

  @override
  String get tournamentName => 'Nombre del torneo';

  @override
  String get tournamentDescription => 'Descripción del torneo';

  @override
  String get tournamentNullDescription => 'Sin descripción';

  @override
  String get tournamentType => 'Tipo de torneo';

  @override
  String get tournamentStartDate => 'Fecha de inicio';

  @override
  String get created => 'Creado';

  @override
  String get inProgress => 'En progreso';

  @override
  String get finished => 'Finalizado';

  @override
  String get tournamentHasAlreadyEnded => 'El torneo ya ha finalizado';

  @override
  String get numberOfRounds => 'Nº de rondas';

  @override
  String get scorePerBye => 'Puntuación por bye';

  @override
  String get notDefined => 'No definido';

  @override
  String get notInformed => 'No informado';

  @override
  String get activePlayers => 'Jugadores activos';

  @override
  String get active => 'Activo';

  @override
  String get inactive => 'Inactivo';

  @override
  String get byeInactive => 'Bye inactivo';

  @override
  String get tournamentHasntStartedYet => 'El torneo aún no ha comenzado';

  @override
  String get tournamentRegisteredSuccessfully =>
      '¡Torneo registrado con éxito!';

  @override
  String get invalidData => 'Datos inválidos';

  @override
  String get emptyTournaments => 'No hay torneos registrados';

  @override
  String get errorWhileDeletingATournament =>
      'Error al intentar eliminar el torneo';

  @override
  String get successWhileDeletingATournament => '¡Torneo eliminado con éxito!';

  @override
  String get score => 'Puntuación';

  @override
  String get scoreNegativeException => '¡La puntuación no puede ser negativa!';

  @override
  String get classification => 'Clasificación';

  @override
  String get rounds => 'Rondas';

  @override
  String get round => 'Ronda';

  @override
  String get result => 'Resultado';

  @override
  String get tournamentStarted => 'Torneo iniciado';

  @override
  String get tournamentCantBeStarted => 'El torneo no puede iniciarse';

  @override
  String get tournamentCantBePaired => 'El torneo no puede emparejarse';

  @override
  String get lastRoundResultsDontFilled =>
      'Los resultados de la última ronda no fueron completados completamente.';

  @override
  String get allRoundsHaveAlreadyBeenPaired =>
      'Todas las rondas ya han sido emparejadas.';

  @override
  String get startTournament => 'Iniciar torneo';

  @override
  String get theTournamentHasFinished => 'El torneo ha finalizado';

  @override
  String get start => 'Iniciar';

  @override
  String get table => 'Mesa';

  @override
  String get board => 'Tablero';

  @override
  String get player => 'Jugador';

  @override
  String get players => 'Jugadores';

  @override
  String get thereAreNoRegisteredPlayers => 'No hay jugadores registrados';

  @override
  String get toStartTheTournamentYouNeedAtLeastThreePlayers =>
      'Para iniciar el torneo necesitas al menos 3 jugadores.';

  @override
  String get playerAddeddSuccessfully => '¡Jugador añadido con éxito!';

  @override
  String get playerNmae => 'Nombre del jugador';

  @override
  String get addPlayer => 'Añadir jugador';

  @override
  String get add => 'Añadir';

  @override
  String get informations => 'Información';

  @override
  String get somethingWentWrong => '¡Algo salió mal!';

  @override
  String get settings => 'Configuración';

  @override
  String get tip => 'Consejo';

  @override
  String get addResultTip =>
      'Toca y mantén presionada la partida para agregar el resultado.';

  @override
  String get language => 'Idioma';

  @override
  String get switchTheme => 'Cambiar tema';

  @override
  String get darkMode => 'Modo oscuro';
}
