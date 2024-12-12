import 'package:chess_versus/src/config/local_storage.dart';
import 'package:chess_versus/src/data/repositories/tournament/tournament_repository.dart';
import 'package:chess_versus/src/data/repositories/tournament/tournament_repository_local.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('tournament repository local ...', (tester) async {
    SharedPreferences.setMockInitialValues({
      'tournaments': [
        'qualquercoisa',
        'qualquercoisa',
        'aids2',
      ]
    });
    // final TournamentRepository tournamentRepository =
    //   TournamentRepositoryLocal(LocalStorageKeys.kTournaments);

    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getStringList('tournaments');

    // var object = await tournamentRepository.getItems();
    if (kDebugMode) {
      print("QUALQUER COISA PRA TESTAR");

      print(result);
    }
  });
}
