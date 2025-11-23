import 'package:chess_versus/src/ui/tournament/view_models/tournament_view_model.dart';
import 'package:chess_versus/src/ui/tournament/view_models/players/player_state.dart';
import 'package:chess_versus/src/ui/tournament/view_models/players/player_view_model.dart';
import 'package:chess_versus/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/custom_elevated_button.dart';
import '../../../../core/ui/custom_text_form_field.dart';
import '../../../view_models/tournament_get_state.dart';
import '../../../view_models/players/players_view_model.dart';

class PlayerForm extends StatefulWidget {
  final TournamentViewModel _tournamentViewModel;
  final PlayersViewModel _playersViewModel;
  final PlayerViewModel _playerViewModel;

  const PlayerForm({
    super.key,
    required PlayerViewModel playerViewModel,
    required PlayersViewModel playersViewModel,
    required TournamentViewModel tournamentViewModel,
  }) : _tournamentViewModel = tournamentViewModel,
       _playersViewModel = playersViewModel,
       _playerViewModel = playerViewModel;

  @override
  State<PlayerForm> createState() => _PlayerFormState();
}

class _PlayerFormState extends State<PlayerForm> {
  final formKey = GlobalKey<FormState>();
  FormState get form => formKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.addPlayer,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: CustomTextFormField(
          //value: widget._playerViewModel.player.getName.toString(),
          controller: TextEditingController(
            text: widget._playerViewModel.player.name.toString(),
          ),
          hintText: AppLocalizations.of(context)!.playerNmae,
          validator: (v) => widget._playerViewModel.player.name.validator(),
          onChange: widget._playerViewModel.player.setName,
        ),
      ),
      actions: [
        CustomElevatedButton(
          text: AppLocalizations.of(context)!.add,
          onPressed: () async {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            if (kDebugMode) {
              print(widget._playerViewModel.player);
            }
            if (form.validate()) {
              await widget._playerViewModel.create(
                widget._playerViewModel.player,
                (widget._tournamentViewModel.getState
                        as SuccessTournamentGetState)
                    .tournament
                    .id,
              );
              final state = widget._playerViewModel.state;

              if (state is SuccessPlayerState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  _buildSnackBarFeedback(
                    AppLocalizations.of(context)!.playerAddeddSuccessfully,
                    Theme.of(context).colorScheme.scrim,
                  ),
                );

                widget._playersViewModel.getPlayers(
                  (widget._tournamentViewModel.getState
                          as SuccessTournamentGetState)
                      .tournament
                      .id,
                );

                widget._playerViewModel.emptyPlayer();
                setState(() {
                  widget._playerViewModel.player.setName('');
                });
              } else if (state is FailurePlayerState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(_buildSnackBarError(state.message));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                _buildSnackBarError(AppLocalizations.of(context)!.invalidData),
              );
            }
          },
          //Navigator.of(context).pop();
        ),
      ],
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
