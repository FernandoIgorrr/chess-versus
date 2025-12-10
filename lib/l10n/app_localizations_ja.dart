// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get tournaments => 'トーナメント';

  @override
  String get deleteTournament => 'トーナメントを削除しますか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get registerTournament => 'トーナメントを登録';

  @override
  String get name => '名前';

  @override
  String get tournamentName => 'トーナメント名';

  @override
  String get tournamentDescription => 'トーナメントの説明';

  @override
  String get tournamentNullDescription => '説明なし';

  @override
  String get tournamentType => 'トーナメントの種類';

  @override
  String get tournamentStartDate => '開始日';

  @override
  String get created => '作成済み';

  @override
  String get inProgress => '進行中';

  @override
  String get finished => '終了';

  @override
  String get tournamentHasAlreadyEnded => 'トーナメントはすでに終了しています';

  @override
  String get numberOfRounds => 'ラウンド数';

  @override
  String get scorePerBye => '不戦勝ごとのスコア';

  @override
  String get notDefined => '未定義';

  @override
  String get notInformed => '未通知';

  @override
  String get activePlayers => 'アクティブなプレイヤー';

  @override
  String get active => 'アクティブ';

  @override
  String get inactive => '非アクティブ';

  @override
  String get byeInactive => '不戦勝は非アクティブ';

  @override
  String get tournamentHasntStartedYet => 'トーナメントはまだ開始されていません';

  @override
  String get tournamentRegisteredSuccessfully => 'トーナメントが正常に登録されました！';

  @override
  String get invalidData => '無効なデータ';

  @override
  String get emptyTournaments => '登録されているトーナメントはありません';

  @override
  String get errorWhileDeletingATournament => 'トーナメントの削除中にエラーが発生しました';

  @override
  String get successWhileDeletingATournament => 'トーナメントが正常に削除されました！';

  @override
  String get score => 'スコア';

  @override
  String get scoreNegativeException => 'スコアをマイナスにすることはできません！';

  @override
  String get classification => 'ランキング';

  @override
  String get rounds => 'ラウンド';

  @override
  String get round => 'ラウンド';

  @override
  String get result => '結果';

  @override
  String get tournamentStarted => 'トーナメントが開始されました';

  @override
  String get tournamentCantBeStarted => 'トーナメントを開始できません';

  @override
  String get tournamentCantBePaired => 'トーナメントをペアリングできません';

  @override
  String get lastRoundResultsDontFilled => '最終ラウンドの結果が完全に記入されていません。';

  @override
  String get allRoundsHaveAlreadyBeenPaired => 'すべてのラウンドはすでにペアリングされています。';

  @override
  String get startTournament => 'トーナメントを開始';

  @override
  String get theTournamentHasFinished => 'トーナメントは終了しました';

  @override
  String get start => '開始';

  @override
  String get table => 'テーブル';

  @override
  String get board => 'ボード';

  @override
  String get player => 'プレイヤー';

  @override
  String get players => 'プレイヤー';

  @override
  String get thereAreNoRegisteredPlayers => '登録されているプレイヤーはいません';

  @override
  String get toStartTheTournamentYouNeedAtLeastThreePlayers =>
      'トーナメントを開始するには、少なくとも3人のプレイヤーが必要です。';

  @override
  String get playerAddeddSuccessfully => 'プレイヤーが正常に追加されました！';

  @override
  String get playerNmae => 'プレイヤー名';

  @override
  String get addPlayer => 'プレイヤーを追加';

  @override
  String get add => '追加';

  @override
  String get informations => '情報';

  @override
  String get somethingWentWrong => '問題が発生しました！';

  @override
  String get settings => '設定';

  @override
  String get language => '言語';

  @override
  String get switchTheme => 'テーマを切り替える';

  @override
  String get darkMode => 'ダークモード';
}
