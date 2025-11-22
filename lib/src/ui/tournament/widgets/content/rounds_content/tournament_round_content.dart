import 'package:chess_versus/src/ui/tournament/view_models/rounds/rounds_view_model.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../domain/models/tournament/tournament.dart';
import '../../../view_models/rounds/rounds_state.dart';

class TournamentRoundContent extends StatefulWidget {
  final RoundsViewModel _roundsViewModel;

  final String _tournamentId;
  final String? _roundId;

  const TournamentRoundContent({
    super.key,
    required RoundsViewModel roundsViewModel,
    required String tournamentId,
    String? roundId,
  }) : _roundsViewModel = roundsViewModel,
       _tournamentId = tournamentId,
       _roundId = roundId;

  @override
  State<TournamentRoundContent> createState() => _TournamentRoundContentState();
}

class _TournamentRoundContentState extends State<TournamentRoundContent> {
  final _log = Logger('TournamentRoundContent **');

  late Tournament tournament;

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
          var round = state.tournament.rounds.firstWhere(
            (round) => round.id == widget._roundId,
          );
          body =
              round.matches.isEmpty
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
                          round.matches.map((match) {
                            return Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 16,
                                  bottom: round.matches.last == match ? 16 : 0,
                                ),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  // tileColor: appTheme.blueGray700,
                                  //trailing: const Icon(Icons.chevron_right),
                                  title: Align(
                                    alignment: const Alignment(0.3, -0.5),
                                    child: Text(
                                      '${AppLocalizations.of(context)!.table} ${match.table}',
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
      },
    );
  }
}
