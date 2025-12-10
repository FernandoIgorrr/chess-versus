import 'package:chess_versus/src/data/exceptions/player_update_exception.dart';
import 'package:chess_versus/src/data/repositories/player/player_raw_dto_repository.dart';
import 'package:chess_versus/src/data/repositories/player/player_repository.dart';
import 'package:chess_versus/src/domain/models/player/player.dart';
import 'package:chess_versus/src/domain/models/player/player_raw_dto.dart';

import 'package:chess_versus/src/data/exceptions/tournament_fetch_exception.dart';

import 'package:result_dart/result_dart.dart';

import '../../exceptions/player_fetch_exception.dart';

class PlayerRepositoryLocal extends PlayerRepository {
  final PlayerRawDtoRepository _repository;

  //final _log = Logger('PlayerRepositoryLocal');

  PlayerRepositoryLocal(this._repository);

  @override
  Future<List<String>> getItems() async => await _repository.getItems();

  @override
  Future<bool> setItems(List<String> values) async =>
      _repository.setItems(values);

  @override
  AsyncResult<void> create(Player player, String tournamentId) async {
    //_log.fine('crate');
    // final _logg = Logger('create');
    // var reponse = await getItems();
    // reponse.add(
    //     jsonEncode(PlayerRawDto.fromPlayer(player, tournamentId).toJson()));

    // setItems(reponse);

    (await _repository.create(
      PlayerRawDto.fromPlayer(player, tournamentId),
    )).getOrThrow();
    //_log.fine('crate done');
    return const Success(unit);
  }

  @override
  AsyncResult<List<Player>> findAll() async {
    try {
      /* final response = await getItems();
       if (response.isEmpty) {
         return const Success(<Player>[]);
       }
       final list = response
           .map(jsonDecode)
           .map(PlayerRawDto.fromJson)
           .map(PlayerRawDto.toPlayer)
           .toList();*/
      final list = (await _repository.findAll()).getOrThrow();

      return Success(list.map(PlayerRawDto.toPlayer).toList());
    } on TournamentFetchExcpetion catch (e) {
      return Failure(PlayerFetchException(e.message));
    } catch (e) {
      return Failure(PlayerFetchException(e.toString()));
    }
  }

  @override
  AsyncResult<List<Player>> findBySuperclassId(String tournamentId) async {
    //_log.fine('findByTournamentId: $tournamentId');
    try {
      // final response = await getItems();

      // if (response.isEmpty) {
      //   return const Success(<Player>[]);
      // }

      // List<dynamic> dynamicPlayers = response
      //     .map(jsonDecode)
      //     .where((d) => d['tournament_id'] == tournamentId)
      //     .toList();
      final response = await _repository
          .findByTournament(tournamentId)
          .getOrElse((failure) {
            throw failure;
          });

      return Success(response.map(PlayerRawDto.toPlayer).toList());
    } catch (e) {
      return Failure(TournamentFetchExcpetion(e.toString()));
    }
  }

  @override
  AsyncResult<Player> findById(String id) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<void> update(Player player, String tournamentId) async {
    try {
      await _repository.update(PlayerRawDto.fromPlayer(player, tournamentId));

      return Success(unit);
    } on PlayerUpdateException catch (e) {
      return Failure(PlayerUpdateException(e.message));
    } catch (e) {
      return Failure(PlayerUpdateException(e.toString()));
    }
  }

  @override
  AsyncResult<void> updateAll(List<Player> players, String tournamentId) async {
    try {
      await _repository.updateAll(
        players.map((r) => PlayerRawDto.fromPlayer(r, tournamentId)).toList(),
      );

      return Success(unit);
    } catch (e) {
      return Failure(PlayerUpdateException(e.toString()));
    }
  }
}
