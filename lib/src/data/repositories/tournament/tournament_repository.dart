import 'package:chess_versus/src/domain/models/tournament/tournament.dart';

import '../../../utils/result.dart';

abstract class TournamentRepository {
  /// Creates a new [Booking].
  Future<Result<void>> createBooking(Tournament tournament);

  /// Returns the list of [Tournament] for the application.
  Future<Result<List<Tournament>>> fetchAll();

  /// Returns the [Tournament] with the given [id].
  Future<Result<Tournament>> fetchById(String id);

  /// Updates the [Tournament] with the given [id].
  Future<Result<void>> update(Tournament tournament);

  /// Returns the [Tournament] with the given [id].
  Future<Result<void>> delete(String id);
}
