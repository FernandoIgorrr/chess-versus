// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get tournaments => 'البطولات';

  @override
  String get deleteTournament => 'حذف البطولة؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get registerTournament => 'تسجيل بطولة';

  @override
  String get name => 'الاسم';

  @override
  String get tournamentName => 'اسم البطولة';

  @override
  String get tournamentDescription => 'وصف البطولة';

  @override
  String get tournamentNullDescription => 'لا يوجد وصف';

  @override
  String get tournamentType => 'نوع البطولة';

  @override
  String get tournamentStartDate => 'تاريخ البدء';

  @override
  String get created => 'تم الإنشاء';

  @override
  String get inProgress => 'قيد التقدم';

  @override
  String get finished => 'انتهت';

  @override
  String get tournamentHasAlreadyEnded => 'انتهت البطولة بالفعل';

  @override
  String get numberOfRounds => 'عدد الجولات';

  @override
  String get scorePerBye => 'النقاط لكل جولة إعفاء';

  @override
  String get notDefined => 'غير محدد';

  @override
  String get notInformed => 'غير مُبلّغ عنه';

  @override
  String get activePlayers => 'اللاعبون النشطون';

  @override
  String get active => 'نشط';

  @override
  String get inactive => 'غير نشط';

  @override
  String get byeInactive => 'الإعفاء غير نشط';

  @override
  String get tournamentHasntStartedYet => 'لم تبدأ البطولة بعد';

  @override
  String get tournamentRegisteredSuccessfully => 'تم تسجيل البطولة بنجاح!';

  @override
  String get invalidData => 'بيانات غير صالحة';

  @override
  String get emptyTournaments => 'لا توجد بطولات مسجلة';

  @override
  String get errorWhileDeletingATournament =>
      'حدث خطأ أثناء محاولة حذف البطولة';

  @override
  String get successWhileDeletingATournament => 'تم حذف البطولة بنجاح!';

  @override
  String get score => 'النتيجة';

  @override
  String get scoreNegativeException => 'لا يمكن أن تكون النتيجة سالبة!';

  @override
  String get classification => 'التصنيف';

  @override
  String get rounds => 'جولات';

  @override
  String get round => 'جولة';

  @override
  String get result => 'النتيجة';

  @override
  String get tournamentStarted => 'بدأت البطولة';

  @override
  String get tournamentCantBeStarted => 'لا يمكن بدء البطولة';

  @override
  String get tournamentCantBePaired => 'لا يمكن إجراء إقران في البطولة';

  @override
  String get lastRoundResultsDontFilled =>
      'لم يتم ملء نتائج الجولة الأخيرة بالكامل.';

  @override
  String get allRoundsHaveAlreadyBeenPaired => 'تم إقران جميع الجولات بالفعل.';

  @override
  String get startTournament => 'بدء البطولة';

  @override
  String get theTournamentHasFinished => 'انتهت البطولة';

  @override
  String get start => 'بدء';

  @override
  String get table => 'جدول';

  @override
  String get board => 'لوحة';

  @override
  String get player => 'لاعب';

  @override
  String get players => 'اللاعبون';

  @override
  String get thereAreNoRegisteredPlayers => 'لا يوجد لاعبون مسجلون';

  @override
  String get toStartTheTournamentYouNeedAtLeastThreePlayers =>
      'لبدء البطولة تحتاج إلى 3 لاعبين على الأقل.';

  @override
  String get playerAddeddSuccessfully => 'تمت إضافة اللاعب بنجاح!';

  @override
  String get playerNmae => 'اسم اللاعب';

  @override
  String get addPlayer => 'إضافة لاعب';

  @override
  String get add => 'إضافة';

  @override
  String get informations => 'معلومات';

  @override
  String get somethingWentWrong => 'حدث خطأ ما!';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get switchTheme => 'تبديل المظهر';

  @override
  String get darkMode => 'الوضع الداكن';
}
