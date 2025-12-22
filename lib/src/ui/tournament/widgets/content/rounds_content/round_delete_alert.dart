import 'package:chess_versus/l10n/app_localizations.dart';
import 'package:chess_versus/src/ui/tournament/view_models/rounds/rounds_view_model.dart';

import 'package:flutter/material.dart';

class RoundDeleteAlert extends StatefulWidget {
  final String _tournamentId;
  final String _roundId;
  final RoundsViewModel _roundsViewModel;

  const RoundDeleteAlert({
    super.key,
    required String tournamentId,
    required String roundId,
    required RoundsViewModel roundsViewModel,
  }) : _tournamentId = tournamentId,
       _roundId = roundId,
       _roundsViewModel = roundsViewModel;

  @override
  State<RoundDeleteAlert> createState() => _RoundDeleteAlertState();
}

class _RoundDeleteAlertState extends State<RoundDeleteAlert> {
  final formKey = GlobalKey<FormState>();
  FormState get form => formKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.deleteRound,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      actions: [
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.delete,
            style: Theme.of(context).textTheme.titleMedium,
          ),

          onPressed: () async {
            Navigator.of(context).pop();
            await widget._roundsViewModel.deleteRound(widget._roundId);
            await widget._roundsViewModel.assemblyTournament(
              widget._tournamentId,
            );
          },
        ),
      ],
    );
  }
}
