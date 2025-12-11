// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get tournaments => '토너먼트';

  @override
  String get deleteTournament => '토너먼트를 삭제하시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get registerTournament => '토너먼트 등록';

  @override
  String get name => '이름';

  @override
  String get tournamentName => '토너먼트 이름';

  @override
  String get tournamentDescription => '토너먼트 설명';

  @override
  String get tournamentNullDescription => '설명 없음';

  @override
  String get tournamentType => '토너먼트 유형';

  @override
  String get tournamentStartDate => '시작일';

  @override
  String get created => '생성됨';

  @override
  String get inProgress => '진행 중';

  @override
  String get finished => '종료됨';

  @override
  String get tournamentHasAlreadyEnded => '토너먼트가 이미 종료되었습니다';

  @override
  String get numberOfRounds => '라운드 수';

  @override
  String get scorePerBye => '부전승당 점수';

  @override
  String get notDefined => '정의되지 않음';

  @override
  String get notInformed => '정보 없음';

  @override
  String get activePlayers => '활성 플레이어';

  @override
  String get active => '활성';

  @override
  String get inactive => '비활성';

  @override
  String get byeInactive => '부전승 비활성';

  @override
  String get tournamentHasntStartedYet => '토너먼트가 아직 시작되지 않았습니다';

  @override
  String get tournamentRegisteredSuccessfully => '토너먼트가 성공적으로 등록되었습니다!';

  @override
  String get invalidData => '유효하지 않은 데이터';

  @override
  String get emptyTournaments => '등록된 토너먼트가 없습니다';

  @override
  String get errorWhileDeletingATournament => '토너먼트 삭제 중 오류 발생';

  @override
  String get successWhileDeletingATournament => '토너먼트가 성공적으로 삭제되었습니다!';

  @override
  String get score => '점수';

  @override
  String get scoreNegativeException => '점수는 음수가 될 수 없습니다!';

  @override
  String get classification => '순위';

  @override
  String get rounds => '라운드';

  @override
  String get round => '라운드';

  @override
  String get result => '결과';

  @override
  String get tournamentStarted => '토너먼트 시작됨';

  @override
  String get tournamentCantBeStarted => '토너먼트를 시작할 수 없습니다';

  @override
  String get tournamentCantBePaired => '토너먼트를 페어링할 수 없습니다';

  @override
  String get lastRoundResultsDontFilled => '마지막 라운드 결과가 완전히 채워지지 않았습니다.';

  @override
  String get allRoundsHaveAlreadyBeenPaired => '모든 라운드가 이미 페어링되었습니다.';

  @override
  String get startTournament => '토너먼트 시작';

  @override
  String get theTournamentHasFinished => '토너먼트가 종료되었습니다';

  @override
  String get start => '시작';

  @override
  String get table => '테이블';

  @override
  String get board => '보드';

  @override
  String get player => '플레이어';

  @override
  String get players => '플레이어';

  @override
  String get thereAreNoRegisteredPlayers => '등록된 플레이어가 없습니다';

  @override
  String get toStartTheTournamentYouNeedAtLeastThreePlayers =>
      '토너먼트를 시작하려면 최소 3명의 플레이어가 필요합니다.';

  @override
  String get playerAddeddSuccessfully => '플레이어가 성공적으로 추가되었습니다!';

  @override
  String get playerNmae => '플레이어 이름';

  @override
  String get addPlayer => '플레이어 추가';

  @override
  String get add => '추가';

  @override
  String get informations => '정보';

  @override
  String get somethingWentWrong => '문제가 발생했습니다!';

  @override
  String get settings => '설정';

  @override
  String get tip => '팁';

  @override
  String get addResultTip => '결과를 추가하려면 경기를 길게 누르세요.';

  @override
  String get language => '언어';

  @override
  String get switchTheme => '테마 전환';

  @override
  String get darkMode => '다크 모드';
}
