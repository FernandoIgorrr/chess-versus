import 'dart:convert';

import 'package:chess_versus/src/domain/models/tournament/tournament.dart';
import 'package:chess_versus/src/exceptions/tournament_create_exception.dart';
import 'package:chess_versus/src/exceptions/tournament_fetch_exception.dart';
import 'package:localstorage/localstorage.dart';

import 'package:result_dart/result_dart.dart';

import '../../../config/local_storage.dart';
import 'tournament_repository.dart';

class TournamentRepositoryLocal implements TournamentRepository {
  @override
  Future<String?> getItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return localStorage.getItem(LocalStorageKey.tournaments);
  }

  @override
  Future<void> setItems(String value) async {
    //await Future.delayed(const Duration(seconds: 1));
    localStorage.setItem(LocalStorageKey.tournaments, value);
  }

  @override
  AsyncResult<List<Tournament>, TournamentFetchException> findAll() async {
    try {
      final response = await getItems();

      if (response == null) return const Success(<Tournament>[]);

      List<dynamic> dynamicTournamentList = jsonDecode(response);

      return Success(dynamicTournamentList.map(Tournament.fromJson).toList());
    } on TournamentFetchException catch (e) {
      return Failure(TournamentFetchException(e.message));
    }
  }

  @override
  Future<void> create(Tournament tournament) async {
    try {
      findAll().fold((sucess) {
        sucess.add(tournament);
        final listMapStringDynamic =
            sucess.map((tournament) => tournament.toJson).toList();
        setItems(jsonEncode(listMapStringDynamic));
      }, (failure) {
        throw TournamentCreateException(failure.message);
      });
    } catch (e) {
      throw TournamentCreateException(e.toString());
    }
  }
}
