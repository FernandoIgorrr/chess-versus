import 'dart:math';

import 'package:chess_versus/src/data/exceptions/last_round_missing_exception.dart';
import 'package:chess_versus/src/data/exceptions/tournament_max_rounds_excpetion.dart';
import 'package:chess_versus/src/ui/core/chess_tuple.dart';
import 'package:uuid/uuid.dart';

import '../../value_objects/name.dart';
import '../../value_objects/score.dart';
import '../player/player.dart';
import '../round/round.dart';
// ignore: library_prefixes
import 'package:chess_versus/src/domain/models/match/match.dart';
import 'tournament_type.dart';

class Tournament {
  /// Tournament identifier
  final String _id;

  /// Tournament name to display
  Name _name;

  /// Tournament description to display
  String? _description;

  /// Tournament start date
  DateTime _startedAt;

  /// Tournament type
  final TournamentType _type;

  ///list of players from the tournament
  List<Player> _players;

  /// Total number of rounds
  int? _totalNumberOfRounds; // number of rounds

  /// List of rounds from the tournament
  List<Round> _rounds;

  /// Tournament status. Represents the progress of the tournament.
  /// if it's executing or if it's finished, if can add more players...
  TournamentStatus _status;

  /// Represents whether the tournament has a bye (to adjust the pairing
  ///  in tournaments with an odd number of players) or not
  /// (only legs in Swiss tournaments)
  bool? _haveBye;

  ///If the tournament was arquived
  bool _arquived;

  Tournament({
    String? id,
    required String name,
    String? description,
    required DateTime startedAt,
    required TournamentType type,
    List<Player>? players,
    List<Round>? rounds,
  }) : _id = id ?? const Uuid().v4(),
       _name = Name(name),
       _description = description,
       _startedAt = startedAt,
       _type = type,
       _status = TournamentStatus.created,
       _players = players ?? <Player>[],
       _rounds = rounds ?? <Round>[],
       _arquived = false;

  ///Get methods of the properties of the tournament
  String get id => _id;
  Name get name => _name;
  String? get description => _description;
  DateTime get startedAt => _startedAt;
  TournamentType get type => _type;
  String get typeName => _type.toString();
  TournamentStatus get status => _status;
  List<Player> get players => _players;
  int? get totalNumberOfRounds => _totalNumberOfRounds;
  List<Round> get rounds => _rounds;
  bool? get haveBye => _haveBye;
  Score? get byeScore => _type is Swiss ? _type.getByeScore : null;
  bool get arquived => _arquived;

  int get numberOfPlayers => _players.length;

  ///Set methods of the properties of the tournament
  setName(String name) => _name = Name(name);
  setDescription(String description) => _description = description;
  setStartedAt(DateTime startedAt) => _startedAt = startedAt;
  setStatus(TournamentStatus status) => _status = status;
  setPlayers(List<Player> players) => _players = players;
  setTotalNumberOfRounds(int totalNumberOfRounds) =>
      _totalNumberOfRounds = totalNumberOfRounds;
  setRounds(List<Round> rounds) => _rounds = rounds;
  setHaveBye(bool haveBye) => _haveBye = haveBye;
  setArquived(bool arquived) => _arquived = arquived;
  setByScore(Score score) => Swiss.new;

  bool get isFinished => status == TournamentStatus.finished;
  bool get isExecuting => status == TournamentStatus.executing;
  bool get isCreated => status == TournamentStatus.created;

  bool get canItBeStarted => (numberOfPlayers > 2) && rounds.isEmpty;

  //bool get cantItBeStarted => (numberOfPlayers < 2) || rounds.isNotEmpty;

  bool get cantItBeStarted => !canItBeStarted;

  bool get areLastRoundResultsFilled =>
      rounds.isEmpty
          ? false
          : rounds.last.matches
              .map((game) => game.result != null ? true : false)
              .reduce((a, b) => a && b);
  int get minRoundsNum => (sqrt(players.length) + 1).round();
  int get maxRoundsNum => players.length - 1;

  void initiateTournament() {
    (players.length.isOdd) ? setHaveBye(true) : setHaveBye(false);

    swissPairing();
    setStatus(TournamentStatus.executing);
  }

