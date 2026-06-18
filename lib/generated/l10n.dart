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

  /// `Already have an account?Log in`
  String get welcome_desc {
    return Intl.message(
      'Already have an account?Log in',
      name: 'welcome_desc',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get screen8 {
    return Intl.message('Sign up', name: 'screen8', desc: '', args: []);
  }

  /// `Get Started`
  String get register_title {
    return Intl.message(
      'Get Started',
      name: 'register_title',
      desc: '',
      args: [],
    );
  }

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

  /// `Password Confirmation`
  String get password_confirmation {
    return Intl.message(
      'Password Confirmation',
      name: 'password_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Or sign up with`
  String get register_alternative {
    return Intl.message(
      'Or sign up with',
      name: 'register_alternative',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?Log in`
  String get register_already {
    return Intl.message(
      'Already have an account?Log in',
      name: 'register_already',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the processing of personal data`
  String get agreement {
    return Intl.message(
      'I agree to the processing of personal data',
      name: 'agreement',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get register_btn {
    return Intl.message('Sign Up', name: 'register_btn', desc: '', args: []);
  }

  /// `login`
  String get screen9 {
    return Intl.message('login', name: 'screen9', desc: '', args: []);
  }

  /// `Welcome Back!`
  String get login_title {
    return Intl.message(
      'Welcome Back!',
      name: 'login_title',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get remember {
    return Intl.message('Remember me', name: 'remember', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forget_hyper {
    return Intl.message(
      'Forgot Password?',
      name: 'forget_hyper',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get login_btn {
    return Intl.message('Log In', name: 'login_btn', desc: '', args: []);
  }

  /// `Or log in with`
  String get login_alternative {
    return Intl.message(
      'Or log in with',
      name: 'login_alternative',
      desc: '',
      args: [],
    );
  }

  /// `Enter your username`
  String get enter_username {
    return Intl.message(
      'Enter your username',
      name: 'enter_username',
      desc: '',
      args: [],
    );
  }

  /// `Enter you email`
  String get enter_email {
    return Intl.message(
      'Enter you email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enter_pass {
    return Intl.message(
      'Enter your password',
      name: 'enter_pass',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enter_pass_conf {
    return Intl.message(
      'Enter your password',
      name: 'enter_pass_conf',
      desc: '',
      args: [],
    );
  }

  /// `otp code`
  String get screen10 {
    return Intl.message('otp code', name: 'screen10', desc: '', args: []);
  }

  /// `Enter your OTP`
  String get otp_title {
    return Intl.message(
      'Enter your OTP',
      name: 'otp_title',
      desc: '',
      args: [],
    );
  }

  /// `For you security, We have sent a One-Time code to your e-mail user@gmail.com.Enter it to access your account.`
  String get otp_desc {
    return Intl.message(
      'For you security, We have sent a One-Time code to your e-mail user@gmail.com.Enter it to access your account.',
      name: 'otp_desc',
      desc: '',
      args: [],
    );
  }

  /// `Resend code?`
  String get otp_resent {
    return Intl.message('Resend code?', name: 'otp_resent', desc: '', args: []);
  }

  /// `Verify`
  String get otp_btn {
    return Intl.message('Verify', name: 'otp_btn', desc: '', args: []);
  }

  /// `Remaining`
  String get otp_sec {
    return Intl.message('Remaining', name: 'otp_sec', desc: '', args: []);
  }

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

  /// `Email`
  String get forget_email {
    return Intl.message('Email', name: 'forget_email', desc: '', args: []);
  }

  /// `Enter your email`
  String get forget_field {
    return Intl.message(
      'Enter your email',
      name: 'forget_field',
      desc: '',
      args: [],
    );
  }

  /// `Confirm mail`
  String get forget_btn {
    return Intl.message('Confirm mail', name: 'forget_btn', desc: '', args: []);
  }

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

  /// `Password`
  String get new_password {
    return Intl.message('Password', name: 'new_password', desc: '', args: []);
  }

  /// `Enter your password`
  String get new_field1 {
    return Intl.message(
      'Enter your password',
      name: 'new_field1',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least 8 characters`
  String get new_warning1 {
    return Intl.message(
      'Must be at least 8 characters',
      name: 'new_warning1',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed Password`
  String get new_confirm {
    return Intl.message(
      'Confirmed Password',
      name: 'new_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get new_field2 {
    return Intl.message(
      'Enter your password',
      name: 'new_field2',
      desc: '',
      args: [],
    );
  }

  /// `Both passwords must match`
  String get new_warning2 {
    return Intl.message(
      'Both passwords must match',
      name: 'new_warning2',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get new_btn {
    return Intl.message('Reset Password', name: 'new_btn', desc: '', args: []);
  }

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

  /// `Welcome Back!`
  String get home1_welcome {
    return Intl.message(
      'Welcome Back!',
      name: 'home1_welcome',
      desc: '',
      args: [],
    );
  }

  /// `Continue your lessons!`
  String get home1_message {
    return Intl.message(
      'Continue your lessons!',
      name: 'home1_message',
      desc: '',
      args: [],
    );
  }

  /// `Because everyone deserves to be understood`
  String get home1_submessage {
    return Intl.message(
      'Because everyone deserves to be understood',
      name: 'home1_submessage',
      desc: '',
      args: [],
    );
  }

  /// `Our Services`
  String get home1_services {
    return Intl.message(
      'Our Services',
      name: 'home1_services',
      desc: '',
      args: [],
    );
  }

  /// `Learn Sign Language`
  String get home1_service1 {
    return Intl.message(
      'Learn Sign Language',
      name: 'home1_service1',
      desc: '',
      args: [],
    );
  }

  /// `Start from the basics and build your signing skills step by step.`
  String get home1_service1_desc {
    return Intl.message(
      'Start from the basics and build your signing skills step by step.',
      name: 'home1_service1_desc',
      desc: '',
      args: [],
    );
  }

  /// `Dictionary`
  String get home1_service2 {
    return Intl.message(
      'Dictionary',
      name: 'home1_service2',
      desc: '',
      args: [],
    );
  }

  /// `Find any sign instantly , exactly when you need it.`
  String get home1_service2_desc {
    return Intl.message(
      'Find any sign instantly , exactly when you need it.',
      name: 'home1_service2_desc',
      desc: '',
      args: [],
    );
  }

  /// `Quick Practice`
  String get home1_service3 {
    return Intl.message(
      'Quick Practice',
      name: 'home1_service3',
      desc: '',
      args: [],
    );
  }

  /// `Consistent practice , meaningful results.`
  String get home1_service3_desc {
    return Intl.message(
      'Consistent practice , meaningful results.',
      name: 'home1_service3_desc',
      desc: '',
      args: [],
    );
  }

  /// `Game To Learn`
  String get home1_service4 {
    return Intl.message(
      'Game To Learn',
      name: 'home1_service4',
      desc: '',
      args: [],
    );
  }

  /// `Interactive games to learn sign language.`
  String get home1_service4_desc {
    return Intl.message(
      'Interactive games to learn sign language.',
      name: 'home1_service4_desc',
      desc: '',
      args: [],
    );
  }

  /// `Translate your Thoughts`
  String get home2_message {
    return Intl.message(
      'Translate your Thoughts',
      name: 'home2_message',
      desc: '',
      args: [],
    );
  }

  /// `Because everyone deserves to be understood.`
  String get home2_submessage {
    return Intl.message(
      'Because everyone deserves to be understood.',
      name: 'home2_submessage',
      desc: '',
      args: [],
    );
  }

  /// `Video Translation`
  String get home2_service1 {
    return Intl.message(
      'Video Translation',
      name: 'home2_service1',
      desc: '',
      args: [],
    );
  }

  /// `Capture video and convert it into translated text.`
  String get home2_service1_desc {
    return Intl.message(
      'Capture video and convert it into translated text.',
      name: 'home2_service1_desc',
      desc: '',
      args: [],
    );
  }

  /// `Voice Translation`
  String get home2_service2 {
    return Intl.message(
      'Voice Translation',
      name: 'home2_service2',
      desc: '',
      args: [],
    );
  }

  /// `Convert spoken language into accurate text instantly.`
  String get home2_service2_desc {
    return Intl.message(
      'Convert spoken language into accurate text instantly.',
      name: 'home2_service2_desc',
      desc: '',
      args: [],
    );
  }

  /// `Quick Response`
  String get home2_service3 {
    return Intl.message(
      'Quick Response',
      name: 'home2_service3',
      desc: '',
      args: [],
    );
  }

  /// `Fast responses for common daily situations.`
  String get home2_service3_desc {
    return Intl.message(
      'Fast responses for common daily situations.',
      name: 'home2_service3_desc',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get screen12 {
    return Intl.message('Category', name: 'screen12', desc: '', args: []);
  }

  /// `Categories`
  String get categories_title {
    return Intl.message(
      'Categories',
      name: 'categories_title',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get categories_search {
    return Intl.message(
      'Search',
      name: 'categories_search',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get categories_no_results {
    return Intl.message(
      'No results found',
      name: 'categories_no_results',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load categories`
  String get categories_load_failed {
    return Intl.message(
      'Failed to load categories',
      name: 'categories_load_failed',
      desc: '',
      args: [],
    );
  }

  /// `Family`
  String get family {
    return Intl.message('Family', name: 'family', desc: '', args: []);
  }

  /// `Signs for family and social relationships.`
  String get familydec {
    return Intl.message(
      'Signs for family and social relationships.',
      name: 'familydec',
      desc: '',
      args: [],
    );
  }

  /// `lessons`
  String get screen13 {
    return Intl.message('lessons', name: 'screen13', desc: '', args: []);
  }

  /// `Family Vocabulary`
  String get lessons_vocab {
    return Intl.message(
      'Family Vocabulary',
      name: 'lessons_vocab',
      desc: '',
      args: [],
    );
  }

  /// `Lessons`
  String get lessons_num {
    return Intl.message('Lessons', name: 'lessons_num', desc: '', args: []);
  }

  /// `All Lessons`
  String get lessons_all {
    return Intl.message('All Lessons', name: 'lessons_all', desc: '', args: []);
  }

  /// `Viewed`
  String get lessons_viewed {
    return Intl.message('Viewed', name: 'lessons_viewed', desc: '', args: []);
  }

  /// `quiz`
  String get screen14 {
    return Intl.message('quiz', name: 'screen14', desc: '', args: []);
  }

  /// `Check your understanding`
  String get quiz_title {
    return Intl.message(
      'Check your understanding',
      name: 'quiz_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose a category to begin!`
  String get quiz_desc {
    return Intl.message(
      'Choose a category to begin!',
      name: 'quiz_desc',
      desc: '',
      args: [],
    );
  }

  /// `Start now!`
  String get quiz_btn {
    return Intl.message('Start now!', name: 'quiz_btn', desc: '', args: []);
  }

  /// `question`
  String get screen15 {
    return Intl.message('question', name: 'screen15', desc: '', args: []);
  }

  /// `Question`
  String get question_num {
    return Intl.message('Question', name: 'question_num', desc: '', args: []);
  }

  /// `quizSubmit`
  String get screen16 {
    return Intl.message('quizSubmit', name: 'screen16', desc: '', args: []);
  }

  /// `Quiz Completed!`
  String get submit_title {
    return Intl.message(
      'Quiz Completed!',
      name: 'submit_title',
      desc: '',
      args: [],
    );
  }

  /// `You've reached the end of the quiz`
  String get submit_desc {
    return Intl.message(
      'You\'ve reached the end of the quiz',
      name: 'submit_desc',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit_btn1 {
    return Intl.message('Submit', name: 'submit_btn1', desc: '', args: []);
  }

  /// `Cancel`
  String get submit_btn2 {
    return Intl.message('Cancel', name: 'submit_btn2', desc: '', args: []);
  }

  /// `results`
  String get screen17 {
    return Intl.message('results', name: 'screen17', desc: '', args: []);
  }

  /// `Score`
  String get result_score1 {
    return Intl.message('Score', name: 'result_score1', desc: '', args: []);
  }

  /// `Out Of`
  String get result_score2 {
    return Intl.message('Out Of', name: 'result_score2', desc: '', args: []);
  }

  /// `Time`
  String get result_time {
    return Intl.message('Time', name: 'result_time', desc: '', args: []);
  }

  /// `Seconds`
  String get result_sec {
    return Intl.message('Seconds', name: 'result_sec', desc: '', args: []);
  }

  /// `Minutes`
  String get result_minutes {
    return Intl.message('Minutes', name: 'result_minutes', desc: '', args: []);
  }

  /// `Play Again`
  String get result_play {
    return Intl.message('Play Again', name: 'result_play', desc: '', args: []);
  }

  /// `Review Answers`
  String get result_review {
    return Intl.message(
      'Review Answers',
      name: 'result_review',
      desc: '',
      args: [],
    );
  }

  /// `Share Score`
  String get result_share {
    return Intl.message(
      'Share Score',
      name: 'result_share',
      desc: '',
      args: [],
    );
  }

  /// `Return Home`
  String get result_home {
    return Intl.message('Return Home', name: 'result_home', desc: '', args: []);
  }

  /// `Amazing!`
  String get result_amazing {
    return Intl.message('Amazing!', name: 'result_amazing', desc: '', args: []);
  }

  /// `Profile information`
  String get screen18 {
    return Intl.message(
      'Profile information',
      name: 'screen18',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get profile_username {
    return Intl.message(
      'Username',
      name: 'profile_username',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get profile_name {
    return Intl.message('Name', name: 'profile_name', desc: '', args: []);
  }

  /// `Email`
  String get profile_email {
    return Intl.message('Email', name: 'profile_email', desc: '', args: []);
  }

  /// `Current Password`
  String get profile_current_pass {
    return Intl.message(
      'Current Password',
      name: 'profile_current_pass',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get profile_new_pass {
    return Intl.message(
      'New Password',
      name: 'profile_new_pass',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get profile_confirm_pass {
    return Intl.message(
      'Confirm Password',
      name: 'profile_confirm_pass',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get profile_btn1 {
    return Intl.message(
      'Save Changes',
      name: 'profile_btn1',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get profile_btn2 {
    return Intl.message('Cancel', name: 'profile_btn2', desc: '', args: []);
  }

  /// `Profile`
  String get profile_title {
    return Intl.message('Profile', name: 'profile_title', desc: '', args: []);
  }

  /// `Failed to load profile data`
  String get profile_load_error {
    return Intl.message(
      'Failed to load profile data',
      name: 'profile_load_error',
      desc: '',
      args: [],
    );
  }

  /// `Choose from Gallery`
  String get profile_gallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'profile_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Take a Photo`
  String get profile_camera {
    return Intl.message(
      'Take a Photo',
      name: 'profile_camera',
      desc: '',
      args: [],
    );
  }

  /// `Remove Photo`
  String get profile_remove_photo {
    return Intl.message(
      'Remove Photo',
      name: 'profile_remove_photo',
      desc: '',
      args: [],
    );
  }

  /// `Username, name and email are required`
  String get profile_validation_required {
    return Intl.message(
      'Username, name and email are required',
      name: 'profile_validation_required',
      desc: '',
      args: [],
    );
  }

  /// `All password fields must be filled or left empty`
  String get profile_validation_passwords {
    return Intl.message(
      'All password fields must be filled or left empty',
      name: 'profile_validation_passwords',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profile_update_success {
    return Intl.message(
      'Profile updated successfully',
      name: 'profile_update_success',
      desc: '',
      args: [],
    );
  }

  /// `Saving...`
  String get profile_saving {
    return Intl.message(
      'Saving...',
      name: 'profile_saving',
      desc: '',
      args: [],
    );
  }

  /// `profile`
  String get screen19 {
    return Intl.message('profile', name: 'screen19', desc: '', args: []);
  }

  /// `Account`
  String get account_title {
    return Intl.message('Account', name: 'account_title', desc: '', args: []);
  }

  /// `Profile information`
  String get account_info {
    return Intl.message(
      'Profile information',
      name: 'account_info',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get account_lang {
    return Intl.message('Language', name: 'account_lang', desc: '', args: []);
  }

  /// `Arabic`
  String get lang_ar {
    return Intl.message('Arabic', name: 'lang_ar', desc: '', args: []);
  }

  /// `English`
  String get lang_en {
    return Intl.message('English', name: 'lang_en', desc: '', args: []);
  }

  /// `App mode`
  String get account_mode {
    return Intl.message('App mode', name: 'account_mode', desc: '', args: []);
  }

  /// `Translation Mode`
  String get mode_ass {
    return Intl.message(
      'Translation Mode',
      name: 'mode_ass',
      desc: '',
      args: [],
    );
  }

  /// `Educational Mode`
  String get mode_learn {
    return Intl.message(
      'Educational Mode',
      name: 'mode_learn',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about_title {
    return Intl.message('About', name: 'about_title', desc: '', args: []);
  }

  /// `About us`
  String get about_about {
    return Intl.message('About us', name: 'about_about', desc: '', args: []);
  }

  /// `Terms & Conditions`
  String get about_terms {
    return Intl.message(
      'Terms & Conditions',
      name: 'about_terms',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get about_privacy {
    return Intl.message(
      'Privacy Policy',
      name: 'about_privacy',
      desc: '',
      args: [],
    );
  }

  /// `App version`
  String get about_version {
    return Intl.message(
      'App version',
      name: 'about_version',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support_title {
    return Intl.message('Support', name: 'support_title', desc: '', args: []);
  }

  /// `Contact Us`
  String get support_contact {
    return Intl.message(
      'Contact Us',
      name: 'support_contact',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get support_help {
    return Intl.message(
      'Help Center',
      name: 'support_help',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  /// `Delete Account`
  String get account_delete {
    return Intl.message(
      'Delete Account',
      name: 'account_delete',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Account Deletion`
  String get delete_title {
    return Intl.message(
      'Confirm Account Deletion',
      name: 'delete_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get delete_desc {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'delete_desc',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_btn1 {
    return Intl.message(
      'Delete Account',
      name: 'delete_btn1',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get delete_btn2 {
    return Intl.message('Cancel', name: 'delete_btn2', desc: '', args: []);
  }

  /// `Confirm Logout`
  String get logout_title {
    return Intl.message(
      'Confirm Logout',
      name: 'logout_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logout_desc {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logout_desc',
      desc: '',
      args: [],
    );
  }

  /// `Leave Quiz?`
  String get quiz_leave_title {
    return Intl.message(
      'Leave Quiz?',
      name: 'quiz_leave_title',
      desc: '',
      args: [],
    );
  }

  /// `You will lose all your progress\nif you leave now.`
  String get quiz_leave_desc {
    return Intl.message(
      'You will lose all your progress\nif you leave now.',
      name: 'quiz_leave_desc',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get quiz_leave_btn {
    return Intl.message('Leave', name: 'quiz_leave_btn', desc: '', args: []);
  }

  /// `Stay`
  String get quiz_stay_btn {
    return Intl.message('Stay', name: 'quiz_stay_btn', desc: '', args: []);
  }

  /// `Quiz Completed!`
  String get quiz_completed_title {
    return Intl.message(
      'Quiz Completed!',
      name: 'quiz_completed_title',
      desc: '',
      args: [],
    );
  }

  /// `You've answered all {count} questions.`
  String quiz_answered_all(Object count) {
    return Intl.message(
      'You\'ve answered all $count questions.',
      name: 'quiz_answered_all',
      desc: '',
      args: [count],
    );
  }

  /// `You've answered {answered} of {total} questions.\nPlease answer all questions before submitting.`
  String quiz_answered_partial(Object answered, Object total) {
    return Intl.message(
      'You\'ve answered $answered of $total questions.\nPlease answer all questions before submitting.',
      name: 'quiz_answered_partial',
      desc: '',
      args: [answered, total],
    );
  }

  /// `No quizzes available`
  String get quiz_no_quizzes {
    return Intl.message(
      'No quizzes available',
      name: 'quiz_no_quizzes',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load quizzes`
  String get quiz_load_failed {
    return Intl.message(
      'Failed to load quizzes',
      name: 'quiz_load_failed',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't create a share link, please try again.`
  String get quiz_share_failed {
    return Intl.message(
      'Couldn\'t create a share link, please try again.',
      name: 'quiz_share_failed',
      desc: '',
      args: [],
    );
  }

  /// `No media`
  String get video_no_media {
    return Intl.message('No media', name: 'video_no_media', desc: '', args: []);
  }

  /// `Review Answers`
  String get review_answers {
    return Intl.message(
      'Review Answers',
      name: 'review_answers',
      desc: '',
      args: [],
    );
  }

  /// `Dictionary`
  String get dictionary_title {
    return Intl.message(
      'Dictionary',
      name: 'dictionary_title',
      desc: '',
      args: [],
    );
  }

  /// `Lessons`
  String get lessons_title {
    return Intl.message('Lessons', name: 'lessons_title', desc: '', args: []);
  }

  /// `All Lessons`
  String get all_lessons {
    return Intl.message('All Lessons', name: 'all_lessons', desc: '', args: []);
  }

  /// `Viewed`
  String get viewed {
    return Intl.message('Viewed', name: 'viewed', desc: '', args: []);
  }

  /// `Lesson {n}`
  String lessons_lesson_n(Object n) {
    return Intl.message(
      'Lesson $n',
      name: 'lessons_lesson_n',
      desc: '',
      args: [n],
    );
  }

  /// `{count} Lessons`
  String lessons_count_label(Object count) {
    return Intl.message(
      '$count Lessons',
      name: 'lessons_count_label',
      desc: '',
      args: [count],
    );
  }

  /// `No viewed lessons yet`
  String get lessons_empty_viewed {
    return Intl.message(
      'No viewed lessons yet',
      name: 'lessons_empty_viewed',
      desc: '',
      args: [],
    );
  }

  /// `Mark a lesson as done to see it here.`
  String get lessons_empty_viewed_hint {
    return Intl.message(
      'Mark a lesson as done to see it here.',
      name: 'lessons_empty_viewed_hint',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load lessons`
  String get lessons_load_failed {
    return Intl.message(
      'Failed to load lessons',
      name: 'lessons_load_failed',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't update lesson, please try again.`
  String get lessons_toggle_failed {
    return Intl.message(
      'Couldn\'t update lesson, please try again.',
      name: 'lessons_toggle_failed',
      desc: '',
      args: [],
    );
  }

  /// `Hand Description`
  String get video_hand_description {
    return Intl.message(
      'Hand Description',
      name: 'video_hand_description',
      desc: '',
      args: [],
    );
  }

  /// `Video unavailable`
  String get video_unavailable {
    return Intl.message(
      'Video unavailable',
      name: 'video_unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Showing results for ‘{q}’`
  String dictionary_results_for(Object q) {
    return Intl.message(
      'Showing results for ‘$q’',
      name: 'dictionary_results_for',
      desc: '',
      args: [q],
    );
  }

  /// `No words found`
  String get dictionary_no_results {
    return Intl.message(
      'No words found',
      name: 'dictionary_no_results',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load dictionary`
  String get dictionary_load_failed {
    return Intl.message(
      'Failed to load dictionary',
      name: 'dictionary_load_failed',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get email_required {
    return Intl.message(
      'Email is required',
      name: 'email_required',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get password_required {
    return Intl.message(
      'Password is required',
      name: 'password_required',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get name_required {
    return Intl.message(
      'Name is required',
      name: 'name_required',
      desc: '',
      args: [],
    );
  }

  /// `Both passwords must match`
  String get passwords_must_match {
    return Intl.message(
      'Both passwords must match',
      name: 'passwords_must_match',
      desc: '',
      args: [],
    );
  }

  /// `Or log in with`
  String get or_login_with {
    return Intl.message(
      'Or log in with',
      name: 'or_login_with',
      desc: '',
      args: [],
    );
  }

  /// `Or sign up with`
  String get or_signup_with {
    return Intl.message(
      'Or sign up with',
      name: 'or_signup_with',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the processing of`
  String get agree_processing {
    return Intl.message(
      'I agree to the processing of',
      name: 'agree_processing',
      desc: '',
      args: [],
    );
  }

  /// `Personal data`
  String get personal_data {
    return Intl.message(
      'Personal data',
      name: 'personal_data',
      desc: '',
      args: [],
    );
  }

  /// `User data is missing`
  String get user_data_missing {
    return Intl.message(
      'User data is missing',
      name: 'user_data_missing',
      desc: '',
      args: [],
    );
  }

  /// `Confirm mail`
  String get confirm_mail {
    return Intl.message(
      'Confirm mail',
      name: 'confirm_mail',
      desc: '',
      args: [],
    );
  }

  /// `Remaining`
  String get remaining {
    return Intl.message('Remaining', name: 'remaining', desc: '', args: []);
  }

  /// `Resend Code?`
  String get resend_code {
    return Intl.message(
      'Resend Code?',
      name: 'resend_code',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Please enter the full 4-digit code`
  String get otp_incomplete {
    return Intl.message(
      'Please enter the full 4-digit code',
      name: 'otp_incomplete',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enter_name {
    return Intl.message(
      'Enter your name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get enter_your_email {
    return Intl.message(
      'Enter Your Email',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Password`
  String get enter_your_password {
    return Intl.message(
      'Enter Your Password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Your Password`
  String get confirm_your_password {
    return Intl.message(
      'Confirm Your Password',
      name: 'confirm_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signup {
    return Intl.message('Sign up', name: 'signup', desc: '', args: []);
  }

  /// `Log in`
  String get login {
    return Intl.message('Log in', name: 'login', desc: '', args: []);
  }

  /// `Not found`
  String get not_found {
    return Intl.message('Not found', name: 'not_found', desc: '', args: []);
  }

  /// `Oops! we couldn't found that video.`
  String get not_found_desc {
    return Intl.message(
      'Oops! we couldn\'t found that video.',
      name: 'not_found_desc',
      desc: '',
      args: [],
    );
  }

  /// `Maybe try different keyword!`
  String get not_found_hint {
    return Intl.message(
      'Maybe try different keyword!',
      name: 'not_found_hint',
      desc: '',
      args: [],
    );
  }

  /// `No connection!`
  String get no_connection {
    return Intl.message(
      'No connection!',
      name: 'no_connection',
      desc: '',
      args: [],
    );
  }

  /// `It seems you're offline. Please check your connection and try again.`
  String get no_connection_desc {
    return Intl.message(
      'It seems you\'re offline. Please check your connection and try again.',
      name: 'no_connection_desc',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Contact us`
  String get contact_us {
    return Intl.message('Contact us', name: 'contact_us', desc: '', args: []);
  }

  /// `We welcome your inquiries`
  String get contact_welcome {
    return Intl.message(
      'We welcome your inquiries',
      name: 'contact_welcome',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get about_us_title {
    return Intl.message('About Us', name: 'about_us_title', desc: '', args: []);
  }

  /// `SignLingo`
  String get about_us_name {
    return Intl.message('SignLingo', name: 'about_us_name', desc: '', args: []);
  }

  /// `SignLingo is an accessible educational application designed to support deaf and mute individuals in learning and practicing sign language through interactive and user-friendly features.`
  String get about_us_desc {
    return Intl.message(
      'SignLingo is an accessible educational application designed to support deaf and mute individuals in learning and practicing sign language through interactive and user-friendly features.',
      name: 'about_us_desc',
      desc: '',
      args: [],
    );
  }

  /// `Allow Camera Access?`
  String get camera_allow_title {
    return Intl.message(
      'Allow Camera Access?',
      name: 'camera_allow_title',
      desc: '',
      args: [],
    );
  }

  /// `Allowing camera access is important for real-time translation so we can recognize your gestures`
  String get camera_allow_desc {
    return Intl.message(
      'Allowing camera access is important for real-time translation so we can recognize your gestures',
      name: 'camera_allow_desc',
      desc: '',
      args: [],
    );
  }

  /// `Grant Permission`
  String get camera_grant {
    return Intl.message(
      'Grant Permission',
      name: 'camera_grant',
      desc: '',
      args: [],
    );
  }

  /// `Maybe Later`
  String get camera_later {
    return Intl.message(
      'Maybe Later',
      name: 'camera_later',
      desc: '',
      args: [],
    );
  }

  /// `Your privacy is protected`
  String get camera_privacy {
    return Intl.message(
      'Your privacy is protected',
      name: 'camera_privacy',
      desc: '',
      args: [],
    );
  }

  /// `Low Visibility detected`
  String get low_visibility {
    return Intl.message(
      'Low Visibility detected',
      name: 'low_visibility',
      desc: '',
      args: [],
    );
  }

  /// `Please improve lighting for better accuracy. Dark environment may reduce translation speed and precision`
  String get low_visibility_desc {
    return Intl.message(
      'Please improve lighting for better accuracy. Dark environment may reduce translation speed and precision',
      name: 'low_visibility_desc',
      desc: '',
      args: [],
    );
  }

  /// `Turn on the flash`
  String get turn_flash {
    return Intl.message(
      'Turn on the flash',
      name: 'turn_flash',
      desc: '',
      args: [],
    );
  }

  /// `Try Anyway`
  String get try_anyway {
    return Intl.message('Try Anyway', name: 'try_anyway', desc: '', args: []);
  }

  /// `Live Hand Tracking`
  String get live_tracking {
    return Intl.message(
      'Live Hand Tracking',
      name: 'live_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Hand Landmarks Realtime`
  String get hand_landmarks {
    return Intl.message(
      'Hand Landmarks Realtime',
      name: 'hand_landmarks',
      desc: '',
      args: [],
    );
  }

  /// `Show your hands to the camera`
  String get vt_show_hands {
    return Intl.message(
      'Show your hands to the camera',
      name: 'vt_show_hands',
      desc: '',
      args: [],
    );
  }

  /// `Processing...`
  String get vt_processing {
    return Intl.message(
      'Processing...',
      name: 'vt_processing',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get vt_try_again {
    return Intl.message('Try Again', name: 'vt_try_again', desc: '', args: []);
  }

  /// `Reset`
  String get vt_reset {
    return Intl.message('Reset', name: 'vt_reset', desc: '', args: []);
  }

  /// `{count} frames`
  String vt_frames_collected(Object count) {
    return Intl.message(
      '$count frames',
      name: 'vt_frames_collected',
      desc: '',
      args: [count],
    );
  }

  /// `Recent`
  String get vt_recent {
    return Intl.message('Recent', name: 'vt_recent', desc: '', args: []);
  }

  /// `Quick Response`
  String get quick_response {
    return Intl.message(
      'Quick Response',
      name: 'quick_response',
      desc: '',
      args: [],
    );
  }

  /// `Add Phrase`
  String get add_phrase {
    return Intl.message('Add Phrase', name: 'add_phrase', desc: '', args: []);
  }

  /// `Enter phrase`
  String get enter_phrase {
    return Intl.message(
      'Enter phrase',
      name: 'enter_phrase',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Pin`
  String get pin {
    return Intl.message('Pin', name: 'pin', desc: '', args: []);
  }

  /// `Select All`
  String get select_all {
    return Intl.message('Select All', name: 'select_all', desc: '', args: []);
  }

  /// `Type a message`
  String get type_message {
    return Intl.message(
      'Type a message',
      name: 'type_message',
      desc: '',
      args: [],
    );
  }

  /// `Chat Text`
  String get chat_text {
    return Intl.message('Chat Text', name: 'chat_text', desc: '', args: []);
  }

  /// `User Text`
  String get user_text {
    return Intl.message('User Text', name: 'user_text', desc: '', args: []);
  }

  /// `I need medical help`
  String get qr_need_help {
    return Intl.message(
      'I need medical help',
      name: 'qr_need_help',
      desc: '',
      args: [],
    );
  }

  /// `Where is the bus station?`
  String get qr_bus {
    return Intl.message(
      'Where is the bus station?',
      name: 'qr_bus',
      desc: '',
      args: [],
    );
  }

  /// `How much does this cost?`
  String get qr_cost {
    return Intl.message(
      'How much does this cost?',
      name: 'qr_cost',
      desc: '',
      args: [],
    );
  }

  /// `Can you help me?`
  String get qr_help {
    return Intl.message(
      'Can you help me?',
      name: 'qr_help',
      desc: '',
      args: [],
    );
  }

  /// `Nice to meet you`
  String get qr_meet {
    return Intl.message(
      'Nice to meet you',
      name: 'qr_meet',
      desc: '',
      args: [],
    );
  }

  /// `I am deaf.`
  String get qr_deaf {
    return Intl.message('I am deaf.', name: 'qr_deaf', desc: '', args: []);
  }

  /// `I feel uncomfortable`
  String get qr_uncomfortable {
    return Intl.message(
      'I feel uncomfortable',
      name: 'qr_uncomfortable',
      desc: '',
      args: [],
    );
  }

  /// `I appreciate your help`
  String get qr_appreciate {
    return Intl.message(
      'I appreciate your help',
      name: 'qr_appreciate',
      desc: '',
      args: [],
    );
  }

  /// `Call the police`
  String get qr_police {
    return Intl.message(
      'Call the police',
      name: 'qr_police',
      desc: '',
      args: [],
    );
  }

  /// `Pinned`
  String get qr_pinned {
    return Intl.message('Pinned', name: 'qr_pinned', desc: '', args: []);
  }

  /// `All`
  String get qr_all_phrases {
    return Intl.message('All', name: 'qr_all_phrases', desc: '', args: []);
  }

  /// `No phrases yet`
  String get qr_empty_title {
    return Intl.message(
      'No phrases yet',
      name: 'qr_empty_title',
      desc: '',
      args: [],
    );
  }

  /// `Tap + to add your first phrase`
  String get qr_empty_hint {
    return Intl.message(
      'Tap + to add your first phrase',
      name: 'qr_empty_hint',
      desc: '',
      args: [],
    );
  }

  /// `Edit Phrase`
  String get qr_edit_phrase {
    return Intl.message(
      'Edit Phrase',
      name: 'qr_edit_phrase',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get qr_save {
    return Intl.message('Save', name: 'qr_save', desc: '', args: []);
  }

  /// `Delete phrase?`
  String get qr_delete_confirm_title {
    return Intl.message(
      'Delete phrase?',
      name: 'qr_delete_confirm_title',
      desc: '',
      args: [],
    );
  }

  /// `Delete {count} phrases?`
  String qr_delete_confirm_multi(Object count) {
    return Intl.message(
      'Delete $count phrases?',
      name: 'qr_delete_confirm_multi',
      desc: '',
      args: [count],
    );
  }

  /// `This cannot be undone.`
  String get qr_delete_confirm_desc {
    return Intl.message(
      'This cannot be undone.',
      name: 'qr_delete_confirm_desc',
      desc: '',
      args: [],
    );
  }

  /// `Text-to-speech is not available for this language on your device.`
  String get qr_tts_unavailable {
    return Intl.message(
      'Text-to-speech is not available for this language on your device.',
      name: 'qr_tts_unavailable',
      desc: '',
      args: [],
    );
  }

  /// `{count} Selected`
  String qr_n_selected(Object count) {
    return Intl.message(
      '$count Selected',
      name: 'qr_n_selected',
      desc: '',
      args: [count],
    );
  }

  /// `Terms & Conditions`
  String get screen22 {
    return Intl.message(
      'Terms & Conditions',
      name: 'screen22',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to SignLingo.\nBy downloading, accessing, or using this application, you agree to these Terms & Conditions.\nIf you do not agree, please do not use the app.\n\n1. About SignLingo\nSignLingo is an educational and communication support application designed to help deaf and mute users learn, understand, and practice sign language.\nThe app is not a medical, legal, or professional service and should not be used as a substitute for professional advice.\n\n2. Eligibility\nYou must be at least 13 years old to use SignLingo.\nIf you are under 13, a parent or legal guardian must approve your use of the app.\nBy using the app, you confirm that the information you provide is accurate.\n\n3. User Accounts\nYou are responsible for keeping your account information secure.\nYou are responsible for all activities that occur under your account.\nCreating fake accounts or misusing the app is not allowed.\n\n4. Acceptable Use\nYou agree to use SignLingo:\nIn a respectful and lawful manner\nOnly for its intended educational and communication purposes\nYou agree not to:\nMisuse or abuse the app\nAttempt to hack, copy, or modify the app\nUpload harmful, offensive, or inappropriate content\nUse the app in a way that may harm other users\n\n5. Camera, Video & Media Use\nSignLingo may request access to your device's camera or media features to:\nPractice or recognize sign language\nImprove learning and interaction\nWe do not record, store, or share videos or images unless:\nIt is clearly stated\nYou give explicit permission\nYou can manage permissions through your device settings at any time.\n\n6. Content Accuracy & Limitations\nSign language may vary by region, culture, and context.\nWhile we aim to provide accurate content, SignLingo does not guarantee 100% accuracy in translations or learning materials.\nThe app should be used as a learning aid, not a certified translation tool.\n\n7. Intellectual Property\nAll content in SignLingo, including:\nText\nVideos\nImages\nIcons\nDesign and branding\nis owned by SignLingo and protected by intellectual property laws.\nYou may not copy, distribute, or reuse any content without written permission.\n\n8. Privacy\nYour privacy matters to us. Any personal information collected is handled according to our Privacy Policy.\nPlease review the Privacy Policy to understand how your data is collected, used, and protected.\n\n9. Limitation of Liability\nSignLingo is provided "as is" and "as available."\nWe are not responsible for:\nMisinterpretations or misunderstandings\nErrors in translation or learning content\nAny direct or indirect damages resulting from using the app\nUse of the app is at your own responsibility.\n\n10. Account Suspension or Termination\nWe reserve the right to:\nSuspend or terminate accounts\nRestrict access\nif a user violates these Terms & Conditions or misuses the app.\n\n11. Changes to Terms\nWe may update these Terms & Conditions from time to time.\nContinued use of SignLingo after updates means you accept the revised terms.\n\n12. Contact Us\nIf you have questions, feedback, or need support, please contact us:\nsupport@signlingo.com\n\nAccessibility Commitment\nSignLingo is built with accessibility in mind.\nWe aim to provide:\nClear language\nInclusive design\nSupportive user experience for deaf and mute users`
  String get term_desc {
    return Intl.message(
      'Welcome to SignLingo.\nBy downloading, accessing, or using this application, you agree to these Terms & Conditions.\nIf you do not agree, please do not use the app.\n\n1. About SignLingo\nSignLingo is an educational and communication support application designed to help deaf and mute users learn, understand, and practice sign language.\nThe app is not a medical, legal, or professional service and should not be used as a substitute for professional advice.\n\n2. Eligibility\nYou must be at least 13 years old to use SignLingo.\nIf you are under 13, a parent or legal guardian must approve your use of the app.\nBy using the app, you confirm that the information you provide is accurate.\n\n3. User Accounts\nYou are responsible for keeping your account information secure.\nYou are responsible for all activities that occur under your account.\nCreating fake accounts or misusing the app is not allowed.\n\n4. Acceptable Use\nYou agree to use SignLingo:\nIn a respectful and lawful manner\nOnly for its intended educational and communication purposes\nYou agree not to:\nMisuse or abuse the app\nAttempt to hack, copy, or modify the app\nUpload harmful, offensive, or inappropriate content\nUse the app in a way that may harm other users\n\n5. Camera, Video & Media Use\nSignLingo may request access to your device\'s camera or media features to:\nPractice or recognize sign language\nImprove learning and interaction\nWe do not record, store, or share videos or images unless:\nIt is clearly stated\nYou give explicit permission\nYou can manage permissions through your device settings at any time.\n\n6. Content Accuracy & Limitations\nSign language may vary by region, culture, and context.\nWhile we aim to provide accurate content, SignLingo does not guarantee 100% accuracy in translations or learning materials.\nThe app should be used as a learning aid, not a certified translation tool.\n\n7. Intellectual Property\nAll content in SignLingo, including:\nText\nVideos\nImages\nIcons\nDesign and branding\nis owned by SignLingo and protected by intellectual property laws.\nYou may not copy, distribute, or reuse any content without written permission.\n\n8. Privacy\nYour privacy matters to us. Any personal information collected is handled according to our Privacy Policy.\nPlease review the Privacy Policy to understand how your data is collected, used, and protected.\n\n9. Limitation of Liability\nSignLingo is provided "as is" and "as available."\nWe are not responsible for:\nMisinterpretations or misunderstandings\nErrors in translation or learning content\nAny direct or indirect damages resulting from using the app\nUse of the app is at your own responsibility.\n\n10. Account Suspension or Termination\nWe reserve the right to:\nSuspend or terminate accounts\nRestrict access\nif a user violates these Terms & Conditions or misuses the app.\n\n11. Changes to Terms\nWe may update these Terms & Conditions from time to time.\nContinued use of SignLingo after updates means you accept the revised terms.\n\n12. Contact Us\nIf you have questions, feedback, or need support, please contact us:\nsupport@signlingo.com\n\nAccessibility Commitment\nSignLingo is built with accessibility in mind.\nWe aim to provide:\nClear language\nInclusive design\nSupportive user experience for deaf and mute users',
      name: 'term_desc',
      desc: '',
      args: [],
    );
  }
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
