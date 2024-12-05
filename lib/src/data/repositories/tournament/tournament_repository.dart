import 'package:chess_versus/src/domain/models/tournament/tournament.dart';
import 'package:chess_versus/src/exceptions/tournament_fetch_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class TournamentRepository {
  /// Creates a new [Booking].
  //Future<Result<void>> createBooking(Tournament tournament);

  /// Returns the list of [Tournament] for the application.
  AsyncResult<List<Tournament>, TournamentFetchException> fetchAll();

  /// Returns the [Tournament] with the given [id].
  //Future<Result<Tournament>> fetchById(String id);

  /// Updates the [Tournament] with the given [id].
  // Future<Result<void>> update(Tournament tournament);

  /// Returns the [Tournament] with the given [id].
  // Future<Result<void>> delete(String id);
}
