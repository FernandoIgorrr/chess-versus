import '../../../../domain/models/match/match.dart';

sealed class MatchTapState {}

class MatchNotTapped extends MatchTapState {}

class MatchTapped extends MatchTapState {
  Match match;

  MatchTapped(this.match);
}
