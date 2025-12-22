import 'package:chess_versus/src/ui/tournament/view_models/players/players_view_model.dart';
import 'package:chess_versus/src/ui/tournament/view_models/rounds/rounds_state.dart';
import 'package:chess_versus/src/ui/tournament/view_models/rounds/rounds_view_model.dart';
import 'package:flutter/material.dart';
import 'package:chess_versus/l10n/app_localizations.dart';

import '../../../../../config/assets.dart';
import '../../../../core/ui/compact_expansion_tile.dart';
import '../../../../core/ui/custom_image_view.dart';
import '../../../view_models/players/player_tap_state.dart';
import '../../../view_models/players/players_state.dart';

class TournamentClassificationContent extends StatefulWidget {
  final String _tournamentId;
  final PlayersViewModel _playersViewModel;
  final RoundsViewModel _roundsViewModel;

  const TournamentClassificationContent({
    super.key,
    required String tournamentId,
    required PlayersViewModel playersViewModel,
    required RoundsViewModel roundsViewModel,
  }) : _tournamentId = tournamentId,
       _playersViewModel = playersViewModel,
       _roundsViewModel = roundsViewModel;

  @override
  State<TournamentClassificationContent> createState() =>
      _TournamentClassificationContentState();
}

class _TournamentClassificationContentState
    extends State<TournamentClassificationContent> {
  // final _log = Logger('TournamentClassificationContent');

  @override
  void initState() {
    super.initState();
    widget._playersViewModel.getPlayers(widget._tournamentId);
    //widget._tournamentViewModel.assemblyTournament(widget._tournamentId);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget._playersViewModel,
      builder: (context, child) {
        Widget body = Container();
        final state = widget._playersViewModel.state;
        final stateTap = widget._playersViewModel.stateTap;
        final stateTournament = widget._roundsViewModel.state;
        if (state is LoadingPlayersState) {
          body = const Center(child: CircularProgressIndicator());
        } else if (state is FailurePlayersState) {
          body = Center(child: Text(state.message));
        } else if (state is IdlePlayersState) {
          // _log.fine('IdlePlayersState');
          body = Center(
            child: Text(
              'Não há jogadores cadastrados',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        } else if ((state is SuccessPlayersState) &&
            (stateTournament is SuccessRoundsState)) {
          //tournament.setPlayers = state.players;
          //_log.fine('SuccessPlayersState');
          var players = stateTournament.tournament.players;
          var tournament = stateTournament.tournament;
          tournament.updateScores();
          tournament.updateBuchholzScores();
          //print(tournament.toString());
          if (players.isEmpty) {
            body = Center(
              child: Text(
                AppLocalizations.of(context)!.thereAreNoRegisteredPlayers,
              ),
            );
          } else {
            // Ordena por pontuação
            players.sort((a, b) {
              if (a.score.toDouble != b.score.toDouble) {
                return b.score.toDouble.compareTo(
                  a.score.toDouble,
                ); // Ordem decrescente por pontuação
              }
              return b.buchholz.toDouble.compareTo(
                a.buchholz.toDouble,
              ); // Desempate por Buchholz
            });
            body = Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ListView(
                shrinkWrap: true,
                children: players.map((player) {
                  //var matchesss = tournament.getGamesPlayedByPlayer(player);
                  //_log.fine("   ***   ${player.name.toString()}   ***");
                  //_log.fine(matchesss.toString);
                  Color tileColor =
                      stateTap is PlayerTapped && stateTap.player == player
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context).colorScheme.primaryContainer;
                  return Align(
                    //alignment: Alignment.center,
                    child: Container(
                      //  width: 352.h,
                      margin: EdgeInsets.only(
                        top: 8,
                        bottom: players.last == player ? 8 : 0,
                      ),
                      child: ExpansionTile(
                        backgroundColor: tileColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildFirstSecondAndThirdPlace(
                              players.indexOf(player),
                            ),
                            Flexible(
                              flex: 3,
                              child: Text(
                                player.name.toString(),
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                player.score.toString(),
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Container(
                            color: Theme.of(context).colorScheme.primary,
                            padding: const EdgeInsets.only(top: 4, bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Buchholz',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  '${player.buchholz}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ), //
                          ),
                          CompactExpansionTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            //visualDensity: VisualDensity.compact,
                            title: Align(
                              alignment: const Alignment(0.15, -0.0),
                              child: Text(
                                AppLocalizations.of(context)!.rounds,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            children: [
                              ...tournament.getGamesPlayedByPlayer(player).map((
                                match,
                              ) {
                                var opponent = match.getOpponent(player);
                                var result = match.playerResult(player);
                                return Container(
                                  padding: const EdgeInsets.only(
                                    top: 4,
                                    bottom: 4,
                                    left: 8,
                                  ),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: Text(
                                          '${opponent?.name.toString()}  (${opponent?.score.toString()})',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40, // espaço reservado na Row
                                        child: Center(
                                          child: Container(
                                            height: 12,
                                            width: 12,
                                            color: match.isWhite(player)
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          result,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        }
        return body;
      },
    );
  }

  _buildFirstSecondAndThirdPlace(int index) {
    return Flexible(
      flex: 1,
      child: index > 2
          ? Text(
              '${index + 1}º  ',
              //textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            )
          : CustomImageView(
              imagePath: index == 0
                  ? IconAssets.iconFirstPlaceMedal
                  : index == 1
                  ? IconAssets.iconSecondPlaceMedal
                  : IconAssets.iconThirdPlaceMedal,
              height: 40,
              width: 40,
            ),
    );
  }
}
