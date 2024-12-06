import 'package:chess_versus/src/ui/core/ui/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateTournamentWidget extends StatelessWidget {
  const CreateTournamentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary, width: 2)),
      title: Text(AppLocalizations.of(context)!.registerTournament,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CustomTextFormField(
            hintText: AppLocalizations.of(context)!.name,
          ),
        ]),
      ),
    );
  }
}
