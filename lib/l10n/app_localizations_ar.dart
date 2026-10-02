// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get next => 'التالي';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get skip => 'تخطي';

  @override
  String get onboardingTitle1 => 'قابل الأطباء أونلاين';

  @override
  String get onboardingBody1 =>
      'تواصل مع أطباء متخصصين عبر الإنترنت للحصول على استشارات طبية مريحة وشاملة.';

  @override
  String get onboardingTitle2 => 'تواصل مع المتخصصين';

  @override
  String get onboardingBody2 =>
      'تواصل مع أطباء متخصصين عبر الإنترنت للحصول على استشارات طبية مريحة وشاملة.';

  @override
  String get onboardingTitle3 => 'آلاف المتخصصين أونلاين';

  @override
  String get onboardingBody3 =>
      'اكتشف مجموعة واسعة من الأطباء المتخصصين عبر الإنترنت بخبرات متنوعة تناسب احتياجاتك الصحية.';

  @override
  String get loginTitle => 'أهلاً بعودتك!';

  @override
  String get loginSubtitle => 'نتمنى أنك بخير.';

  @override
  String get yourEmail => 'بريدك الإلكتروني';

  @override
  String get yourName => 'اسمك';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get or => 'أو';

  @override
  String get continueWithGoogle => 'المتابعة باستخدام جوجل';

  @override
  String get continueWithFacebook => 'المتابعة باستخدام فيسبوك';

  @override
  String get signInWithFacebook => 'تسجيل الدخول باستخدام فيسبوك';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get noAccountYet => 'ليس لديك حساب؟ ';

  @override
  String get haveAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get success => 'تمت العملية بنجاح';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get createAccountSubtitle => 'نحن هنا لمساعدتك!';

  @override
  String get registrationSuccess => 'تم إنشاء الحساب بنجاح!';

  @override
  String get forgetPasswordTitle => 'نسيت كلمة المرور؟';

  @override
  String get forgetPasswordSubtitle =>
      'أدخل بريدك الإلكتروني وسنرسل لك رمز تحقق.';

  @override
  String get sendCode => 'إرسال الرمز';

  @override
  String get verifyCodeTitle => 'التحقق من الرمز';

  @override
  String get verifyCodeSubtitle =>
      'أدخل الرمز الذي أرسلناه\nإلى بريدك الإلكتروني المسجل';

  @override
  String get verify => 'تحقق';

  @override
  String get didntGetCode => 'لم يصلك الرمز؟ ';

  @override
  String get resend => 'إعادة الإرسال';

  @override
  String get enterFullCode => 'أدخل الرمز كاملاً';

  @override
  String codeResentTo(String email) {
    return 'تم إعادة إرسال الرمز إلى $email';
  }

  @override
  String get createNewPassword => 'إنشاء كلمة مرور جديدة';

  @override
  String get newPasswordHint =>
      'يجب أن تكون كلمة المرور الجديدة مختلفة\nعن كلمة المرور المستخدمة سابقاً';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get fillYourProfile => 'أكمل ملفك الشخصي';

  @override
  String get name => 'الاسم';

  @override
  String get nickname => 'اسم الشهرة';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get dateOfBirth => 'تاريخ الميلاد';

  @override
  String get gender => 'النوع';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get save => 'حفظ';

  @override
  String get imagePickerNotConnected => 'اختيار الصورة غير مفعّل حالياً';

  @override
  String get congratulations => 'مبروك!';

  @override
  String get accountReady =>
      'حسابك جاهز للاستخدام. سيتم تحويلك إلى الصفحة الرئيسية خلال ثوانٍ..';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get emailInvalid => 'أدخل بريداً إلكترونياً صحيحاً';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get passwordMin => '6 أحرف على الأقل';

  @override
  String get nameRequired => 'الاسم مطلوب';

  @override
  String get nicknameRequired => 'اسم الشهرة مطلوب';

  @override
  String get dobRequired => 'تاريخ الميلاد مطلوب';

  @override
  String get genderRequired => 'اختر النوع';

  @override
  String get confirmPasswordRequired => 'من فضلك أكّد كلمة المرور';

  @override
  String get passwordsNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get errNetwork => 'تأكد من اتصالك بالإنترنت';

  @override
  String get errTimeout => 'انتهت المهلة، حاول مرة أخرى';

  @override
  String get errCanceled => 'تم الإلغاء';

  @override
  String get errUnauthorized => 'انتهت الجلسة، سجّل الدخول مرة أخرى';

  @override
  String get errNotFound => 'غير موجود';

  @override
  String get errForbidden => 'الطلب غير مسموح به';

  @override
  String get errServer => 'خطأ في الخادم، حاول لاحقاً.';

  @override
  String get errBadRequest => 'طلب غير صالح';

  @override
  String get errUnexpected => 'حدث خطأ غير متوقع';

  @override
  String get errGoogleCancelled => 'تم إلغاء تسجيل الدخول بجوجل';

  @override
  String get errNoUser => 'لا يوجد مستخدم مسجل دخول حالياً';

  @override
  String get errUserNotFound => 'لا يوجد حساب بهذا البريد الإلكتروني';

  @override
  String get errWrongPassword => 'كلمة المرور غير صحيحة';

  @override
  String get errInvalidCredential =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة';

  @override
  String get errEmailInUse => 'هذا البريد الإلكتروني مستخدم بالفعل';

  @override
  String get errWeakPassword => 'كلمة المرور ضعيفة';

  @override
  String get errInvalidEmail => 'البريد الإلكتروني غير صالح';

  @override
  String get errTooManyRequests => 'محاولات كثيرة، حاول لاحقاً';
}
