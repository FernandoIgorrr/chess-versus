import 'package:chess_versus/src/domain/models/tournament/tournament_create_dto.dart';
import 'package:chess_versus/src/domain/models/tournament/tournament_type.dart';
import 'package:chess_versus/src/ui/core/theme_config/dimends.dart';
import 'package:chess_versus/src/ui/core/ui/custom_elevated_button.dart';
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
  final formKey = GlobalKey<FormState>();

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

  FormState get form => formKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          //width: double.maxFinite,
          padding: Dimens.of(context).edgeInsetsScreenHorizontal,
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              //mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.registerTournament,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
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
                CustomElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    if (kDebugMode) {
                      print(tournamentCreateDTO);
                    }
                    final valid = form.validate();
                    if (valid) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          _buildSnackBarFeedback(
                              AppLocalizations.of(context)!
                                  .tournamentRegisteredSuccessfully,
                              Theme.of(context).colorScheme.scrim));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          _buildSnackBarFeedback(
                              AppLocalizations.of(context)!.invalidData,
                              Theme.of(context).colorScheme.error));
                    }
                  },
                  text: AppLocalizations.of(context)!.registerTournament,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
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
    return RadioButtonChip<TournamentType>(
      items: tournamentTypes,
      onChanged: (value) {
        setState(() {
          tournamentTypeController = value;
          tournamentCreateDTO.setType(value);
        });
      },
    );
  }

  _buildRadioButtonByeScore() {
    return RadioButtonChip<double>(
      fullWidth: true,
      items: byeScores,
      onChanged: tournamentCreateDTO.setByScore,
    );
  }

  _buildSnackBarFeedback(String messege, Color color) {
    return SnackBar(
      content: Text(messege, textAlign: TextAlign.center),
      backgroundColor: color,
      duration: const Duration(seconds: 1),
    );
  }
}
