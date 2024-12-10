import 'dart:convert';

import 'package:chess_versus/src/domain/models/tournament/tournament.dart';
import 'package:chess_versus/src/exceptions/tournament_create_exception.dart';
import 'package:chess_versus/src/exceptions/tournament_fetch_exception.dart';

import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tournament_repository.dart';

class TournamentRepositoryLocal implements TournamentRepository {
  final String _kTournaments;

  TournamentRepositoryLocal(this._kTournaments);

  @override
  Future<List<String>?> getItems() async {
    await Future.delayed(const Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_kTournaments);
  }

  @override
  Future<bool> setItems(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(_kTournaments, values);
  }

  @override
  AsyncResult<List<Tournament>, TournamentFetchException> findAll() async {
    try {
      final response = await getItems();

      if (response == null) return const Success(<Tournament>[]);

      List<dynamic> dynamicTournamentList = response.map(jsonDecode).toList();

      return Success(dynamicTournamentList.map(Tournament.fromJson).toList());
    } catch (e) {
      return Failure(TournamentFetchException(e.toString()));
    }
  }

  @override
  AsyncResult<void, Exception> create(Tournament tournament) async {
    try {
      await findAll().fold((sucess) {
        sucess.add(tournament);
        final listMapStringDynamic =
            sucess.map((tournament) => tournament.toJson).toList();
        setItems(listMapStringDynamic.map(jsonEncode).toList());
      }, (failure) {
        throw TournamentCreateException(failure.message);
      });
      return const Success(unit);
    } catch (e) {
      return Failure(TournamentCreateException(e.toString()));
    }
  }
}
