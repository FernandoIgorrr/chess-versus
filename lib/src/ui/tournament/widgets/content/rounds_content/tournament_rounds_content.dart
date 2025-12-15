import 'package:another_flushbar/flushbar.dart';
import 'package:chess_versus/src/ui/tournament/widgets/content/rounds_content/tournament_round_num_form.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../../../../l10n/app_localizations.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';

import '../../../../../config/assets.dart';
import '../../../../../domain/models/tournament/tournament.dart';
import '../../../../core/ui/custom_image_view.dart';
import '../../../view_models/matches/matches_view_model.dart';
import '../../../view_models/rounds/round_tap_state.dart';
import '../../../view_models/rounds/rounds_state.dart';
import '../../../view_models/rounds/rounds_view_model.dart';
import 'tournament_round_content.dart';

class TournamentRoundsContent extends StatefulWidget {
  final RoundsViewModel _roundsViewModel;
  final MatchesViewModel _matchesViewModel;
  final String _tournamentId;

  const TournamentRoundsContent({
    super.key,
    required String tournamentId,
    required RoundsViewModel roundsViewModel,
    required MatchesViewModel matchesViewModel,
  }) : _tournamentId = tournamentId,
       _roundsViewModel = roundsViewModel,
       _matchesViewModel = matchesViewModel;
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
    var viewModel = widget._roundsViewModel;
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        Widget body = Container();
        final state = viewModel.state;
        final stateTap = viewModel.stateTap;
        if (state is IdleRoundsState) {
          body = Center(child: Text("Idle"));
          //_log.fine('IdleRoundsState');
        }
        if (state is LoadingRoundsState) {
          body = const Center(child: CircularProgressIndicator());
          //_log.fine('LoadingRoundsState');
        } else if (state is FailureRoundsState) {
          body = Center(child: Text(state.message));
          // _log.fine('FailureRoundsState');
        } else if (state is SuccessRoundsState) {
          var tournament = state.tournament;
          var rounds = tournament.rounds;
          Widget content = rounds.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.tournamentHasntStartedYet,
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),

                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView(
                          shrinkWrap: true,
                          children: rounds.map((round) {
                            Color tileColor =
                                stateTap is RoundTapped &&
                                    stateTap.round == round
                                ? Theme.of(context).colorScheme.tertiary
                                : Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer;
                            return Align(
                              //alignment: Alignment.center,
                              child: Container(
                                //  width: 352.h,
                                margin: EdgeInsets.only(
                                  top: 16,
                                  bottom: rounds.last == round ? 8 : 0,
                                ),
                                child: ExpansionTile(
                                  backgroundColor: tileColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Align(
                                    alignment: const Alignment(0.15, -0.0),
                                    child: Text(
                                      textAlign: TextAlign.center,

                                      '${round.roundNumber}º  ${AppLocalizations.of(context)!.round}',
                                    ),
                                  ),
                                  children: <Widget>[
                                    Container(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      child: TournamentRoundContent(
                                        tournament: tournament,
                                        round: round,
                                        matchesViewModel:
                                            widget._matchesViewModel,
                                      ), //
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
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
                /// *** FIRST IF STATUS [CREATED] ***
                //_log.fine(tournament.rounds.toString());
                if (tournament.status == TournamentStatus.created) {
                  if (tournament.canItBeStarted) {
                    await _buildRoundsNumDialog(context, tournament);
                    await viewModel.updateTournament(tournament);
                    await viewModel.assemblyTournament(tournament.id);
                  } else if (tournament.cantItBeStarted) {
                    _buildFlushBarErroFeedback(
                      erroTitle: AppLocalizations.of(
                        context,
                      )!.tournamentCantBeStarted,
                      erroMessage: AppLocalizations.of(
                        context,
                      )!.toStartTheTournamentYouNeedAtLeastThreePlayers,
                    );
                  }

                  /// *** SECOND IF STATUS [EXECUTING] ***
                } else if (tournament.status == TournamentStatus.executing) {
                  if (tournament.areLastRoundResultsFilled) {
                    if (tournament.allRoundsPairing) {
                      _buildFlushBarErroFeedback(
                        erroTitle: AppLocalizations.of(
                          context,
                        )!.allRoundsHaveAlreadyBeenPaired,
                        erroMessage: '',
                      );
                    } else {
                      viewModel.toPair(tournament);
                      await viewModel.updateTournament(tournament);
                      await viewModel.assemblyTournament(tournament.id);
                    }
                  } else {
                    _buildFlushBarErroFeedback(
                      erroTitle: AppLocalizations.of(
                        context,
                      )!.tournamentCantBePaired,
                      erroMessage: AppLocalizations.of(
                        context,
                      )!.lastRoundResultsDontFilled,
                    );
                  }

                  /// *** SECOND IF STATUS [FINISHED] ***
                } else if (tournament.status == TournamentStatus.finished) {
                  _buildFlushBarErroFeedback(
                    erroTitle: AppLocalizations.of(
                      context,
                    )!.tournamentHasAlreadyEnded,
                  );
                }
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

          //_log.fine('SuccessRoundsState');
        }
        return body;
      },
    );
  }

  Future<Widget?> _buildRoundsNumDialog(
    BuildContext context,
    Tournament tournament,
  ) {
    return showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return TournamentRoundNumForm(
          minNumRounds: tournament.minRoundsNum,
          maxNumRounds: tournament.maxRoundsNum,
          tournament: tournament,
          onPressed: () {
            //tournament.initiateTournament();
            //await widget._roundsViewModel.updateTournament(tournament);
            widget._roundsViewModel.toPair(tournament);

            Navigator.pop(context);

            if (mounted) {
              _buildFlushBarFeedback(
                message: AppLocalizations.of(context)!.tournamentStarted,
              );
            }
          },
        );
      },
    );
  }

  Future<dynamic> _buildFlushBarFeedback({
    required String message,
    FlushbarPosition? flushbarPosition,
  }) {
    return Flushbar(
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).colorScheme.onError),
      ),
      backgroundColor: Theme.of(context).colorScheme.scrim,
      duration: const Duration(seconds: 2),
      flushbarPosition: flushbarPosition ?? FlushbarPosition.TOP,
    ).show(context);
  }

  Future<dynamic> _buildFlushBarErroFeedback({
    String? erroTitle,
    String? erroMessage,
    FlushbarPosition? flushbarPosition,
  }) {
    return Flushbar(
      messageText: Column(
        children: [
          erroTitle == null
              ? Container()
              : Text(
                  erroTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
          erroMessage == null
              ? Container()
              : Text(
                  erroMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                    fontSize: 14,
                  ),
                ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.error,
      duration: const Duration(milliseconds: 2500),
      flushbarPosition: flushbarPosition ?? FlushbarPosition.TOP,
    ).show(context);
  }
}
