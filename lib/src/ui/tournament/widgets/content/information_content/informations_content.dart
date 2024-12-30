import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

import '../../../../../domain/models/tournament/tournament.dart';
import '../../../../core/ui/card_error.dart';
import '../../../view_models/players/players_state.dart';
import '../../../view_models/players/players_view_model.dart';
import '../../../view_models/tournament_get_state.dart';
import '../../../view_models/tournament_view_model.dart';

// ignore: must_be_immutable
class TournamentInformationsContent extends StatefulWidget {
  final TournamentViewModel _tournamentViewModel;
  final PlayersViewModel _playersViewModel;

  const TournamentInformationsContent({
    super.key,
    required TournamentViewModel tournamentViewModel,
    required PlayersViewModel playersViewModel,
  })  : _tournamentViewModel = tournamentViewModel,
        _playersViewModel = playersViewModel;

  @override
  State<TournamentInformationsContent> createState() =>
      _TournamentInformationsContentState();
}

class _TournamentInformationsContentState
    extends State<TournamentInformationsContent> {
  final _log = Logger('TournamentInformationsContent');

  @override
  Widget build(BuildContext context) {
    var state = widget._tournamentViewModel.stateGet;
    Widget body = Container();

    if (state is IdleTournamentGetState) {
      _log.fine('IdleTournamentState');
      body = const Center(child: Text('Nenhum torneio selecionado'));
    } else if (state is LoadingTournamentGetState) {
      _log.fine('LoadingTournamentState');
      body = const Center(child: CircularProgressIndicator());
    } else if (state is FailureTournamentGetState) {
      body = Center(child: CardError(message: state.message));
    } else if (state is SuccessTournamentGetState) {
      final tournament = state.tournament;
      String numberOfPlayers = '-1';

      body = ListenableBuilder(
          listenable: widget._playersViewModel,
          builder: (context, child) {
            var playersState = widget._playersViewModel.state;
            if (playersState is LoadingPlayersState) {
              _log.fine('LoadingPlayersState');
              numberOfPlayers = "Calculating...";
            } else if (playersState is FailurePlayersState) {
              _log.fine('FailurePlayersState');
              numberOfPlayers = playersState.message;
            } else if (playersState is SuccessPlayersState) {
              _log.fine('SuccessPlayersState');
              numberOfPlayers = playersState.players.length.toString();
            }

            Map<String, String> data = {
              'Nome': tournament.name.toString(),
              'Tipo': tournament.type.toString(),
              'Data': DateFormat('dd/MM/yyyy').format(tournament.startedAt),
              'Status': tournament.status == TournamentStatus.created
                  ? 'Criado'
                  : (tournament.status == TournamentStatus.executing
                      ? 'Em andamento'
                      : 'Finalizado'),
              'Jogadores ativos': numberOfPlayers,
              /* 'inactive_players':
            tournament.getNumberOfDesqualifiedPlayers.toString(),*/
              'Nº de rodadas': tournament.totalNumberOfRounds == null
                  ? 'Nao informado'
                  : tournament.totalNumberOfRounds.toString(),
              /*'current_round': tournament.rounds.isEmpty
            ? 'Torneio não iniciado'
            : tournament.rounds.length.toString(),*/
              'Pontos por Bye': tournament.byeScore == null
                  ? 'Bye inativo'
                  : tournament.byeScore.toString(),
              'Bye': tournament.haveBye == null
                  ? 'Inativo'
                  : (tournament.haveBye! ? 'Ativo' : 'Inativo'),
            };

            return Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ListView(
                shrinkWrap: true,
                children: data.entries.map((entry) {
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: Text(entry.key,
                                style: Theme.of(context).textTheme.titleSmall),
                          ),
                        ),
                        ListTile(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          title: Text(
                            textAlign: TextAlign.center,
                            entry.value,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ]),
                    ),
                  );
                }).toList(),
              ),
            );
          });
    }

    return body;
  }
}
