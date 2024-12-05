class Routes {
  static const home = '/';

  static const tournament = '/$tournamentRelative';
  static const tournamentRelative = 'tournament';
  static String tournamentWithId(String id) => '$tournament/$id';
}
