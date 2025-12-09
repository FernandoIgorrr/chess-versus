import 'package:chess_versus/src/ui/tournament/view_models/matches/matches_view_model.dart';
import 'package:flutter/material.dart';
import 'package:chess_versus/l10n/app_localizations.dart';

import '../../../../../domain/models/round/round.dart';
import '../../../view_models/matches/match_state_tap.dart';
import '../../../../../domain/models/match/match.dart';

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
        return Container(
          //color: Theme.of(context).colorScheme.primary,
          //padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widget._round.matches.map((match) {
                Color tileColor =
                    stateTap is MatchTapped && stateTap.match == match
                        ? Theme.of(context).colorScheme.scrim
                        : Theme.of(context).colorScheme.primaryContainer;
                Color boardColor =
                    stateTap is MatchTapped && stateTap.match == match
                        ? Theme.of(context).colorScheme.shadow
                        : Theme.of(context).colorScheme.primary;

                TextStyle? boardStyle =
                    (stateTap is MatchTapped && stateTap.match == match)
                        ? Theme.of(context).textTheme.bodySmall
                        : Theme.of(context).textTheme.titleSmall;

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
                  child: Column(
                    children: [
                      Container(
                        color: boardColor,
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        //color: Theme.of(context).colorScheme.primary,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          style: Theme.of(context).textTheme.displayMedium,
                          '${AppLocalizations.of(context)!.board}   ${match.table}',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        color: tileColor,
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
                    ],
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
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          color:
                              _byeTapped == widget._round.matches.length
                                  ? Theme.of(context).colorScheme.shadow
                                  : Theme.of(context).colorScheme.primary,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'BYE',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 16),

                          color:
                              _byeTapped == widget._round.matches.length
                                  ? Theme.of(context).colorScheme.scrim
                                  : Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget._round.notPaired!.name.toString(),
                                style:
                                    _byeTapped == widget._round.matches.length
                                        ? Theme.of(context).textTheme.labelSmall
                                        : Theme.of(
                                          context,
                                        ).textTheme.displaySmall,
                              ),
                              Text(
                                ' ${widget._byeScore} : 0.0 ',
                                style:
                                    _byeTapped == widget._round.matches.length
                                        ? Theme.of(context).textTheme.labelSmall
                                        : Theme.of(
                                          context,
                                        ).textTheme.displaySmall,
                              ),
                              Text(
                                'BYE',
                                style:
                                    _byeTapped == widget._round.matches.length
                                        ? Theme.of(context).textTheme.labelSmall
                                        : Theme.of(
                                          context,
                                        ).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }

  _buildDrawMatch(Match match) {
    String res;
    if (!match.hasResult) {
      res = 'X';
    } else if (match.result == Result.white) {
      res = '1   :   0';
    } else if (match.result == Result.draw) {
      res = '0.5  :  0.5';
    } else if (match.result == Result.black) {
      res = '0   :   1';
    } else if (match.result == Result.woWhite) {
      res = '+   :   -';
    } else if (match.result == Result.woBlack) {
      res = '-   :   +';
    } else if (match.result == Result.bothLose) {
      res = '0   :   0';
    } else {
      res = '0   :   0';
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '${match.table}.  ${match.white.name} (${match.white.score})',
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(child: Text(res, textAlign: TextAlign.center)),
        Expanded(
          child: Text(
            '(${match.black.score})  ${match.black.name}',
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
