import 'package:chess_versus/l10n/app_localizations.dart';
import 'package:chess_versus/src/ui/core/ui/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/tournament/tournament.dart';
import '../../../../core/ui/increment_decrement_field.dart';

class TournamentRoundNumForm extends StatefulWidget {
  const TournamentRoundNumForm({
    super.key,
    this.onPressed,
    required this.minNumRounds,
    required this.maxNumRounds,
    required this.tournament,
  });

  final VoidCallback? onPressed;
  final int minNumRounds;
  final int maxNumRounds;
  final Tournament tournament;
  //int totalNumberOfRounds;

  @override
  State<TournamentRoundNumForm> createState() => _TournamentRoundNumFormState();
}

class _TournamentRoundNumFormState extends State<TournamentRoundNumForm> {
  //late int totalNumberOfRounds;

  @override
  void initState() {
    super.initState();
    widget.tournament.setTotalNumberOfRounds(widget.minNumRounds);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.numberOfRounds,
        textAlign: TextAlign.center,

        style: Theme.of(context).textTheme.headlineLarge,
      ),
      content: IncrementDecrementField(
        minValue: widget.minNumRounds,
        maxValue: widget.maxNumRounds,
        onChanged: (int value) {
          widget.tournament.setTotalNumberOfRounds(value);
        },
      ),
      actions: [
        CustomElevatedButton(
          text: AppLocalizations.of(context)!.startTournament,
          onPressed: widget.onPressed,
        ),
      ],
    );
  }
}
