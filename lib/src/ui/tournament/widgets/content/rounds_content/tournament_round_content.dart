import 'package:chess_versus/src/ui/core/ui/custom_elevated_mini_button.dart';
import 'package:chess_versus/src/ui/tournament/view_models/matches/matches_view_model.dart';
import 'package:flutter/material.dart';
import 'package:chess_versus/l10n/app_localizations.dart';
import 'package:flutter/services.dart';

import '../../../../../domain/models/player/player.dart';
import '../../../../../domain/models/round/round.dart';
import '../../../../../domain/models/tournament/tournament.dart';
import '../../../view_models/matches/match_state_tap.dart';
import '../../../../../domain/models/match/match.dart';

class TournamentRoundContent extends StatefulWidget {
  final Tournament _tournament;
  final Round _round;
  final MatchesViewModel _matchesViewModel;

  const TournamentRoundContent({
    super.key,
    required Tournament tournament,
    required Round round,
    required MatchesViewModel matchesViewModel,
  }) : _tournament = tournament,
       _round = round,
       _matchesViewModel = matchesViewModel;

  @override
  State<TournamentRoundContent> createState() => _TournamentRoundContentState();
}

class _TournamentRoundContentState extends State<TournamentRoundContent> {
  int? _byeTapped;
  @override
  Widget build(BuildContext context) {
    var viewModel = widget._matchesViewModel;
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        final matches = widget._round.matches;
        final stateTap = viewModel.stateTap;
        matches.sort((a, b) => a.table.compareTo(b.table));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...matches.map((match) {
              return _buildMatchResultRow(match, stateTap);
            }),
            widget._round.notPaired == null
                ? Row()
                : _buildByeMatch(widget._round.notPaired!, context),
          ],
        );
      },
    );
  }

  GestureDetector _buildMatchResultRow(Match match, MatchTapState stateTap) {
    Color tileColor = stateTap is MatchTapped && stateTap.match == match
        ? Theme.of(context).colorScheme.scrim
        : Theme.of(context).colorScheme.primaryContainer;
    Color boardColor = stateTap is MatchTapped && stateTap.match == match
        ? Theme.of(context).colorScheme.shadow
        : Theme.of(context).colorScheme.primary;

    TextStyle? style = (stateTap is MatchTapped && stateTap.match == match)
        ? Theme.of(context).textTheme.labelSmall
        : Theme.of(context).textTheme.displaySmall;

    return GestureDetector(
      onTap: () {
        var stateTap = widget._matchesViewModel.stateTap;
        if (stateTap is MatchTapped && stateTap.match == match) {
          widget._matchesViewModel.emitNoMatchTapped();
        } else {
          widget._matchesViewModel.emitMatchTapped(match);
        }
        setState(() {
          _byeTapped = null;
        });
      },
      onLongPress: () async {
        HapticFeedback.vibrate();
        await _buildShowDialogResult(match);
        widget._matchesViewModel.emitMatchTapped(match);
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
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            color: tileColor,
            child: __buildMatchResultRow(match: match, textStyle: style),
          ),
        ],
      ),
    );
  }

  Row __buildMatchResultRow({
    required Match match,
    required TextStyle? textStyle,
  }) {
    var result = _resultConversion(match.result);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '${match.white.name.toString()}   (${match.white.score.toString()})',
            style: textStyle,
            textAlign: TextAlign.left,
          ),
        ),

        Expanded(
          child: Text(result, textAlign: TextAlign.center, style: textStyle),
        ),
        Expanded(
          child: Text(
            '(${match.black.score.toString()})   ${match.black.name.toString()}',
            style: textStyle,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildByeMatch(Player notPaired, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_byeTapped == widget._round.matches.length) {
          setState(() {
            _byeTapped = null;
          });
          widget._matchesViewModel.emitNoMatchTapped();
        } else {
          widget._matchesViewModel.emitByeMatchTapped();
          setState(() {
            _byeTapped = widget._round.matches.length;
          });
        }
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.maxFinite,
            color: _byeTapped == widget._round.matches.length
                ? Theme.of(context).colorScheme.shadow
                : Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'BYE',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),

            color: _byeTapped == widget._round.matches.length
                ? Theme.of(context).colorScheme.scrim
                : Theme.of(context).colorScheme.primaryContainer,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${notPaired.name.toString()}   (${notPaired.score.toString()})',
                    style: _byeTapped == widget._round.matches.length
                        ? Theme.of(context).textTheme.labelSmall
                        : Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    ' ${widget._tournament.byeScore}   :   0.0 ',
                    style: _byeTapped == widget._round.matches.length
                        ? Theme.of(context).textTheme.labelSmall
                        : Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'BYE',
                    style: _byeTapped == widget._round.matches.length
                        ? Theme.of(context).textTheme.labelSmall
                        : Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _buildShowDialogResult(Match match) {
    return showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(
            AppLocalizations.of(context)!.result,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          content: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _buildCustomElevatadeButtonResult(match, Result.white),
              _buildCustomElevatadeButtonResult(match, Result.black),
              _buildCustomElevatadeButtonResult(match, Result.draw),
              _buildCustomElevatadeButtonResult(match, Result.woWhite),
              _buildCustomElevatadeButtonResult(match, Result.woBlack),
              _buildCustomElevatadeButtonResult(match, Result.bothLose),
            ],
          ),
        );
      },
      context: context,
    );
  }

  CustomElevatedMiniButton _buildCustomElevatadeButtonResult(
    Match match,
    Result result,
  ) {
    //var width = double.maxFinite * 0.5;
    String sResult = _resultConversion(result);
    return CustomElevatedMiniButton(
      text: sResult,
      //buttonStyle: CustomButtonStyle.fillOnPrimaryContainer,
      //buttonTextStyle: Theme.of(context).textTheme.bodySmall,
      width: 120,
      height: 50,
      onPressed: () async {
        setState(() {
          match.fillResult(result);
          widget._tournament.updateScores();
          widget._tournament.updateBuchholzScores();
        });

        Navigator.of(context).pop();

        await widget._matchesViewModel.updateMatch(match, widget._round.id);

        await widget._matchesViewModel.updatePlayersScore(
          widget._tournament.players,
          widget._tournament.id,
        );
      },
    );
  }

  String _resultConversion(Result? result) {
    String res;

    if (result == Result.white) {
      res = '1 : 0';
    } else if (result == Result.draw) {
      res = '0.5 : 0.5';
    } else if (result == Result.black) {
      res = '0 : 1';
    } else if (result == Result.woWhite) {
      res = '+ : -';
    } else if (result == Result.woBlack) {
      res = '- : +';
    } else if (result == Result.bothLose) {
      res = '0 : 0';
    } else {
      res = ':';
    }

    return res;
  }
}
