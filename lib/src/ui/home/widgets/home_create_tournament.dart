import 'package:chess_versus/src/domain/models/tournament/tournament_type.dart';
import 'package:chess_versus/src/ui/core/ui/custom_dropdown.dart';
import 'package:chess_versus/src/ui/core/ui/custom_radio_button.dart';
import 'package:chess_versus/src/ui/core/ui/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateTournamentWidget extends StatefulWidget {
  const CreateTournamentWidget({super.key});

  @override
  State<CreateTournamentWidget> createState() => _CreateTournamentWidgetState();
}

class _CreateTournamentWidgetState extends State<CreateTournamentWidget> {
  List<TournamentType> tournamentTypes = <TournamentType>[
    Swiss(0.0),
    Elimination(),
    RoundRobin()
  ];
  List<double> byeScores = <double>[0.0, 0.5, 1.0];

  late TournamentType tournamentTypeController;
  late double byeScoreController;

  @override
  void initState() {
    super.initState();
    tournamentTypeController = tournamentTypes.first;
    byeScoreController = byeScores.first;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.registerTournament,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              //label: Text(AppLocalizations.of(context)!.tournamentName),
              hintText: AppLocalizations.of(context)!.tournamentName,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              hintText: AppLocalizations.of(context)!.tournamentDescription,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            CustomDropdown(
              selectedItem: tournamentTypeController,
              items: tournamentTypes.map<DropdownMenuItem<TournamentType>>(
                  (TournamentType value) {
                return DropdownMenuItem<TournamentType>(
                  alignment: AlignmentDirectional.center,
                  value: value,
                  child: Text(
                    value.toString(),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  tournamentTypeController = value;
                });
              },
            ),
            const SizedBox(height: 16),
            tournamentTypeController is Swiss
                ? CustomRadioButton<double>(
                    items: byeScores,
                    onChanged: (value) {
                      setState(() {
                        byeScoreController = value;
                      });
                    },
                  )
                : Container(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                print(tournamentTypeController.toString() +
                    "  ***   " +
                    byeScoreController.toString());
              },
              child: Text("CRIAR TOURNEIOS"),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
