import 'package:chess_versus/src/ui/tournament/view_models/rounds/rounds_page_view_view_model.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../config/assets.dart';
import '../../../../core/ui/card_error.dart';
import '../../../../core/ui/custom_image_view.dart';
import '../../../view_models/tournament_get_state.dart';
import '../../../view_models/tournament_view_model.dart';

class TournamentRoundsContent extends StatefulWidget {
  final TournamentViewModel _tournamentViewModel;
  final RoundsPageViewViewModel _roundsPageViewViewModel;

  const TournamentRoundsContent(
      {super.key,
      required RoundsPageViewViewModel roundsPageViewViewModel,
      required TournamentViewModel tournamentViewModel})
      : _tournamentViewModel = tournamentViewModel,
        _roundsPageViewViewModel = roundsPageViewViewModel;

  @override
  State<TournamentRoundsContent> createState() =>
      _TournamentRoundsContentState();
}

class _TournamentRoundsContentState extends State<TournamentRoundsContent> {
  late Map<bool, List<Widget>> pages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    pages = {
      false: [_buildTournamentRoundsContent()],
      true: [
        ListenableBuilder(
            listenable: widget._tournamentViewModel,
            builder: (context, child) => _buildTournamentRoundsContent()),
      ]
    };
  }

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      floatingWidget: ListenableBuilder(
          listenable: widget._tournamentViewModel,
          builder: (context, child) {
            return FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {},
                child: CustomImageView(
                  color: Colors.white,
                  imagePath: IconAssets.iconSwordsRounded,
                  height: 40,
                  width: 40,
                ));
          }),
      floatingWidgetHeight: 60,
      floatingWidgetWidth: 60,
      mainScreenWidget: ListenableBuilder(
          listenable: widget._roundsPageViewViewModel,
          builder: (context, child) {
            return PageView(
              controller: widget._roundsPageViewViewModel.pageController,
              children: pages[false]!,
            );
          }),
    );
  }

  _buildTournamentRoundsContent() {
    var state = widget._tournamentViewModel.stateGet;
    Widget body = Container();

    if (state is LoadingTournamentGetState) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state is FailureTournamentGetState) {
      body = Center(child: CardError(message: state.message));
    } else if (state is SuccessTournamentGetState) {
      var tournament = state.tournament;
      body = tournament.rounds.isEmpty
          ? const Center(
              child: Text(
                'O torneio ainda não começou',
                textAlign: TextAlign.center,
              ),
            )
          : Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ListView(
                shrinkWrap: true,
                children: tournament.rounds.map((round) {
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 16,
                          bottom: tournament.rounds.last == round ? 16 : 0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // tileColor: appTheme.blueGray700,
                        trailing: const Icon(
                          Icons.chevron_right,
                        ),
                        title: Align(
                          alignment: const Alignment(0.3, -0.5),
                          child: Text(
                            '${round.roundNumber}ª RODADA',
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
    }
    return body;
  }
}
