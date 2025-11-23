import 'package:chess_versus/src/ui/tournament/view_models/rounds/rounds_view_model.dart';
import 'package:chess_versus/src/ui/tournament/widgets/content/rounds_content/tournament_rounds_content.dart';
import 'package:flutter/material.dart';

import '../../../view_models/rounds/rounds_page_view_view_model.dart';

import 'tournament_round_content.dart';

class TournamentRoundsPage extends StatefulWidget {
  final RoundsPageViewViewModel _pageViewViewModel;
  final RoundsViewModel _roundsViewModel;
  final String _tournamentId;
  String? _roundId;

  TournamentRoundsPage({
    super.key,
    required RoundsPageViewViewModel pageViewViewModel,
    required RoundsViewModel roundsViewModel,
    required String tournamentId,
  }) : _tournamentId = tournamentId,
       _pageViewViewModel = pageViewViewModel,
       _roundsViewModel = roundsViewModel,
       _roundId = pageViewViewModel.selectedRoundId;

  @override
  State<TournamentRoundsPage> createState() => _TournamentRoundsPageState();
}

class _TournamentRoundsPageState extends State<TournamentRoundsPage> {
  late Map<int, Widget> content;

  @override
  void initState() {
    super.initState();
    //widget._roundsViewModel.assemblyTournament(widget.tournamentId);
    widget._roundId = widget._pageViewViewModel.selectedRoundId;

    if (widget._roundId == null) {
      content = {
        0: TournamentRoundsContent(
          tournamentId: widget._tournamentId,
          roundsViewModel: widget._roundsViewModel,
          roundsPageViewViewModel: widget._pageViewViewModel,
        ),
      };
    } else {
      content = {
        0: TournamentRoundsContent(
          tournamentId: widget._tournamentId,
          roundsViewModel: widget._roundsViewModel,
          roundsPageViewViewModel: widget._pageViewViewModel,
        ),
        1: TournamentRoundContent(
          roundsViewModel: widget._roundsViewModel,
          roundId: widget._roundId!,
          tournamentId: widget._tournamentId,
        ),
      };
    }

    widget._pageViewViewModel.emit(
      widget._pageViewViewModel.pageController.initialPage,
    );
  }

  @override
  void didUpdateWidget(covariant TournamentRoundsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget._pageViewViewModel,
      builder: (context, child) {
        if (widget._roundId == null) {
          content = {
            0: TournamentRoundsContent(
              tournamentId: widget._tournamentId,
              roundsViewModel: widget._roundsViewModel,
              roundsPageViewViewModel: widget._pageViewViewModel,
            ),
          };
        } else {
          content = {
            0: TournamentRoundsContent(
              tournamentId: widget._tournamentId,
              roundsViewModel: widget._roundsViewModel,
              roundsPageViewViewModel: widget._pageViewViewModel,
            ),
            1: TournamentRoundContent(
              roundsViewModel: widget._roundsViewModel,
              roundId: widget._roundId!,
              tournamentId: widget._tournamentId,
            ),
          };
        }
        return PageView(
          controller: widget._pageViewViewModel.pageController,
          onPageChanged: widget._pageViewViewModel.emit,
          children: [...content.values],
        );
      },
    );
  }
}
