import 'package:chess_versus/src/ui/home/view_models/home_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

class DeleteAlert extends StatefulWidget {
  final String _tournamentId;
  final HomeViewModel _homeViewModel;

  const DeleteAlert({
    super.key,
    required String tournamentId,
    required HomeViewModel homeViewModel,
  }) : _tournamentId = tournamentId,
       _homeViewModel = homeViewModel;

  @override
  State<DeleteAlert> createState() => _DeleteAlertState();
}

class _DeleteAlertState extends State<DeleteAlert> {
  final formKey = GlobalKey<FormState>();
  FormState get form => formKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.deleteTournament,
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
            await widget._homeViewModel.deleteTournament(widget._tournamentId);
            await widget._homeViewModel.getTournaments();
          },
        ),
      ],
    );
  }
}
