import 'package:chess_versus/src/config/assets.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/ui/custom_app_bar.dart';
import '../../../../../core/ui/custom_image_view.dart';
import '../view_models/player_state_tap.dart';
import '../view_models/players_state.dart';
import '../view_models/players_view_model.dart';

// ignore: must_be_immutable
class TournamentPlayersContent extends StatefulWidget {
  final PlayersViewModel _viewModel;
  const TournamentPlayersContent(
      {super.key, required PlayersViewModel viewModel})
      : _viewModel = viewModel;

  @override
  // ignore: library_private_types_in_public_api
  _TournamentPlayersContentState createState() =>
      _TournamentPlayersContentState();
}

class _TournamentPlayersContentState extends State<TournamentPlayersContent> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget._viewModel,
      builder: (context, child) {
        Widget body = Container();
        final state = widget._viewModel.state;
        final stateTap = widget._viewModel.stateTap;

        if (state is LoadingPlayersState) {
          body = const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FailurePlayersState) {
          body = Center(
            child: Text(state.message),
          );
        } else if (state is IdlePlayersState) {
          body = Center(
              child: Text(
            'Não há jogadores cadastrados',
            style: Theme.of(context).textTheme.bodyLarge,
          ));
        } else if (state is SuccessPlayerState) {
          //tournament.setPlayers = state.players;
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
                            player.name,
                            style: stateTap is PlayerTapped &&
                                    stateTap.player == player
                                ? Theme.of(context).textTheme.titleSmall
                                : Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ]),
                      onTap: () {
                        widget._viewModel.emitPlayerTapped(player);
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
            onPressed: null,
            child: CustomImageView(
              imagePath: IconAssets.iconUserAddFill,
              height: 48,
              width: 48,
            ),
          ),
          mainScreenWidget: body,
        );
      },
    );
  }
}