  void swissPairing() {
    if (rounds.isNotEmpty &&
        (rounds.last.roundNumber == (_totalNumberOfRounds!))) {
      _status = TournamentStatus.finished;
      throw TournamentMaxRoundsExcpetion('Máximo de rodadas chegou no limite');
    }

    if (rounds.isNotEmpty && !areLastRoundResultsFilled) {
      throw LastRoundMissingException(
        'Todos os resultados da última rodada ainda não foram preenchidos completamente!',
      );
    }

    if (rounds.isNotEmpty) {
      updateBuchholzScores();
    }

    sortPlayersByScoreAndBuchholz();

    Round round = Round(roundNumber: rounds.length + 1, matches: <Match>[]);

    final pairedPlayers = <Player>{};

    if (rounds.isEmpty) {
      players.shuffle();
    }

    if (haveBye!) {
      if (rounds.isNotEmpty) {
        sortNextByePlayer();
      }
      pairedPlayers.add(players.last);
      round.notPaired = players.last;
    }
    for (int i = 0; i < players.length - 1; i++) {
      final player1 = players[i];

      if (pairedPlayers.contains(player1)) continue;

      for (int j = i + 1; j < players.length; j++) {
        final player2 = players[j];
        if (pairedPlayers.contains(player2)) continue;

        // Para não permitir repetição de adversários
        if (!alreadyPlayed(player1, player2)) {
          ChessTuple chessTuple = chooseWhoIsBlackOrWhite(player1, player2);

          round.matches.add(
            Match(
              table: (round.matches.length + 1).toString(),
              white: chessTuple.white,
              black: chessTuple.black,
            ),
          );

          pairedPlayers.add(player1);
          pairedPlayers.add(player2);
          break;
        }
      }
    }
    if (pairedPlayers.length != players.length) {
      round = bestShufflePairing();
    }

    rounds.add(round);
  }

  Round bestShufflePairing() {
    final pairedPlayers = <Player>{};
    final List<Map<String, dynamic>> scoreRounds = <Map<String, dynamic>>[];

    Round round = Round(roundNumber: rounds.length + 1, matches: <Match>[]);
    bool notPaired;
    int count = 0;
    while (count < 100) {
      notPaired = true;
      while (notPaired) {
        for (int i = 0; i < players.length - 1; i++) {
          final player1 = players[i];

          if (pairedPlayers.contains(player1)) continue;

          for (int j = i + 1; j < players.length; j++) {
            final player2 = players[j];
            if (pairedPlayers.contains(player2)) continue;

            // Evita repetição de adversários
            if (!alreadyPlayed(player1, player2)) {
              ChessTuple chessTuple = chooseWhoIsBlackOrWhite(player1, player2);

              round.matches.add(
                Match(
                  table: (round.matches.length + 1).toString(),
                  white: chessTuple.white,
                  black: chessTuple.black,
                ),
              );

              pairedPlayers.add(player1);
              pairedPlayers.add(player2);
              break;
            }
          }
        }
        if (pairedPlayers.length != players.length) {
          pairedPlayers.clear();
          round.matches.clear();
          if (haveBye!) {
            sortNextByePlayer();
            pairedPlayers.add(players.last);
            round.notPaired = players.last;
          }
          players.shuffle();
        } else {
          notPaired = false;
          round.matches.sort((a, b) {
            if (a.mostScorePlayer.score != b.mostScorePlayer.score) {
              return b.mostScorePlayer.score.toDouble.compareTo(
                a.mostScorePlayer.score.toDouble,
              ); // Ordem decrescente por pontuação
            }
            return b.mostScorePlayer.score.toDouble.compareTo(
              a.mostScorePlayer.score.toDouble,
            ); // Desempate por Buchholz
          });
          for (int i = 0; i < round.matches.length; i++) {
            round.matches[i].setTable = (1 + i).toString();
          }
          scoreRounds.add({
            'score': calculateErro(round.matches),
            'round': round.copyWith(),
          });
          count++;
        }
      }
    }
    scoreRounds.sort((a, b) => a['score'].compareTo(b['score']));
    return scoreRounds.first['round'];
  }

  ChessTuple<Player> chooseWhoIsBlackOrWhite(Player player1, Player player2) {
    Player white, black;
    int w1, b1, w2, b2;
    w1 = countOfHowManyTimesThisPlayPlayedWhiteAndBlack(player1).white;
    b1 = countOfHowManyTimesThisPlayPlayedWhiteAndBlack(player1).black;

    w2 = countOfHowManyTimesThisPlayPlayedWhiteAndBlack(player2).white;
    b2 = countOfHowManyTimesThisPlayPlayedWhiteAndBlack(player2).black;

    if ((w1 > b1) && (w2 <= b2)) {
      white = player2;
      black = player1;
    } else if (w2 > b2 && b1 <= w1) {
      white = player1;
      black = player2;
    } else {
      // Se ambos têm um balanço similar, alterna as cores arbitrariamente
      white = player1;
      black = player2;
    }

    return ChessTuple(white, black);
  }

  double calculateErro(List<Match> games) {
    return games
        .map(
          (game) =>
              (game.white.score.toDouble - game.black.score.toDouble).abs(),
        )
        .reduce((a, b) => a + b);
  }

