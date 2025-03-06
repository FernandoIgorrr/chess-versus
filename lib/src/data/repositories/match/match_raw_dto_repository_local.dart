import 'dart:convert';

import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/match/match_row_dto.dart';
import '../../exceptions/match_create_exception.dart';
import '../../exceptions/matches_fetch_exception.dart';
import 'match_raw_dto_repository.dart';

class MatchRawDtoRepositoryLocal extends MatchRawDtoRepository {
  final String _kMatches;

  MatchRawDtoRepositoryLocal(this._kMatches);

  @override
  Future<List<String>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_kMatches) ?? <String>[];
  }

  @override
  Future<bool> setItems(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(_kMatches, values);
  }

  @override
  AsyncResult<void> create(MatchRawDto matchRawDto) async {
    try {
      await findAll().fold((success) {
        var list = [...success];
        list.add(matchRawDto);

        final listMapStringDynamic =
            list.map((match) => match.toJson()).toList();

        final listEncoded = listMapStringDynamic.map(jsonEncode).toList();

        setItems(listEncoded);
      }, (failure) {
        throw MatchCreateException(failure.toString());
      });

      return const Success(unit);
    } catch (e) {
      return Failure(MatchCreateException(e.toString()));
    }
  }

  @override
  AsyncResult<List<MatchRawDto>> findAll() async {
    try {
      final response = await getItems();
      // _log.fine('getItems success');
      //_log.fine(response.toString());
      if (response.isEmpty) return const Success(<MatchRawDto>[]);
      // _log.fine('response.isNotEmpty');

      var matchRawDtoList =
          response.map(jsonDecode).map(MatchRawDto.fromJson).toList();

      //_log.fine('playerRawDtoList success');
      return Success(matchRawDtoList);
    } on MatchesFetchException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(MatchesFetchException(e.toString()));
    }
  }

  @override
  AsyncResult<List<MatchRawDto>> findByRound(String roundId) async {
    //_log.fine('findByTournamentId: $tournamentId');
    try {
      final response = await getItems();

      if (response.isEmpty) {
        return const Success(<MatchRawDto>[]);
      }

      List<dynamic> dynamicMatches = response
          .map(jsonDecode)
          .where((d) => d['round_id'] == roundId)
          .toList();

      return Success(dynamicMatches.map(MatchRawDto.fromJson).toList());
    } catch (e) {
      return Failure(MatchesFetchException(e.toString()));
    }
  }

  @override
  AsyncResult<MatchRawDto> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }
}
