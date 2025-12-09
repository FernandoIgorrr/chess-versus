import 'package:chess_versus/src/ui/tournament/view_models/players/players_view_model.dart';
import 'package:flutter/material.dart';
import 'package:chess_versus/l10n/app_localizations.dart';
import 'package:logging/logging.dart';

import '../../../../../config/assets.dart';
import '../../../../core/ui/custom_image_view.dart';
import '../../../view_models/players/player_tap_state.dart';
import '../../../view_models/players/players_state.dart';
import '../../../view_models/tournament_get_state.dart';
import '../../../view_models/tournament_view_model.dart';

class TournamentClassificationContent extends StatefulWidget {
  final TournamentViewModel _tournamentViewModel;
  final PlayersViewModel _playersViewModel;

  const TournamentClassificationContent({
    super.key,
    required TournamentViewModel tournamentViewModel,
    required PlayersViewModel playersViewModel,
  }) : _tournamentViewModel = tournamentViewModel,
       _playersViewModel = playersViewModel;

  @override
  State<TournamentClassificationContent> createState() =>
      _TournamentClassificationContentState();
}

class _TournamentClassificationContentState
    extends State<TournamentClassificationContent> {
  final _log = Logger('TournamentClassificationContent');

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget._playersViewModel,
      builder: (context, child) {
        Widget body = Container();
        final state = widget._playersViewModel.state;
        final stateTap = widget._playersViewModel.stateTap;

        if (state is LoadingPlayersState) {
          body = const Center(child: CircularProgressIndicator());
        } else if (state is FailurePlayersState) {
          body = Center(child: Text(state.message));
        } else if (state is IdlePlayersState) {
          _log.fine('IdlePlayersState');
          body = Center(
            child: Text(
              'Não há jogadores cadastrados',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        } else if (state is SuccessPlayersState) {
          //tournament.setPlayers = state.players;
          _log.fine('SuccessPlayersState');
          var players = state.players;

          if (players.isEmpty) {
            body = Center(
              child: Text(
                AppLocalizations.of(context)!.thereAreNoRegisteredPlayers,
              ),
            );
          } else {
            // ordenar por pontuação
            players.sort(
              (a, b) => b.score.toDouble.compareTo(a.score.toDouble),
            );
            body = Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ListView(
                shrinkWrap: true,
                children:
                    players.map((player) {
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
                                    style:
                                        Theme.of(
                                          context,
                                        ).textTheme.displaySmall,
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
                                padding: const EdgeInsets.only(
                                  top: 4,
                                  bottom: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Buchholz: ',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      '${player.buchholz}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ), //
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
      child:
          index > 2
              ? Text(
                '${index + 1}º  ',
                //textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              )
              : CustomImageView(
                imagePath:
                    index == 0
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
