import '../../../../domain/models/match/match.dart';
import 'package:flutter/material.dart';

import 'match_state_tap.dart';

class MatchesViewModel extends ChangeNotifier {
  MatchTapState _stateTap = MatchNotTapped();

  MatchTapState get stateTap => _stateTap;

  emitMatchTapped(Match match) {
    _stateTap = MatchTapped(match);
    notifyListeners();
  }

  emitByeMatchTapped() {
    _stateTap = MatchNotTapped();
    notifyListeners();
  }
}
