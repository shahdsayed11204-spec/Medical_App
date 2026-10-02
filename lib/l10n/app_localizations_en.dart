// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get next => 'Next';

  @override
  String get getStarted => 'Get Started';

  @override
  String get skip => 'Skip';

  @override
  String get onboardingTitle1 => 'Meet Doctors Online';

  @override
  String get onboardingBody1 =>
      'Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.';

  @override
  String get onboardingTitle2 => 'Connect with Specialists';

  @override
  String get onboardingBody2 =>
      'Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.';

  @override
  String get onboardingTitle3 => 'Thousands of Online Specialists';

  @override
  String get onboardingBody3 =>
      'Explore a Vast Array of Online Medical Specialists, Offering an Extensive Range of Expertise Tailored to Your Healthcare Needs.';

  @override
  String get loginTitle => 'Hi, Welcome Back!';

  @override
  String get loginSubtitle => 'Hope you\'re doing fine.';

  @override
  String get yourEmail => 'Your Email';

  @override
  String get yourName => 'Your Name';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign up';

  @override
  String get or => 'or';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithFacebook => 'Continue with Facebook';

  @override
  String get signInWithFacebook => 'Sign In with Facebook';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get noAccountYet => 'Don\'t have an account yet? ';

  @override
  String get haveAccount => 'Do you have an account? ';

  @override
  String get success => 'Success';

  @override
  String get loading => 'Loading...';

  @override
  String get createAccount => 'Create Account';

  @override
  String get createAccountSubtitle => 'We are here to help you!';

  @override
  String get registrationSuccess => 'Registration successful!';

  @override
  String get forgetPasswordTitle => 'Forget Password?';

  @override
  String get forgetPasswordSubtitle =>
      'Enter your Email, we will send you a verification code.';

  @override
  String get sendCode => 'Send Code';

  @override
  String get verifyCodeTitle => 'Verify Code';

  @override
  String get verifyCodeSubtitle =>
      'Enter the code\nwe just sent you on your registered Email';

  @override
  String get verify => 'Verify';

  @override
  String get didntGetCode => 'Didn\'t get the Code? ';

  @override
  String get resend => 'Resend';

  @override
  String get enterFullCode => 'Enter the full code';

  @override
  String codeResentTo(String email) {
    return 'Code resent to $email';
  }

  @override
  String get createNewPassword => 'Create new password';

  @override
  String get newPasswordHint =>
      'Your new password must be different from\npreviously used password';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get fillYourProfile => 'Fill Your Profile';

  @override
  String get name => 'Name';

  @override
  String get nickname => 'Nickname';

  @override
  String get email => 'Email';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get gender => 'Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get save => 'Save';

  @override
  String get imagePickerNotConnected => 'Image picker not connected yet';

  @override
  String get congratulations => 'Congratulations!';

  @override
  String get accountReady =>
      'Your account is ready to use. You will be redirected to the Home Page in a few seconds..';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMin => 'At least 6 characters';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get nicknameRequired => 'Nickname is required';

  @override
  String get dobRequired => 'Date of birth is required';

  @override
  String get genderRequired => 'Select your gender';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get errNetwork => 'Check your internet connection';

  @override
  String get errTimeout => 'Time out, try again';

  @override
  String get errCanceled => 'Canceled';

  @override
  String get errUnauthorized => 'Session ended, please log in again';

  @override
  String get errNotFound => 'Not found';

  @override
  String get errForbidden => 'Forbidden request';

  @override
  String get errServer => 'Server error. Try again later.';

  @override
  String get errBadRequest => 'Bad request';

  @override
  String get errUnexpected => 'Unexpected error occurred';

  @override
  String get errGoogleCancelled => 'Google sign-in was cancelled';

  @override
  String get errNoUser => 'No user is currently signed in';

  @override
  String get errUserNotFound => 'No account found with this email';

  @override
  String get errWrongPassword => 'Incorrect password';

  @override
  String get errInvalidCredential => 'Email or password is incorrect';

  @override
  String get errEmailInUse => 'This email is already in use';

  @override
  String get errWeakPassword => 'Password is too weak';

  @override
  String get errInvalidEmail => 'Invalid email address';

  @override
  String get errTooManyRequests => 'Too many attempts, try again later';
}
