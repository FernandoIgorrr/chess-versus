import 'package:chess_versus/src/data/repositories/player/player_repository.dart';

import 'package:chess_versus/src/exceptions/tournament_fetch_exception.dart';
import 'package:logging/logging.dart';

import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/player/player.dart';

class PlayerRepositoryLocal implements PlayerRepository {
  final String _kPlayers;
  final _log = Logger('PlayerRepositoryLocal');
  PlayerRepositoryLocal(this._kPlayers);

  @override
  Future<List<String>?> getItems() async {
    //await Future.delayed(const Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_kPlayers);
  }

  @override
  Future<bool> setItems(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(_kPlayers, values);
  }

  @override
  AsyncResult<void, Exception> create(Player player) async {
    final _logg = Logger('create');
    // TODO: implement fetchByTournamentId
    throw UnimplementedError();
  }

  @override
  AsyncResult<List<Player>, TournamentFetchException> findAll() async {
    // TODO: implement fetchByTournamentId
    throw UnimplementedError();
  }

  @override
  AsyncResult<List<Player>, Exception> fetchByTournamentId(String id) {
    // TODO: implement fetchByTournamentId
    throw UnimplementedError();
  }

  @override
  AsyncResult<Player, Exception> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }
}
