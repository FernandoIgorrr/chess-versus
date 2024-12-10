import 'package:chess_versus/src/domain/models/tournament/tournament_create_dto.dart';
import 'package:chess_versus/src/domain/models/tournament/tournament_type.dart';
import 'package:chess_versus/src/ui/core/theme_config/dimends.dart';
import 'package:chess_versus/src/ui/core/ui/custom_radio_button.dart';
import 'package:chess_versus/src/ui/core/ui/custom_text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/models/tournament/tournament.dart';

class HomeCreateTournamentWidget extends StatefulWidget {
  const HomeCreateTournamentWidget({super.key});

  @override
  State<HomeCreateTournamentWidget> createState() =>
      _HomeCreateTournamentWidgetState();
}

class _HomeCreateTournamentWidgetState
    extends State<HomeCreateTournamentWidget> {
  List<TournamentType> tournamentTypes = <TournamentType>[
    Swiss(0.0),
    Elimination(),
    RoundRobin()
  ];
  List<double> byeScores = <double>[0.0, 0.5, 1.0];

  late TournamentType tournamentTypeController;
  late double byeScoreController;

  late Tournament tournament;
  late TournamentCreateDTO tournamentCreateDTO;

  @override
  void initState() {
    super.initState();
    tournamentTypeController = tournamentTypes.first;
    byeScoreController = byeScores.first;
    tournamentCreateDTO = TournamentCreateDTO.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      //width: double.maxFinite,
      padding: Dimens.of(context).edgeInsetsScreenHorizontal,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.registerTournament,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _buildNameTextFormField(),
            const SizedBox(height: 16),
            _buildDescriptionTextFormField(),
            const SizedBox(height: 16),
            _buildTournamentTypeSection(),
            const SizedBox(height: 16),
            tournamentCreateDTO.getType is Swiss
                ? _buildByeScoreSection()
                : Container(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (kDebugMode) {
                  print(tournamentCreateDTO);
                }
              },
              child: const Text("CADASTRAR TORNEIO"),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  _buildTournamentTypeSection() {
    return Column(
      children: [
        Row(children: <Widget>[
          Expanded(
            child: Divider(color: Theme.of(context).colorScheme.secondary),
          ),
          Text("  ${AppLocalizations.of(context)!.tournamentType}  ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary)),
          Expanded(
            child: Divider(color: Theme.of(context).colorScheme.secondary),
          ),
        ]),
        const SizedBox(height: 16),
        _buildRadioButtonTournamentType()
      ],
    );
  }

  _buildByeScoreSection() {
    return Column(
      children: [
        Row(children: <Widget>[
          Expanded(
            child: Divider(color: Theme.of(context).colorScheme.secondary),
          ),
          Text("  ${AppLocalizations.of(context)!.scorePerBye}  ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary)),
          Expanded(
            child: Divider(color: Theme.of(context).colorScheme.secondary),
          ),
        ]),
        const SizedBox(height: 16),
        _buildRadioButtonByeScore()
      ],
    );
  }

  _buildNameTextFormField() {
    return CustomTextFormField(
      //label: Text(AppLocalizations.of(context)!.tournamentName),
      hintText: AppLocalizations.of(context)!.tournamentName,
      value: tournamentCreateDTO.getName.toString(),
      validator: (v) => tournamentCreateDTO.getName.validator(),
      onChange: tournamentCreateDTO.setName,
    );
  }

  _buildDescriptionTextFormField() {
    return CustomTextFormField(
      hintText: AppLocalizations.of(context)!.tournamentDescription,
      maxLines: 3,
      onChange: tournamentCreateDTO.setDescription,
    );
  }

  _buildRadioButtonTournamentType() {
    return CustomRadioButton<TournamentType>(
      items: tournamentTypes,
      onChanged: tournamentCreateDTO.setType,
    );
  }

  _buildRadioButtonByeScore() {
    return CustomRadioButton<double>(
      fullWidth: true,
      items: byeScores,
      onChanged: tournamentCreateDTO.setByScore,
    );
  }
}
