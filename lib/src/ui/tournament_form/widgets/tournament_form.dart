import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../config/assets.dart';
import '../../../domain/models/tournament/tournament.dart';
import '../../../domain/models/tournament/tournament_create_dto.dart';
import '../../../domain/models/tournament/tournament_type.dart';
import '../../core/theme_config/dimends.dart';
import '../../core/ui/custom_elevated_button.dart';
import '../../core/ui/custom_image_view.dart';
import '../../core/ui/custom_radio_button.dart';
import '../../core/ui/custom_text_form_field.dart';
import '../view_models/form_state.dart';
import '../view_models/tournament_form_view_model.dart';

class TournamentForm extends StatefulWidget {
  final TournamentFormViewModel viewModel;

  const TournamentForm({super.key, required this.viewModel});

  @override
  State<TournamentForm> createState() => _TournamentFormState();
}

class _TournamentFormState extends State<TournamentForm> {
  TextEditingController dateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<TournamentType> tournamentTypes = <TournamentType>[
    Swiss(0.0),
    Elimination(),
    RoundRobin()
  ];
  List<double> byeScores = <double>[0.0, 0.5, 1.0];
  late Tournament tournament;
  late TournamentCreateDTO tournamentCreateDTO;

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    tournamentCreateDTO = TournamentCreateDTO.empty();

    widget.viewModel.addListener(() {
      final state = widget.viewModel.state;
      if (state is TournamentFormSuccessState) {
        Navigator.pop(context);
      } else if (state is TournamentFormFailureState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      }
    });
  }

  FormState get form => formKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 24),
                  _buildNameTextFormField(),
                  const SizedBox(height: 16),
                  _buildDescriptionTextFormField(),
                  const SizedBox(height: 16),
                  _buildStartedAtTextFormField(),
                  const SizedBox(height: 16),
                  _buildTournamentTypeSection(),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: tournamentCreateDTO.getType is Swiss
                        ? Column(children: [
                            const SizedBox(
                              height: 16,
                            ),
                            _buildByeScoreSection()
                          ])
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();

                      if (kDebugMode) {
                        print(tournamentCreateDTO);
                      }
                      if (form.validate()) {
                        await widget.viewModel
                            .createTournament(tournamentCreateDTO);
                        final state = widget.viewModel.state;

                        if (state is TournamentFormSuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              _buildSnackBarFeedback(
                                  AppLocalizations.of(context)!
                                      .tournamentRegisteredSuccessfully,
                                  Colors.greenAccent));
                        } else if (state is TournamentFormFailureState) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(_buildSnackBarError(state.message));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            _buildSnackBarError(
                                AppLocalizations.of(context)!.invalidData));
                      }
                    },
                    text: AppLocalizations.of(context)!.registerTournament,
                    buttonTextStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
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

  _buildStartedAtTextFormField() {
    return CustomTextFormField(
      textStyle: Theme.of(context).textTheme.bodyMedium,
      readonly: true,
      onTap: () => _buildSelectDate(),
      controller: dateController,
      suffix: IconButton(
        icon: CustomImageView(
          width: 24,
          height: 24,
          imagePath: IconAssets.iconCalendar,
          fit: BoxFit.contain,
          color: Theme.of(context).colorScheme.secondary,
        ),
        onPressed: () => _buildSelectDate(),
      ),
    );
  }

  Future<void> _buildSelectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().month),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) {
          return FittedBox(
            child: Theme(
                data: ThemeData(
                  colorScheme: Theme.of(context).colorScheme,
                ),
                child: child!),
          );
        });
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
        tournamentCreateDTO.setStartedAt(picked);
      });
    }
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

  _buildRadioButtonTournamentType() {
    return RadioButtonChip<TournamentType>(
      items: tournamentTypes,
      onChanged: (value) {
        setState(() {
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

  _buildSnackBarError(String messege) {
    return _buildSnackBarFeedback(messege, Theme.of(context).colorScheme.error);
  }
}
