// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `onboarding introduction`
  String get screen1 {
    return Intl.message(
      'onboarding introduction',
      name: 'screen1',
      desc: '',
      args: [],
    );
  }

  /// `Learn and Communicate with Sign Language`
  String get screen1_title {
    return Intl.message(
      'Learn and Communicate with Sign Language',
      name: 'screen1_title',
      desc: '',
      args: [],
    );
  }

  /// `Learn sign language , translate instantly and connect with confidence.`
  String get screen1_desc {
    return Intl.message(
      'Learn sign language , translate instantly and connect with confidence.',
      name: 'screen1_desc',
      desc: '',
      args: [],
    );
  }

  /// `onbroading learning`
  String get screen2 {
    return Intl.message(
      'onbroading learning',
      name: 'screen2',
      desc: '',
      args: [],
    );
  }

  /// `Learn Sign Language Visually`
  String get screen2_title {
    return Intl.message(
      'Learn Sign Language Visually',
      name: 'screen2_title',
      desc: '',
      args: [],
    );
  }

  /// `Interactive lessons , videos , and quizzes designed for everyone.`
  String get screen2_desc {
    return Intl.message(
      'Interactive lessons , videos , and quizzes designed for everyone.',
      name: 'screen2_desc',
      desc: '',
      args: [],
    );
  }

  /// `onboarding translation`
  String get screen3 {
    return Intl.message(
      'onboarding translation',
      name: 'screen3',
      desc: '',
      args: [],
    );
  }

  /// `Instant Translation`
  String get screen3_title {
    return Intl.message(
      'Instant Translation',
      name: 'screen3_title',
      desc: '',
      args: [],
    );
  }

  /// `Translate sign langauge and speech to text in realtime.`
  String get screen3_desc {
    return Intl.message(
      'Translate sign langauge and speech to text in realtime.',
      name: 'screen3_desc',
      desc: '',
      args: [],
    );
  }

  /// `onboarding games`
  String get screen4 {
    return Intl.message(
      'onboarding games',
      name: 'screen4',
      desc: '',
      args: [],
    );
  }

  /// `Learn Through Play`
  String get screen4_title {
    return Intl.message(
      'Learn Through Play',
      name: 'screen4_title',
      desc: '',
      args: [],
    );
  }

  /// `Games that help you practise signs and improve faster.`
  String get screen4_desc {
    return Intl.message(
      'Games that help you practise signs and improve faster.',
      name: 'screen4_desc',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get onboarding_btn {
    return Intl.message('Next', name: 'onboarding_btn', desc: '', args: []);
  }

  /// `Skip`
  String get skip_btn {
    return Intl.message('Skip', name: 'skip_btn', desc: '', args: []);
  }

  /// `onboarding mode`
  String get screen5 {
    return Intl.message('onboarding mode', name: 'screen5', desc: '', args: []);
  }

  /// `How would you like to use the app?`
  String get screen5_title {
    return Intl.message(
      'How would you like to use the app?',
      name: 'screen5_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose a mode to get the best experience.You can change this later in settings.`
  String get screen5_desc1 {
    return Intl.message(
      'Choose a mode to get the best experience.You can change this later in settings.',
      name: 'screen5_desc1',
      desc: '',
      args: [],
    );
  }

  /// `Platform Mode`
  String get mode1 {
    return Intl.message('Platform Mode', name: 'mode1', desc: '', args: []);
  }

  /// `Learn sign language through lessons, games, and quizzes.`
  String get mode1_desc {
    return Intl.message(
      'Learn sign language through lessons, games, and quizzes.',
      name: 'mode1_desc',
      desc: '',
      args: [],
    );
  }

  /// `Translation Mode`
  String get mode2 {
    return Intl.message('Translation Mode', name: 'mode2', desc: '', args: []);
  }

  /// `Translate sign language and speech instantly`
  String get mode2_desc {
    return Intl.message(
      'Translate sign language and speech instantly',
      name: 'mode2_desc',
      desc: '',
      args: [],
    );
  }

  /// `Not sure?You cann switch modes anytime.Both Modes include full accessibility support.`
  String get screen5_desc2 {
    return Intl.message(
      'Not sure?You cann switch modes anytime.Both Modes include full accessibility support.',
      name: 'screen5_desc2',
      desc: '',
      args: [],
    );
  }

  /// `welcome1`
  String get screen6 {
    return Intl.message('welcome1', name: 'screen6', desc: '', args: []);
  }

  /// `Welcome to`
  String get screen6_title {
    return Intl.message(
      'Welcome to',
      name: 'screen6_title',
      desc: '',
      args: [],
    );
  }

  /// `TRANS MODE`
  String get screen6_transmode {
    return Intl.message(
      'TRANS MODE',
      name: 'screen6_transmode',
      desc: '',
      args: [],
    );
  }

  /// `This mode helps you commuincate instanlty using real-time translation.`
  String get screen6_desc {
    return Intl.message(
      'This mode helps you commuincate instanlty using real-time translation.',
      name: 'screen6_desc',
      desc: '',
      args: [],
    );
  }

  /// `welcome2`
  String get screen7 {
    return Intl.message('welcome2', name: 'screen7', desc: '', args: []);
  }

  /// `Welcome to`
  String get screen7_title {
    return Intl.message(
      'Welcome to',
      name: 'screen7_title',
      desc: '',
      args: [],
    );
  }

  /// `PLATFORM Mode`
  String get screen7_platformmode {
    return Intl.message(
      'PLATFORM Mode',
      name: 'screen7_platformmode',
      desc: '',
      args: [],
    );
  }

  /// `This mode helps you learn sign language step by step through interactive content.`
  String get screen7_desc {
    return Intl.message(
      'This mode helps you learn sign language step by step through interactive content.',
      name: 'screen7_desc',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get welcome_btn {
    return Intl.message('Get Started', name: 'welcome_btn', desc: '', args: []);
  }

  // skipped getter for the 'welcome.desc' key

  /// `Sign up`
  String get screen8 {
    return Intl.message('Sign up', name: 'screen8', desc: '', args: []);
  }

  // skipped getter for the 'register.title' key

  /// `username`
  String get username {
    return Intl.message('username', name: 'username', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  // skipped getter for the 'password.confirmation' key

  // skipped getter for the 'register.alternative' key

  // skipped getter for the 'register.already' key

  /// `I agree to the processing of personal data`
  String get agreement {
    return Intl.message(
      'I agree to the processing of personal data',
      name: 'agreement',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'register.btn' key

  /// `login`
  String get screen9 {
    return Intl.message('login', name: 'screen9', desc: '', args: []);
  }

  // skipped getter for the 'login.title' key

  /// `Remember me`
  String get remember {
    return Intl.message('Remember me', name: 'remember', desc: '', args: []);
  }

  // skipped getter for the 'forget.hyper' key

  // skipped getter for the 'login.btn' key

  // skipped getter for the 'login.alternative' key

  // skipped getter for the 'enter.username' key

  // skipped getter for the 'enter.email' key

  // skipped getter for the 'enter.pass' key

  // skipped getter for the 'enter.pass.conf' key

  /// `otp code`
  String get screen10 {
    return Intl.message('otp code', name: 'screen10', desc: '', args: []);
  }

  // skipped getter for the 'otp.title' key

  // skipped getter for the 'otp.desc' key

  // skipped getter for the 'otp.resent' key

  // skipped getter for the 'otp.btn' key

  // skipped getter for the 'otp.sec' key

  /// `Forget Password`
  String get screen20 {
    return Intl.message(
      'Forget Password',
      name: 'screen20',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password?`
  String get forget_title {
    return Intl.message(
      'Forget Password?',
      name: 'forget_title',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email to recieve a confirmation`
  String get forget_desc {
    return Intl.message(
      'Please enter your email to recieve a confirmation',
      name: 'forget_desc',
      desc: '',
      args: [],
    );
  }

  /// `code to set a new password`
  String get forget_desc2 {
    return Intl.message(
      'code to set a new password',
      name: 'forget_desc2',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'forget.email' key

  // skipped getter for the 'forget.field' key

  // skipped getter for the 'forget.btn' key

  /// `New Password`
  String get screen21 {
    return Intl.message('New Password', name: 'screen21', desc: '', args: []);
  }

  /// `Set New Password`
  String get new_title {
    return Intl.message(
      'Set New Password',
      name: 'new_title',
      desc: '',
      args: [],
    );
  }

  /// `Your new password should be different from the previous`
  String get new_desc {
    return Intl.message(
      'Your new password should be different from the previous',
      name: 'new_desc',
      desc: '',
      args: [],
    );
  }

  /// `old password`
  String get new_desc2 {
    return Intl.message('old password', name: 'new_desc2', desc: '', args: []);
  }

  // skipped getter for the 'new.password' key

  // skipped getter for the 'new.field1' key

  /// `Must be at least 8 characters`
  String get new_warning1 {
    return Intl.message(
      'Must be at least 8 characters',
      name: 'new_warning1',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'new.confirm' key

  // skipped getter for the 'new.field2' key

  /// `Both passwords must match`
  String get new_warning2 {
    return Intl.message(
      'Both passwords must match',
      name: 'new_warning2',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'new.btn' key

  /// `Password Changed `
  String get passwordchanged {
    return Intl.message(
      'Password Changed ',
      name: 'passwordchanged',
      desc: '',
      args: [],
    );
  }

  /// `successfully!`
  String get success {
    return Intl.message('successfully!', name: 'success', desc: '', args: []);
  }

  /// `Your password has been changed successfully,`
  String get confirmsg {
    return Intl.message(
      'Your password has been changed successfully,',
      name: 'confirmsg',
      desc: '',
      args: [],
    );
  }

  /// `we will let you know if there are more problems`
  String get confirmsg2 {
    return Intl.message(
      'we will let you know if there are more problems',
      name: 'confirmsg2',
      desc: '',
      args: [],
    );
  }

  /// ` with your account `
  String get confirmsg3 {
    return Intl.message(
      ' with your account ',
      name: 'confirmsg3',
      desc: '',
      args: [],
    );
  }

  /// `home for learning`
  String get screen11 {
    return Intl.message(
      'home for learning',
      name: 'screen11',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'home1.welcome' key

  // skipped getter for the 'home1.message' key

  // skipped getter for the 'home1.submessage' key

  // skipped getter for the 'home1.services' key

  // skipped getter for the 'home1.service1' key

  // skipped getter for the 'home1.service1.desc' key

  // skipped getter for the 'home1.service2' key

  // skipped getter for the 'home1.service2.desc' key

  // skipped getter for the 'home1.service3' key

  // skipped getter for the 'home1.service3.desc' key

  // skipped getter for the 'home1.service4' key

  // skipped getter for the 'home1.service4.desc' key

  /// `Category`
  String get screen12 {
    return Intl.message('Category', name: 'screen12', desc: '', args: []);
  }

  // skipped getter for the 'categories.title' key

  // skipped getter for the 'categories.search' key

  /// `lessons`
  String get screen13 {
    return Intl.message('lessons', name: 'screen13', desc: '', args: []);
  }

  // skipped getter for the 'lessons.vocab' key

  // skipped getter for the 'lessons.num' key

  // skipped getter for the 'lessons.all' key

  // skipped getter for the 'lessons.viewed' key

  /// `quiz`
  String get screen14 {
    return Intl.message('quiz', name: 'screen14', desc: '', args: []);
  }

  // skipped getter for the 'quiz.title' key

  // skipped getter for the 'quiz.desc' key

  // skipped getter for the 'quiz.btn' key

  /// `question`
  String get screen15 {
    return Intl.message('question', name: 'screen15', desc: '', args: []);
  }

  // skipped getter for the 'question.num' key

  /// `quizSubmit`
  String get screen16 {
    return Intl.message('quizSubmit', name: 'screen16', desc: '', args: []);
  }

  // skipped getter for the 'submit.title' key

  // skipped getter for the 'submit.desc' key

  // skipped getter for the 'submit.btn1' key

  // skipped getter for the 'submit.btn2' key

  /// `results`
  String get screen17 {
    return Intl.message('results', name: 'screen17', desc: '', args: []);
  }

  // skipped getter for the 'result.score1' key

  // skipped getter for the 'result.score2' key

  // skipped getter for the 'result.time' key

  // skipped getter for the 'result.sec' key

  // skipped getter for the 'result.play' key

  // skipped getter for the 'result.review' key

  // skipped getter for the 'result.share' key

  // skipped getter for the 'result.home' key

  /// `Profile information`
  String get screen18 {
    return Intl.message(
      'Profile information',
      name: 'screen18',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'profile.username' key

  // skipped getter for the 'profile.name' key

  // skipped getter for the 'profile.email' key

  // skipped getter for the 'profile.current.pass' key

  // skipped getter for the 'profile.new.pass' key

  // skipped getter for the 'profile.confirm.pass' key

  // skipped getter for the 'profile.btn1' key

  // skipped getter for the 'profile.btn2' key

  /// `profile`
  String get screen19 {
    return Intl.message('profile', name: 'screen19', desc: '', args: []);
  }

  // skipped getter for the 'account.title' key

  // skipped getter for the 'account.info' key

  // skipped getter for the 'account.lang' key

  // skipped getter for the 'lang.ar' key

  // skipped getter for the 'lang.en' key

  // skipped getter for the 'account.mode' key

  // skipped getter for the 'mode.ass' key

  // skipped getter for the 'mode.learn' key

  // skipped getter for the 'about.title' key

  // skipped getter for the 'about.about' key

  // skipped getter for the 'about.terms' key

  // skipped getter for the 'about.privacy' key

  // skipped getter for the 'about.version' key

  // skipped getter for the 'support.title' key

  // skipped getter for the 'support.contact' key

  // skipped getter for the 'support.help' key

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  // skipped getter for the 'account.delete' key

  // skipped getter for the 'delete.title' key

  // skipped getter for the 'delete.desc' key

  // skipped getter for the 'delete.btn1' key

  // skipped getter for the 'delete.btn2' key

  /// `Terms & Conditions`
  String get screen22 {
    return Intl.message(
      'Terms & Conditions',
      name: 'screen22',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'term.desc' key
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
