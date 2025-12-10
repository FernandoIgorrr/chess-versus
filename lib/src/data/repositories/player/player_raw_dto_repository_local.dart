import 'dart:convert';

import 'package:chess_versus/src/data/exceptions/player_update_exception.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/player/player_raw_dto.dart';
import '../../exceptions/player_create_exception.dart';
import '../../exceptions/player_fetch_exception.dart';
import '../../exceptions/tournament_fetch_exception.dart';
import 'player_raw_dto_repository.dart';

class PlayerRawDtoRepositoryLocal implements PlayerRawDtoRepository {
  final String _kPlayers;
  //final _log = Logger('PlayerRawDtoRepositoryLocal');
  PlayerRawDtoRepositoryLocal(this._kPlayers);

  @override
  Future<List<String>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_kPlayers) ?? <String>[];
  }

  @override
  Future<bool> setItems(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(_kPlayers, values);
  }

  @override
  AsyncResult<void> create(PlayerRawDto playerRawDto) async {
    //_log.fine('create');
    try {
      await findAll().fold(
        (success) {
          //_log.fine('findalAll() success');
          var list = [...success];
          list.add(playerRawDto);
          //_log.fine(playerRawDto.toString());
          final listMapStringDynamic = list
              .map((player) => player.toJson())
              .toList();

          //_log.fine('listMapStringDynamic success');
          // _log.fine(listMapStringDynamic.toString());
          final listEncoded = listMapStringDynamic.map(jsonEncode).toList();
          // _log.fine('listEncoded success');
          setItems(listEncoded);
        },
        (failure) {
          throw PlayerCreateException(failure.toString());
        },
      );
      //_log.fine('create done');
      return const Success(unit);
    } catch (e) {
      //_log.warning(e.toString());
      return Failure(PlayerCreateException(e.toString()));
    }
  }

  @override
  AsyncResult<List<PlayerRawDto>> findAll() async {
    //_log.fine('findAll');
    try {
      final response = await getItems();
      // _log.fine('getItems success');
      //_log.fine(response.toString());
      if (response.isEmpty) return const Success(<PlayerRawDto>[]);
      // _log.fine('response.isNotEmpty');

      var playerRawDtoList = response
          .map(jsonDecode)
          .map(PlayerRawDto.fromJson)
          .toList();

      //_log.fine('playerRawDtoList success');
      return Success(playerRawDtoList);
    } on PlayerFetchException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(PlayerFetchException(e.toString()));
    }
  }

  @override
  AsyncResult<List<PlayerRawDto>> findByTournament(String tournamentId) async {
    //_log.fine('findByTournamentId: $tournamentId');
    try {
      final response = await getItems();

      if (response.isEmpty) {
        return const Success(<PlayerRawDto>[]);
      }

      List<dynamic> dynamicPlayers = response
          .map(jsonDecode)
          .where((d) => d['tournament_id'] == tournamentId)
          .toList();

      return Success(dynamicPlayers.map(PlayerRawDto.fromJson).toList());
    } catch (e) {
      return Failure(TournamentFetchExcpetion(e.toString()));
    }
  }

  @override
  AsyncResult<PlayerRawDto> findById(String id) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<void> update(PlayerRawDto player) async {
    try {
      await findAll().fold(
        (success) {
          var list = [...success];
          list.removeWhere((p) => p.id == player.id);

          list.add(player);
          final listMapStringDynamic = list
              .map((round) => round.toJson())
              .toList();
          final listEncoded = listMapStringDynamic
              .map((jsonMap) => jsonEncode(jsonMap))
              .toList();
          setItems(listEncoded);
        },
        (failure) {
          throw PlayerUpdateException(failure.toString());
        },
      );
      return const Success(unit);
    } catch (e) {
      //_log.warning(e.toString());
      return Failure(PlayerUpdateException(e.toString()));
    }
  }

  @override
  AsyncResult<void> updateAll(List<PlayerRawDto> players) async {
    try {
      for (final player in players) {
        await update(player);
      }
      return const Success(unit);
    } catch (e) {
      return Failure(PlayerUpdateException(e.toString()));
    }
  }
}
