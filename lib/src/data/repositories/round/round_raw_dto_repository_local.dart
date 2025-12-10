import 'dart:convert';

import 'package:chess_versus/src/data/exceptions/round_update_exception.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/round/round_raw_dto.dart';
import '../../exceptions/player_create_exception.dart';
import '../../exceptions/round_create_exception.dart';
import '../../exceptions/rounds_fetch_expetion.dart';
import 'round_raw_dto_repository.dart';

class RoundRawDtoRepositoryLocal implements RoundRawDtoRepository {
  final String _kRounds;
  //final _log = Logger('RoundRawDtoRepositoryLocal');
  RoundRawDtoRepositoryLocal(this._kRounds);

  @override
  Future<List<String>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_kRounds) ?? <String>[];
  }

  @override
  Future<bool> setItems(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(_kRounds, values);
  }

  @override
  AsyncResult<void> create(RoundRawDto round) async {
    try {
      await findAll().fold(
        (success) {
          var list = [...success];
          list.add(round);

          final listMapStringDynamic = list
              .map((round) => round.toJson())
              .toList();

          final listEncoded = listMapStringDynamic.map(jsonEncode).toList();

          setItems(listEncoded);
        },
        (failure) {
          throw RoundCreateException(failure.toString());
        },
      );
      return const Success(unit);
    } catch (e) {
      return Failure(PlayerCreateException(e.toString()));
    }
  }

  @override
  AsyncResult<List<RoundRawDto>> findAll() async {
    //_log.fine('findAll');
    try {
      final response = await getItems();
      // _log.fine('getItems success');
      //_log.fine(response.toString());
      if (response.isEmpty) return const Success(<RoundRawDto>[]);
      // _log.fine('response.isNotEmpty');

      var roundRawDtoList = response
          .map(jsonDecode)
          .map(RoundRawDto.fromJson)
          .toList();

      //_log.fine('playerRawDtoList success');
      return Success(roundRawDtoList);
    } on RoundsFetchException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(RoundsFetchException(e.toString()));
    }
  }

  @override
  AsyncResult<List<RoundRawDto>> findByTournament(String tournamentId) async {
    //_log.fine('findByTournamentId: $tournamentId');
    try {
      final response = await getItems();

      if (response.isEmpty) {
        return const Success(<RoundRawDto>[]);
      }

      List<dynamic> dynamicRounds = response
          .map(jsonDecode)
          .where((d) => d['tournament_id'] == tournamentId)
          .toList();

      return Success(dynamicRounds.map(RoundRawDto.fromJson).toList());
    } catch (e) {
      return Failure(RoundsFetchException(e.toString()));
    }
  }

  @override
  AsyncResult<RoundRawDto> findById(String id) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<void> update(RoundRawDto round) async {
    try {
      await findAll().fold(
        (success) {
          var list = [...success];
          list.removeWhere((r) => r.id == round.id);

          list.add(round);
          final listMapStringDynamic = list
              .map((round) => round.toJson())
              .toList();
          final listEncoded = listMapStringDynamic
              .map((jsonMap) => jsonEncode(jsonMap))
              .toList();
          setItems(listEncoded);
        },
        (failure) {
          throw RoundUpdateException(failure.toString());
        },
      );
      return const Success(unit);
    } catch (e) {
      //_log.warning(e.toString());
      return Failure(RoundUpdateException(e.toString()));
    }
  }

  @override
  AsyncResult<void> updateAll(List<RoundRawDto> rounds) async {
    try {
      for (final round in rounds) {
        await update(round);
      }
      return const Success(unit);
    } catch (e) {
      return Failure(RoundUpdateException(e.toString()));
    }
  }
}
