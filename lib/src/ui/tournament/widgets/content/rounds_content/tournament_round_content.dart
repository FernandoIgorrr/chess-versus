import 'package:chess_versus/src/ui/tournament/view_models/matches/matches_view_model.dart';
import 'package:flutter/material.dart';
import 'package:chess_versus/l10n/app_localizations.dart';

import '../../../../../domain/models/round/round.dart';
import '../../../view_models/matches/match_state_tap.dart';

class TournamentRoundContent extends StatefulWidget {
  final double _byeScore;
  final Round _round;
  final MatchesViewModel _matchesViewModel;

  const TournamentRoundContent({
    super.key,
    required double byeScore,
    required Round round,
    required MatchesViewModel matchesViewModel,
  }) : _byeScore = byeScore,
       _round = round,
       _matchesViewModel = matchesViewModel;

  @override
  State<TournamentRoundContent> createState() => _TournamentRoundContentState();
}

class _TournamentRoundContentState extends State<TournamentRoundContent> {
  int? _byeTapped;
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget._matchesViewModel,
      builder: (context, child) {
        final stateTap = widget._matchesViewModel.stateTap;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            // Use CrossAxisAlignment.start para alinhar corretamente
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widget._round.matches.map((match) {
                Color tileColor =
                    stateTap is MatchTapped && stateTap.match == match
                        ? Theme.of(context).colorScheme.tertiary
                        : (widget._round.matches.length % 2 == 0
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context).colorScheme.surface);

                TextStyle? style =
                    (stateTap is MatchTapped && stateTap.match == match)
                        ? Theme.of(context).textTheme.labelSmall
                        : Theme.of(context).textTheme.displaySmall;

                return GestureDetector(
                  onTap: () {
                    widget._matchesViewModel.emitMatchTapped(match);
                    setState(() {
                      _byeTapped = null;
                    });
                  },
                  child: Container(
                    color: tileColor,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(match.white.name.toString(), style: style),
                        match.result == null
                            ? Text(':', style: style)
                            : Text(' 1 : 0 '),
                        Text(match.black.name.toString(), style: style),
                      ],
                    ),
                  ),
                );
              }),
              widget._round.notPaired == null
                  ? Row()
                  : GestureDetector(
                    onTap: () {
                      widget._matchesViewModel.emitByeMatchTapped();
                      setState(() {
                        _byeTapped = widget._round.matches.length;
                      });
                    },
                    child: Container(
                      color:
                          _byeTapped == widget._round.matches.length
                              ? Theme.of(context).colorScheme.tertiary
                              : (widget._round.matches.length % 2 == 0
                                  ? Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer
                                  : Theme.of(context).colorScheme.surface),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget._round.notPaired!.name.toString(),
                            style:
                                _byeTapped == widget._round.matches.length
                                    ? Theme.of(context).textTheme.labelSmall
                                    : Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(
                            ' ${widget._byeScore} : 0.0 ',
                            style:
                                _byeTapped == widget._round.matches.length
                                    ? Theme.of(context).textTheme.labelSmall
                                    : Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(
                            'BYE',
                            style:
                                _byeTapped == widget._round.matches.length
                                    ? Theme.of(context).textTheme.labelSmall
                                    : Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}
