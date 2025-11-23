import 'package:another_flushbar/flushbar.dart';
import 'package:chess_versus/src/ui/tournament/view_models/rounds/rounds_page_view_view_model.dart';
import 'package:chess_versus/src/ui/tournament/widgets/content/rounds_content/tournament_round_num_form.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../../../../l10n/app_localizations.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';

import '../../../../../config/assets.dart';
import '../../../../../domain/models/tournament/tournament.dart';
import '../../../../core/ui/custom_image_view.dart';
import '../../../view_models/rounds/rounds_state.dart';
import '../../../view_models/rounds/rounds_view_model.dart';

class TournamentRoundsContent extends StatefulWidget {
  final RoundsViewModel _roundsViewModel;
  final RoundsPageViewViewModel _roundsPageViewViewModel;

  final String _tournamentId;

  const TournamentRoundsContent({
    super.key,

    required String tournamentId,
    required RoundsViewModel roundsViewModel,
    required RoundsPageViewViewModel roundsPageViewViewModel,
  }) : _tournamentId = tournamentId,
       _roundsViewModel = roundsViewModel,
       _roundsPageViewViewModel = roundsPageViewViewModel;

  @override
  State<TournamentRoundsContent> createState() =>
      _TournamentRoundsContentState();
}

class _TournamentRoundsContentState extends State<TournamentRoundsContent> {
  final _log = Logger('TournamentRoundsContent **');

  @override
  void initState() {
    super.initState();
    widget._roundsViewModel.assemblyTournament(widget._tournamentId);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget._roundsViewModel,
      builder: (context, child) {
        Widget body = Container();

        final state = widget._roundsViewModel.state;
        if (state is IdleRoundsState) {
          body = Center(child: Text("Idle"));
          _log.fine('IdleRoundsState');
        }
        if (state is LoadingRoundsState) {
          body = const Center(child: CircularProgressIndicator());
          _log.fine('LoadingRoundsState');
        } else if (state is FailureRoundsState) {
          body = Center(child: Text(state.message));
          _log.fine('FailureRoundsState');
        } else if (state is SuccessRoundsState) {
          Widget content =
              state.tournament.rounds.isEmpty
                  ? Center(
                    child: Text(
                      AppLocalizations.of(context)!.tournamentHasntStartedYet,
                      textAlign: TextAlign.center,
                    ),
                  )
                  : Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ListView(
                      shrinkWrap: true,
                      children:
                          state.tournament.rounds.map((round) {
                            return Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 16,
                                  bottom:
                                      state.tournament.rounds.last == round
                                          ? 16
                                          : 0,
                                ),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  // tileColor: appTheme.blueGray700,
                                  trailing: const Icon(Icons.chevron_right),
                                  title: Align(
                                    alignment: const Alignment(0.3, -0.5),
                                    child: Text(
                                      '${round.roundNumber}º  ${AppLocalizations.of(context)!.round}',
                                    ),
                                  ),
                                  onTap: () {
                                    widget._roundsPageViewViewModel.selectRound(
                                      round.id,
                                    );
                                    widget._roundsPageViewViewModel
                                        .animateToPage(1);
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  );

          body = FloatingDraggableWidget(
            floatingWidgetWidth: 60,
            floatingWidgetHeight: 60,
            floatingWidget: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onPressed: () async {
                if (state.tournament.canItBeStarted) {
                  _log.fine('Tournmanet can it be started');
                  //  widget._roundsViewModel.assemblyTournament(
                  //    state.tournament.id,
                  //  );
                  await _buildRoundsNumDialog(context, state.tournament);
                  //widget._roundsViewModel.toPair(state.tournament.id);
                } else if (state.tournament.isExecuting) {
                  _log.fine('Tournmanet is executing');

                  Flushbar(
                    messageText: Text(
                      AppLocalizations.of(context)!.tournamentCantBeStarted,
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    duration: const Duration(seconds: 2),
                    flushbarPosition: FlushbarPosition.TOP,
                  ).show(context);
                } else if (state.tournament.isFinished) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    _buildSnackBarFeedback(
                      AppLocalizations.of(context)!.tournamentHasAlreadyEnded,
                      Colors.redAccent,
                    ),
                  );
                } else if (state.tournament.areLastRoundResultsFilled) {
                } else {}
              },

              child: CustomImageView(
                color: Colors.white,
                imagePath: IconAssets.iconSwordsRounded,
                height: 40,
                width: 40,
              ),
            ),
            mainScreenWidget: content,
          );

          _log.fine('SuccessRoundsState');
        }
        return body;
      },
    );
  }

  _buildSnackBarFeedback(String messege, Color color) {
    return SnackBar(
      content: Text(messege, textAlign: TextAlign.center),
      backgroundColor: color,
      duration: const Duration(seconds: 1),
    );
  }

  _buildRoundsNumDialog(BuildContext context, Tournament tournament) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return TournamentRoundNumForm(
          minNumRounds: tournament.minRoundsNum,
          maxNumRounds: tournament.maxRoundsNum,
          tournament: tournament,
          onPressed: () {
            //tournament.initiateTournament();
            widget._roundsViewModel.updateNumberOfRounds(tournament);
            widget._roundsViewModel.toPair(tournament.id);
            Navigator.pop(context);

            Flushbar(
              messageText: Text(
                AppLocalizations.of(context)!.tournamentStarted,
                textAlign: TextAlign.center,
              ),
              backgroundColor: Theme.of(context).colorScheme.surface,
              duration: const Duration(seconds: 2),
              flushbarPosition: FlushbarPosition.TOP,
            ).show(context);
          },
        );
      },
    );
  }
}