  ChessTuple<int> countOfHowManyTimesThisPlayPlayedWhiteAndBlack(
    Player player,
  ) {
    var games = getGamesPlayedByPlayer(player);
    var list = games
        .map((game) => game.isWhite(player))
        .map((element) => element ? 1 : 0);
    int num;

    if (list.isNotEmpty) {
      num = list.reduce((a, b) => a + b);
    } else {
      num = 0;
    }
    return ChessTuple(num, games.length - num);
  }

  void sortPlayersByScoreAndBuchholz() {
    players.sort((a, b) {
      if (a.score != b.score) {
        return b.score.toDouble.compareTo(
          a.score.toDouble,
        ); // Ordem decrescente por pontuação
      }
      return b.buchholz.toDouble.compareTo(
        a.buchholz.toDouble,
      ); // Desempate por Buchholz
    });
  }

  void sortNextByePlayer() {
    var aux = [...players].reversed.toList();

    Player futureByePlayer = aux.firstWhere(
      (player) => !getByePlayers().contains(player),
    );

    players.remove(futureByePlayer);
    players.add(futureByePlayer);
  }

  /*
    Aqui temos a função que retorna todos os jogos que o player jogou no torneio
    até o momento. Aqui eu simplemente pego todos o rounds da variável rounds e 
    então aplico o método expand que onde ele irá juntar em um lista só todos os
    games ou 'matches' de todos ou rounds. uma vez feito isso, temos todos os
    games em uma lista, então eu aplico o método where onde eu retorno apenas os
    games onde o dado player está usando a função isOnThisGame que retorna true
    caso o player esteja no game e false caso contrário. No final só uso o toList()
    para passar para de Iterable<Game> para List<Game>.
  */
  List<Match> getGamesPlayedByPlayer(Player player) {
    var matches =
        rounds
            .expand((round) => round.matches)
            .where((game) => game.isOnThisGame(player))
            .toList();
    return matches;
  }

  List<Player?> getByePlayers() {
    return rounds.map((round) => round.notPaired).toList();
  }

  /* Aqui vemos a mestria das streams. oque foi feito aqui? primeiro usei o 
    metodo getGamesPlayedByPlayer(player) para pegar a lista de todos os games 
    ou 'matches' que o dado player jogou, logo apos, utilizei um map() para usar 
    a função getOpponent() como função do map para me retornar os oponentes do 
    dado player (que é o argumento deste método). último map foi só para fazer 
    um cast visto q função getOpponent() retorna um Player? (retorna um player 
    ou não (vulgo nulo)), porém como temos estamos analizando a lista de jogos 
    do que o player jogou, é impossivel termos como resposta um oponente venha. Após 
    o cast apenas passei para lista com o último método toList() retornando assim
    todos os adversário jogados contra o dado player no torneio!
    */
  List<Player> getPlayersPlayedAgainst(Player player) {
    var opponents =
        getGamesPlayedByPlayer(player)
            .map((game) => game.getOpponent(player))
            .map((player) => player!)
            .toList();
    return opponents;
  }

  void updateBuchholzScores() {
    for (var player in players) {
      player.setBuchholz(getPlayersPlayedAgainst(player));
    }
  }

  bool alreadyPlayed(Player a, Player b) {
    return getPlayersPlayedAgainst(a).contains(b);
  }

  static Tournament fromJson(dynamic data) {
    return Tournament(
        id: data['id'],
        name: data['name'],
        description: data['description'],
        startedAt: DateTime.parse(data['started_at']),
        type: TournamentType.fromJson(data['type']),
      )
      .._status = _$StatusEnumMap[data['status']] ?? TournamentStatus.created
      .._totalNumberOfRounds = data['total_number_of_rounds'] as int?
      .._haveBye = data['have_bye'] as bool?
      .._arquived = data['arquived'] as bool;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': _id,
      'name': _name.toString(),
      'description': _description,
      'started_at': _startedAt.toIso8601String(),
      'type': TournamentType.toJson(_type),
      'status': _status.name,
      'total_number_of_rounds': _totalNumberOfRounds,
      'have_bye': _haveBye,
      'arquived': _arquived,
    };
  }

  @override
  String toString() {
    return 'Tournament(id: $_id, name: $_name, description: $_description, startedAt: $_startedAt, type: $_type, status: $_status, totalNumberOfRounds: $_totalNumberOfRounds, haveBye: $_haveBye) \n Players: ${_players.toString()} \n Rounds: ${_rounds.toString()}';
  }
}

enum TournamentStatus { created, executing, finished }

const _$StatusEnumMap = {
  'created': TournamentStatus.created,
  'executing': TournamentStatus.executing,
  'finished': TournamentStatus.finished,
};
