import 'dart:convert';

import 'package:chess_versus/src/domain/models/tournament/tournament.dart';
import 'package:chess_versus/src/data/exceptions/erro_exception.dart';
import 'package:chess_versus/src/data/exceptions/tournament_create_exception.dart';
import 'package:chess_versus/src/data/exceptions/tournament_fetch_exception.dart';
import 'package:logging/logging.dart';

import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tournament_repository.dart';

class TournamentRepositoryLocal implements TournamentRepository {
  final String _kTournaments;
  //final _log = Logger('TournamentRepositoryLocal');
  TournamentRepositoryLocal(this._kTournaments);

  @override
  Future<List<String>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_kTournaments) ?? [];
  }

  @override
  Future<bool> setItems(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(_kTournaments, values);
  }

  @override
  AsyncResult<void, Exception> create(Tournament tournament) async {
    //final _log = Logger('create');
    try {
      await findAll().fold((success) {
        var list = [...success];
        list.add(tournament);
        final listMapStringDynamic =
            list.map((tournament) => tournament.toJson()).toList();
        final listEncoded =
            listMapStringDynamic.map((jsonMap) => jsonEncode(jsonMap)).toList();
        setItems(listEncoded);
      }, (failure) {
        throw TournamentCreateException(failure.message);
      });
      return const Success(unit);
    } catch (e) {
      //_log.warning(e.toString());
      return Failure(TournamentCreateException(e.toString()));
    }
  }

  @override
  AsyncResult<Tournament, Exception> findById(String id) async {
    //_log.fine('findById: $id');
    try {
      final response = await getItems();

      if (response.isEmpty) {
        throw TournamentFetchExcpetion('Não há torneios cadastrados');
      }

      dynamic dynamicTournament =
          response.map(jsonDecode).firstWhere((d) => d['id'] == id);

      return Success(Tournament.fromJson(dynamicTournament));
    } on StateError catch (e) {
      return Failure(ErroException(e, 'Tournament not found'));
    } on TournamentFetchExcpetion catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<List<Tournament>, TournamentFetchExcpetion> findAll() async {
    try {
      final response = await getItems();

      if (response.isEmpty) return const Success(<Tournament>[]);

      List<dynamic> dynamicTournamentList = response.map(jsonDecode).toList();

      return Success(dynamicTournamentList.map(Tournament.fromJson).toList());
    } catch (e) {
      return Failure(TournamentFetchExcpetion(e.toString()));
    }
  }
}
