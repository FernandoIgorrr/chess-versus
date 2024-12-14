import 'package:chess_versus/src/config/assets.dart';
import 'package:chess_versus/src/ui/tournament/view_models/tournament_view_model.dart';
import 'package:chess_versus/src/ui/tournament/widgets/content/players_content/view_models/player_view_model.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/models/player/player.dart';
import '../../../../../core/ui/custom_image_view.dart';
import '../../../../view_models/tournament_state.dart';
import '../view_models/player_state_tap.dart';
import '../view_models/players_state.dart';
import '../view_models/players_view_model.dart';
import 'player_form.dart';

// ignore: must_be_immutable
class TournamentPlayersContent extends StatefulWidget {
  final TournamentViewModel _tournamentViewModel;
  final PlayersViewModel _playersViewModel;
  const TournamentPlayersContent(
      {super.key,
      required PlayersViewModel playersViewModel,
      required TournamentViewModel tournamentViewModel})
      : _tournamentViewModel = tournamentViewModel,
        _playersViewModel = playersViewModel;

  @override
  State<TournamentPlayersContent> createState() =>
      _TournamentPlayersContentState();
}

class _TournamentPlayersContentState extends State<TournamentPlayersContent> {
  final _log = Logger('TournamentPlayersContent');
  @override
  void initState() {
    super.initState();
    widget._playersViewModel.getPlayers(
        (widget._tournamentViewModel.state as TournamentSuccessState)
            .tournament
            .getId);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget._playersViewModel,
      builder: (context, child) {
        Widget body = Container();
        final state = widget._playersViewModel.state;
        final stateTap = widget._playersViewModel.stateTap;

        if (state is LoadingPlayersState) {
          body = const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FailurePlayersState) {
          body = Center(
            child: Text(state.message),
          );
        } else if (state is IdlePlayersState) {
          _log.fine('IdlePlayersState');
          body = Center(
              child: Text(
            'Não há jogadores cadastrados',
            style: Theme.of(context).textTheme.bodyLarge,
          ));
        } else if (state is SuccessPlayersState) {
          //tournament.setPlayers = state.players;
          _log.fine('SuccessPlayersState');
          var players = state.players;
          body = Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ListView(
              shrinkWrap: true,
              children: players.map((player) {
                Color tileColor =
                    stateTap is PlayerTapped && stateTap.player == player
                        ? Colors.orange
                        : Colors.blueGrey;
                return Align(
                  //alignment: Alignment.center,
                  child: Container(
                    //  width: 352.h,
                    margin: EdgeInsets.only(
                        top: 16, bottom: players.last == player ? 16 : 0),
                    child: ListTile(
                      tileColor: tileColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      title: Row(children: <Widget>[
                        CustomImageView(
                          margin: const EdgeInsets.only(right: 16),
                          imagePath: IconAssets.iconPersonCircleOutline,
                          height: 40,
                          width: 40,
                          color: stateTap is PlayerTapped &&
                                  stateTap.player == player
                              ? Colors.white
                              : Colors.grey.shade400,
                        ),
                        Flexible(
                          child: Text(
                            player.getName.toString(),
                            style: stateTap is PlayerTapped &&
                                    stateTap.player == player
                                ? Theme.of(context).textTheme.titleSmall
                                : Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ]),
                      onTap: () {
                        widget._playersViewModel.emitPlayerTapped(player);
                      },
                      onLongPress: () {},
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
        return FloatingDraggableWidget(
          floatingWidgetHeight: 64,
          floatingWidgetWidth: 64,
          floatingWidget: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: CustomImageView(
              imagePath: IconAssets.iconUserAddFill,
              height: 48,
              width: 48,
            ),
            onPressed: () async {
              await _buildRegisterPlayerDialog(context);
            },
          ),
          mainScreenWidget: body,
        );
      },
    );
  }

  _buildRegisterPlayerDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return PlayerForm(
            tournamentViewModel: widget._tournamentViewModel,
            playerViewModel:
                PlayerViewModel(playerCreateUseCase: context.read()),
            playersViewModel: widget._playersViewModel,
          );
        });
  }
}
