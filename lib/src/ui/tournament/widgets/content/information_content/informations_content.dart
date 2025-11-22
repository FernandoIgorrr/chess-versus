import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

import '../../../../../domain/models/tournament/tournament.dart';
import '../../../../core/ui/card_error.dart';
import '../../../view_models/players/players_state.dart';
import '../../../view_models/players/players_view_model.dart';
import '../../../view_models/tournament_get_state.dart';
import '../../../view_models/tournament_view_model.dart';

// ignore: must_be_immutable
class TournamentInformationsContent extends StatefulWidget {
  final TournamentViewModel _tournamentViewModel;
  final PlayersViewModel _playersViewModel;

  const TournamentInformationsContent({
    super.key,
    required TournamentViewModel tournamentViewModel,
    required PlayersViewModel playersViewModel,
  }) : _tournamentViewModel = tournamentViewModel,
       _playersViewModel = playersViewModel;

  @override
  State<TournamentInformationsContent> createState() =>
      _TournamentInformationsContentState();
}

class _TournamentInformationsContentState
    extends State<TournamentInformationsContent> {
  final _log = Logger('TournamentInformationsContent');

  @override
  Widget build(BuildContext context) {
    var state = widget._tournamentViewModel.getState;
    Widget body = Container();

    if (state is IdleTournamentGetState) {
      _log.fine('IdleTournamentState');
      body = const Center(child: Text('Nenhum torneio selecionado'));
    } else if (state is LoadingTournamentGetState) {
      _log.fine('LoadingTournamentState');
      body = const Center(child: CircularProgressIndicator());
    } else if (state is FailureTournamentGetState) {
      body = Center(child: CardError(message: state.message));
    } else if (state is SuccessTournamentGetState) {
      final tournament = state.tournament;
      String numberOfPlayers = '-1';

      body = ListenableBuilder(
        listenable: widget._playersViewModel,
        builder: (context, child) {
          var playersState = widget._playersViewModel.state;
          if (playersState is LoadingPlayersState) {
            _log.fine('LoadingPlayersState');
            numberOfPlayers = "Calculating...";
          } else if (playersState is FailurePlayersState) {
            _log.fine('FailurePlayersState');
            numberOfPlayers = playersState.message;
          } else if (playersState is SuccessPlayersState) {
            _log.fine('SuccessPlayersState');
            numberOfPlayers = playersState.players.length.toString();
          }

          Map<String, String> data = {
            AppLocalizations.of(context)!.name: tournament.name.toString(),
            AppLocalizations.of(context)!.tournamentDescription:
                tournament.description ?? '',
            AppLocalizations.of(context)!.tournamentType:
                tournament.type.toString(),
            AppLocalizations.of(context)!.tournamentStartDate: DateFormat(
              'dd/MM/yyyy',
            ).format(tournament.startedAt),
            'Status':
                tournament.status == TournamentStatus.created
                    ? AppLocalizations.of(context)!.created
                    : (tournament.status == TournamentStatus.executing
                        ? AppLocalizations.of(context)!.inProgress
                        : AppLocalizations.of(context)!.finished),
            AppLocalizations.of(context)!.activePlayers: numberOfPlayers,
            /* 'inactive_players':
            tournament.getNumberOfDesqualifiedPlayers.toString(),*/
            AppLocalizations.of(context)!.numberOfRounds:
                tournament.totalNumberOfRounds == null
                    ? AppLocalizations.of(context)!.notDefined
                    : tournament.totalNumberOfRounds.toString(),
            /*'current_round': tournament.rounds.isEmpty
            ? 'Torneio não iniciado'
            : tournament.rounds.length.toString(),*/
            AppLocalizations.of(context)!.scorePerBye:
                tournament.byeScore == null
                    ? AppLocalizations.of(context)!.byeInactive
                    : tournament.byeScore.toString(),
            'Bye':
                tournament.haveBye == null
                    ? AppLocalizations.of(context)!.inactive
                    : (tournament.haveBye!
                        ? AppLocalizations.of(context)!.active
                        : AppLocalizations.of(context)!.inactive),
          };

          return Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ListView(
              shrinkWrap: true,
              children:
                  data.entries.map((entry) {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  entry.key,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                            ListTile(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              title: Text(
                                textAlign: TextAlign.center,
                                entry.value,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          );
        },
      );
    }

    return body;
  }
}
