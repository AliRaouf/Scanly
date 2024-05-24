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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to Scanly`
  String get welcome {
    return Intl.message(
      'Welcome to Scanly',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Simple Test Analysis Process`
  String get intro_title2 {
    return Intl.message(
      'Simple Test Analysis Process',
      name: 'intro_title2',
      desc: '',
      args: [],
    );
  }

  /// `Tailored Recommendations`
  String get intro_title3 {
    return Intl.message(
      'Tailored Recommendations',
      name: 'intro_title3',
      desc: '',
      args: [],
    );
  }

  /// `Stay Updated on Your Health`
  String get intro_title4 {
    return Intl.message(
      'Stay Updated on Your Health',
      name: 'intro_title4',
      desc: '',
      args: [],
    );
  }

  /// `Your personal medical test analysis assistant`
  String get intro_description1 {
    return Intl.message(
      'Your personal medical test analysis assistant',
      name: 'intro_description1',
      desc: '',
      args: [],
    );
  }

  /// `Upload your test results, let our app analyze them, and receive valuable insights`
  String get intro_description2 {
    return Intl.message(
      'Upload your test results, let our app analyze them, and receive valuable insights',
      name: 'intro_description2',
      desc: '',
      args: [],
    );
  }

  /// `Receive personalized suggestions based on your unique test results`
  String get intro_description3 {
    return Intl.message(
      'Receive personalized suggestions based on your unique test results',
      name: 'intro_description3',
      desc: '',
      args: [],
    );
  }

  /// `Track your progress, set reminders, and gain insights into your well-being.`
  String get intro_description4 {
    return Intl.message(
      'Track your progress, set reminders, and gain insights into your well-being.',
      name: 'intro_description4',
      desc: '',
      args: [],
    );
  }

  /// `We are Happy that you are here our mission is to provide you with information about your tests from where you are`
  String get start {
    return Intl.message(
      'We are Happy that you are here our mission is to provide you with information about your tests from where you are',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account`
  String get create_account {
    return Intl.message(
      'Create New Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Add a profile picture`
  String get add_picture {
    return Intl.message(
      'Add a profile picture',
      name: 'add_picture',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `PhoneNumber`
  String get phone {
    return Intl.message(
      'PhoneNumber',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Date Of Birth`
  String get birth {
    return Intl.message(
      'Date Of Birth',
      name: 'birth',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Medical History`
  String get medical_history {
    return Intl.message(
      'Medical History',
      name: 'medical_history',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_message {
    return Intl.message(
      'Continue',
      name: 'continue_message',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `HighBloodPressure`
  String get pressure {
    return Intl.message(
      'HighBloodPressure',
      name: 'pressure',
      desc: '',
      args: [],
    );
  }

  /// `non`
  String get non_MH {
    return Intl.message(
      'none',
      name: 'non_MH',
      desc: '',
      args: [],
    );
  }

  /// `High Cholestrol`
  String get Cholestrol {
    return Intl.message(
      'High Cholestrol',
      name: 'Cholestrol',
      desc: '',
      args: [],
    );
  }

  /// `Arthritis`
  String get Arthritis {
    return Intl.message(
      'Arthritis',
      name: 'Arthritis',
      desc: '',
      args: [],
    );
  }

  /// `Ischemic/Coronary Heart Disease`
  String get Heart_Disease {
    return Intl.message(
      'Ischemic/Coronary Heart Disease',
      name: 'Heart_Disease',
      desc: '',
      args: [],
    );
  }

  /// `Diabetes`
  String get Diabetes {
    return Intl.message(
      'Diabetes',
      name: 'Diabetes',
      desc: '',
      args: [],
    );
  }

  /// `Chronic Kidney Disease`
  String get Chronic_Kidney_Disease {
    return Intl.message(
      'Chronic Kidney Disease',
      name: 'Chronic_Kidney_Disease',
      desc: '',
      args: [],
    );
  }

  /// `Heart Failure`
  String get Heart_Failure {
    return Intl.message(
      'Heart Failure',
      name: 'Heart_Failure',
      desc: '',
      args: [],
    );
  }

  /// `Breast cancer`
  String get Breast_cancer {
    return Intl.message(
      'Breast cancer',
      name: 'Breast_cancer',
      desc: '',
      args: [],
    );
  }

  /// `Alzheimer and Dementia`
  String get Alzheimer {
    return Intl.message(
      'Alzheimer and Dementia',
      name: 'Alzheimer',
      desc: '',
      args: [],
    );
  }

  /// `COPD (Chronic Obstructive Pulmonary Disease`
  String get COPD {
    return Intl.message(
      'COPD (Chronic Obstructive Pulmonary Disease',
      name: 'COPD',
      desc: '',
      args: [],
    );
  }

  /// `Stroke`
  String get Stroke {
    return Intl.message(
      'Stroke',
      name: 'Stroke',
      desc: '',
      args: [],
    );
  }

  /// `Lung cancer`
  String get Lung_cancer {
    return Intl.message(
      'Lung cancer',
      name: 'Lung_cancer',
      desc: '',
      args: [],
    );
  }

  /// `Colorectal cancer`
  String get Colorectal_cancer {
    return Intl.message(
      'Colorectal cancer',
      name: 'Colorectal_cancer',
      desc: '',
      args: [],
    );
  }

  /// `Cervical cancer`
  String get Cervical_cancer {
    return Intl.message(
      'Cervical cancer',
      name: 'Cervical_cancer',
      desc: '',
      args: [],
    );
  }

  /// `Hyperlipidaemia`
  String get Hyperlipidaemia {
    return Intl.message(
      'Hyperlipidaemia',
      name: 'Hyperlipidaemia',
      desc: '',
      args: [],
    );
  }

  /// `Prostate Cancer`
  String get Prostate_Cancer {
    return Intl.message(
      'Prostate Cancer',
      name: 'Prostate_Cancer',
      desc: '',
      args: [],
    );
  }

  /// `Liver Cancer`
  String get Liver_Cancer {
    return Intl.message(
      'Liver Cancer',
      name: 'Liver_Cancer',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get sign_in {
    return Intl.message(
      'Sign in',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign up!`
  String get sign_up {
    return Intl.message(
      'Sign up!',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get remember_me {
    return Intl.message(
      'Remember Me',
      name: 'remember_me',
      desc: '',
      args: [],
    );
  }

  /// `Forget Your Password?`
  String get forget_password {
    return Intl.message(
      'Forget Your Password?',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account`
  String get Dont_have_account {
    return Intl.message(
      'Don\'t have an account',
      name: 'Dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `UserName`
  String get user_name {
    return Intl.message(
      'UserName',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get scan {
    return Intl.message(
      'Scan',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `Commen Tests`
  String get commen_tests {
    return Intl.message(
      'Commen Tests',
      name: 'commen_tests',
      desc: '',
      args: [],
    );
  }

  /// `Blood`
  String get blood {
    return Intl.message(
      'Blood',
      name: 'blood',
      desc: '',
      args: [],
    );
  }

  /// `Genetic`
  String get genetic {
    return Intl.message(
      'Genetic',
      name: 'genetic',
      desc: '',
      args: [],
    );
  }

  /// `Urine`
  String get urine {
    return Intl.message(
      'Urine',
      name: 'urine',
      desc: '',
      args: [],
    );
  }

  /// `Tests`
  String get test {
    return Intl.message(
      'Tests',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `Search for a test`
  String get search_test {
    return Intl.message(
      'Search for a test',
      name: 'search_test',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get health {
    return Intl.message(
      'Health',
      name: 'health',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Welcome `
  String get welcome_name {
    return Intl.message(
      'Welcome ',
      name: 'welcome_name',
      desc: '',
      args: [],
    );
  }

  /// `Upload your test`
  String get Upload_test {
    return Intl.message(
      'Upload your test',
      name: 'Upload_test',
      desc: '',
      args: [],
    );
  }

  /// `Use your Camera`
  String get Use_Camera {
    return Intl.message(
      'Use your Camera',
      name: 'Use_Camera',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR Code`
  String get Scan_QR {
    return Intl.message(
      'Scan QR Code',
      name: 'Scan_QR',
      desc: '',
      args: [],
    );
  }

  /// `Health Check`
  String get health_check {
    return Intl.message(
      'Health Check',
      name: 'health_check',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Change User Data`
  String get change_userdata {
    return Intl.message(
      'Change User Data',
      name: 'change_userdata',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message(
      'Security',
      name: 'security',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Legal`
  String get legal {
    return Intl.message(
      'Legal',
      name: 'legal',
      desc: '',
      args: [],
    );
  }

  /// `View Legal Terms & Conditions`
  String get view_legal {
    return Intl.message(
      'View Legal Terms & Conditions',
      name: 'view_legal',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Change your Data`
  String get Change_Data {
    return Intl.message(
      'Change your Data',
      name: 'Change_Data',
      desc: '',
      args: [],
    );
  }

  /// `Choose a new Profile Picture`
  String get choose_new_picture {
    return Intl.message(
      'Choose a new Profile Picture',
      name: 'choose_new_picture',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Want to Change your Password?`
  String get Want_Change_Password {
    return Intl.message(
      'Want to Change your Password?',
      name: 'Want_Change_Password',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get old_password {
    return Intl.message(
      'Old Password',
      name: 'old_password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get password_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `error`
  String get error {
    return Intl.message(
      'error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `You have not added any tests yet\nStart Adding Now!`
  String get no_tests_added {
    return Intl.message(
      'You have not added any tests yet\nStart Adding Now!',
      name: 'no_tests_added',
      desc: '',
      args: [],
    );
  }

  /// `Fantastic news!\nBased on your latest test results, your health is on an upward trend. Keep up the great work!`
  String get good_health {
    return Intl.message(
      'Fantastic news!\nBased on your latest test results, your health is on an upward trend. Keep up the great work!',
      name: 'good_health',
      desc: '',
      args: [],
    );
  }

  /// `We noticed a decline in your recent health data that need a closer look. While this doesn't necessarily indicate a problem, it's important to be careful about your well-bein`
  String get bad_health {
    return Intl.message(
      'We noticed a decline in your recent health data that need a closer look. While this doesn\'t necessarily indicate a problem, it\'s important to be careful about your well-being',
      name: 'bad_health',
      desc: '',
      args: [],
    );
  }

  /// `Should You See a Doctor?`
  String get See_Doctor {
    return Intl.message(
      'Should You See a Doctor?',
      name: 'See_Doctor',
      desc: '',
      args: [],
    );
  }

  /// `Getting Your Results!`
  String get loading1 {
    return Intl.message(
      'Getting Your Results!',
      name: 'loading1',
      desc: '',
      args: [],
    );
  }

  /// `Feeling tired? Drinking plenty of water can boost your energy levels.`
  String get loading2 {
    return Intl.message(
      'Feeling tired? Drinking plenty of water can boost your energy levels.',
      name: 'loading2',
      desc: '',
      args: [],
    );
  }

  /// `Getting enough sleep is essential for managing stress, Aim for 7-9 hours of quality sleep per night`
  String get loading3 {
    return Intl.message(
      'Getting enough sleep is essential for managing stress, Aim for 7-9 hours of quality sleep per night',
      name: 'loading3',
      desc: '',
      args: [],
    );
  }

  /// `Swap out sugary snacks for healthier options like fruit, yogurt, or nuts to keep your energy up`
  String get loading4 {
    return Intl.message(
      'Swap out sugary snacks for healthier options like fruit, yogurt, or nuts to keep your energy up',
      name: 'loading4',
      desc: '',
      args: [],
    );
  }

  /// `Break up long periods of sitting by stretching or taking short walks to keep your body feeling good`
  String get loading5 {
    return Intl.message(
      'Break up long periods of sitting by stretching or taking short walks to keep your body feeling good',
      name: 'loading5',
      desc: '',
      args: [],
    );
  }

  /// `Password Changed Successfully`
  String get Password_Changed_Successfully {
    return Intl.message(
      'Password Changed Successfully',
      name: 'Password_Changed_Successfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed To Change Password`
  String get Failed_Change_Password {
    return Intl.message(
      'Failed To Change Password',
      name: 'Failed_Change_Password',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get Change_Password {
    return Intl.message(
      'Change Password',
      name: 'Change_Password',
      desc: '',
      args: [],
    );
  }

  /// `Data Changed Successfully`
  String get Data_Changed_Successfully {
    return Intl.message(
      'Data Changed Successfully',
      name: 'Data_Changed_Successfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed To Change Data`
  String get Failed_Change_Data {
    return Intl.message(
      'Failed To Change Data',
      name: 'Failed_Change_Data',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get Reset_Password {
    return Intl.message(
      'Reset Password',
      name: 'Reset_Password',
      desc: '',
      args: [],
    );
  }

  /// `Successfully Sent an email to`
  String get Successfully_Sent_email {
    return Intl.message(
      'Successfully Sent an email to',
      name: 'Successfully_Sent_email',
      desc: '',
      args: [],
    );
  }

  /// `Don't Worry it happens, Please enter the email linked with your account.`
  String get Please_enter_email_linked {
    return Intl.message(
      'Don\'t Worry it happens, Please enter the email linked with your account.',
      name: 'Please_enter_email_linked',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Email Address`
  String get Enter_Email {
    return Intl.message(
      'Enter your Email Address',
      name: 'Enter_Email',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get Success {
    return Intl.message(
      'Success',
      name: 'Success',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get Skip {
    return Intl.message(
      'Skip',
      name: 'Skip',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `Get started`
  String get Get_started {
    return Intl.message(
      'Get started',
      name: 'Get_started',
      desc: '',
      args: [],
    );
  }

  /// `Introduction`
  String get Introduction {
    return Intl.message(
      'Introduction',
      name: 'Introduction',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Scanly our Medical Lab Test Analysis App, designed to provide insightful analysis of your laboratory test results using advanced machine learning (ML) models. By utilizing our app, you agree to abide by these Terms and Conditions. Please read them carefully before using the app.`
  String get legal_intro {
    return Intl.message(
      'Welcome to Scanly our Medical Lab Test Analysis App, designed to provide insightful analysis of your laboratory test results using advanced machine learning (ML) models. By utilizing our app, you agree to abide by these Terms and Conditions. Please read them carefully before using the app.',
      name: 'legal_intro',
      desc: '',
      args: [],
    );
  }

  /// `Acceptance of Terms`
  String get Acceptance_Terms {
    return Intl.message(
      'Acceptance of Terms',
      name: 'Acceptance_Terms',
      desc: '',
      args: [],
    );
  }

  /// `By accessing or using our app, you confirm that you agree to these terms and understand them. If you do not agree with them, you should not use our app.`
  String get legal_term {
    return Intl.message(
      'By accessing or using our app, you confirm that you agree to these terms and understand them. If you do not agree with them, you should not use our app.',
      name: 'legal_term',
      desc: '',
      args: [],
    );
  }

  /// `Description of Service`
  String get Description_Service {
    return Intl.message(
      'Description of Service',
      name: 'Description_Service',
      desc: '',
      args: [],
    );
  }

  /// `Scanly offers users the capability to input their medical lab test results, which are then analyzed by our proprietary machine learning algorithms to provide insightful interpretations. These interpretations are designed to supplement, not replace, professional medical advice.`
  String get legal_dedcription {
    return Intl.message(
      'Scanly offers users the capability to input their medical lab test results, which are then analyzed by our proprietary machine learning algorithms to provide insightful interpretations. These interpretations are designed to supplement, not replace, professional medical advice.',
      name: 'legal_dedcription',
      desc: '',
      args: [],
    );
  }

  /// `Medical Disclaimer`
  String get Medical_Disclaimer {
    return Intl.message(
      'Medical Disclaimer',
      name: 'Medical_Disclaimer',
      desc: '',
      args: [],
    );
  }

  /// `• Not a Medical Service: Our app does not provide medical services, diagnoses, treatments, or engage in any conduct that requires a professional license.\n• Supplementary Tool: The insights provided by our app serve as a supplementary tool for your understanding and are not intended as a sole basis for any diagnostics or treatment decisions.\n• Consult Health Professionals: Always seek the advice of your doctor or other qualified health provider with any questions you may have regarding a medical condition. Do not disregard professional medical advice or delay in seeking it because of something you have read on or accessed through our App.\n• No Liability for Accuracy: While we strive to use commercially acceptable means to ensure the accuracy of our machine learning models, we cannot guarantee that the provided information is accurate, complete, or applicable to your individual circumstances.`
  String get legal_medical {
    return Intl.message(
      '• Not a Medical Service: Our app does not provide medical services, diagnoses, treatments, or engage in any conduct that requires a professional license.\n• Supplementary Tool: The insights provided by our app serve as a supplementary tool for your understanding and are not intended as a sole basis for any diagnostics or treatment decisions.\n• Consult Health Professionals: Always seek the advice of your doctor or other qualified health provider with any questions you may have regarding a medical condition. Do not disregard professional medical advice or delay in seeking it because of something you have read on or accessed through our App.\n• No Liability for Accuracy: While we strive to use commercially acceptable means to ensure the accuracy of our machine learning models, we cannot guarantee that the provided information is accurate, complete, or applicable to your individual circumstances.',
      name: 'legal_medical',
      desc: '',
      args: [],
    );
  }

  /// `User Responsibilities`
  String get User_Responsibilities {
    return Intl.message(
      'User Responsibilities',
      name: 'User_Responsibilities',
      desc: '',
      args: [],
    );
  }

  /// `• Input Accuracy: You are responsible for ensuring that the information you input into the app is accurate and complete.\n• Use Compliance: You agree to use the app only for its intended purposes and not engage in any misuse of the app or its content.`
  String get legal_responsibiliy {
    return Intl.message(
      '• Input Accuracy: You are responsible for ensuring that the information you input into the app is accurate and complete.\n• Use Compliance: You agree to use the app only for its intended purposes and not engage in any misuse of the app or its content.',
      name: 'legal_responsibiliy',
      desc: '',
      args: [],
    );
  }

  /// `Intellectual Property Rights`
  String get Intellectual_Property {
    return Intl.message(
      'Intellectual Property Rights',
      name: 'Intellectual_Property',
      desc: '',
      args: [],
    );
  }

  /// `The content, features, and functionality of the app are and will remain the exclusive property of Scanly and its licensors. Our intellectual property may not be used in connection with any product or service without the prior written consent of Scanly.`
  String get legal_property {
    return Intl.message(
      'The content, features, and functionality of the app are and will remain the exclusive property of Scanly and its licensors. Our intellectual property may not be used in connection with any product or service without the prior written consent of Scanly.',
      name: 'legal_property',
      desc: '',
      args: [],
    );
  }

  /// `Limitation of Liability`
  String get Limitation_Liability {
    return Intl.message(
      'Limitation of Liability',
      name: 'Limitation_Liability',
      desc: '',
      args: [],
    );
  }

  /// `In no event will [Your Company Name], its directors, employees, partners, agents, or affiliates be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from:\n• Your access to or use of or inability to access or use the app.\n• Any conduct or content of any third party on the service.\n• Unauthorized access, use, or alteration of your transmissions or content.`
  String get legal_limitation {
    return Intl.message(
      'In no event will [Your Company Name], its directors, employees, partners, agents, or affiliates be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from:\n• Your access to or use of or inability to access or use the app.\n• Any conduct or content of any third party on the service.\n• Unauthorized access, use, or alteration of your transmissions or content.',
      name: 'legal_limitation',
      desc: '',
      args: [],
    );
  }

  /// `Jurisdiction`
  String get Jurisdiction {
    return Intl.message(
      'Jurisdiction',
      name: 'Jurisdiction',
      desc: '',
      args: [],
    );
  }

  /// `These Terms shall be governed and construed in accordance with the laws of Egypt, without regard to its conflict of law provisions.`
  String get legal_Jurisdiction {
    return Intl.message(
      'These Terms shall be governed and construed in accordance with the laws of Egypt, without regard to its conflict of law provisions.',
      name: 'legal_Jurisdiction',
      desc: '',
      args: [],
    );
  }

  /// `Changes to Terms`
  String get Changes_Terms {
    return Intl.message(
      'Changes to Terms',
      name: 'Changes_Terms',
      desc: '',
      args: [],
    );
  }

  /// `We reserve the right, at our sole discretion, to modify or replace these terms at any time. If a revision is material, we will provide at least 30 days notice prior to any new terms taking effect.`
  String get legal_changeTerm {
    return Intl.message(
      'We reserve the right, at our sole discretion, to modify or replace these terms at any time. If a revision is material, we will provide at least 30 days notice prior to any new terms taking effect.',
      name: 'legal_changeTerm',
      desc: '',
      args: [],
    );
  }

  /// `Congrats`
  String get Congrats {
    return Intl.message(
      'Congrats',
      name: 'Congrats',
      desc: '',
      args: [],
    );
  }

  /// `Not Verified`
  String get Not_Verified {
    return Intl.message(
      'Not Verified',
      name: 'Not_Verified',
      desc: '',
      args: [],
    );
  }

  /// `We sent you a mail to verify your account`
  String get sent_mail_verify_account {
    return Intl.message(
      'We sent you a mail to verify your account',
      name: 'sent_mail_verify_account',
      desc: '',
      args: [],
    );
  }

  /// `Please Pick a Gender`
  String get grnder_message {
    return Intl.message(
      'Please Pick a Gender',
      name: 'grnder_message',
      desc: '',
      args: [],
    );
  }

  /// `Please add your height`
  String get height_message {
    return Intl.message(
      'Please add your height',
      name: 'height_message',
      desc: '',
      args: [],
    );
  }

  /// `Please add your weight`
  String get weight_message {
    return Intl.message(
      'Please add your weight',
      name: 'weight_message',
      desc: '',
      args: [],
    );
  }

  /// `We are Happy that you are here our mission is to provide you with information about your tests from where you are`
  String get welcome_message {
    return Intl.message(
      'We are Happy that you are here our mission is to provide you with information about your tests from where you are',
      name: 'welcome_message',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to upload this Test?`
  String get upload_message {
    return Intl.message(
      'Are you sure you want to upload this Test?',
      name: 'upload_message',
      desc: '',
      args: [],
    );
  }

  /// `Introduction`
  String get Legal_intro {
    return Intl.message(
      'Introduction',
      name: 'Legal_intro',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Scanly our Medical Lab Test Analysis App, designed to provide insightful analysis of your laboratory test results using advanced machine learning (ML) models. By utilizing our app, you agree to abide by these Terms and Conditions. Please read them carefully before using the app.`
  String get Legal_intro_words {
    return Intl.message(
      'Welcome to Scanly our Medical Lab Test Analysis App, designed to provide insightful analysis of your laboratory test results using advanced machine learning (ML) models. By utilizing our app, you agree to abide by these Terms and Conditions. Please read them carefully before using the app.',
      name: 'Legal_intro_words',
      desc: '',
      args: [],
    );
  }

  /// `Acceptance of Terms`
  String get Legal_Acceptance {
    return Intl.message(
      'Acceptance of Terms',
      name: 'Legal_Acceptance',
      desc: '',
      args: [],
    );
  }

  /// `By accessing or using our app, you confirm that you agree to these terms and understand them. If you do not agree with them, you should not use our app.`
  String get Legal_Acceptance_words {
    return Intl.message(
      'By accessing or using our app, you confirm that you agree to these terms and understand them. If you do not agree with them, you should not use our app.',
      name: 'Legal_Acceptance_words',
      desc: '',
      args: [],
    );
  }

  /// `Description of Service`
  String get Legal_Service {
    return Intl.message(
      'Description of Service',
      name: 'Legal_Service',
      desc: '',
      args: [],
    );
  }

  /// `Scanly offers users the capability to input their medical lab test results, which are then analyzed by our proprietary machine learning algorithms to provide insightful interpretations. These interpretations are designed to supplement, not replace, professional medical advice.`
  String get Legal_Service_words {
    return Intl.message(
      'Scanly offers users the capability to input their medical lab test results, which are then analyzed by our proprietary machine learning algorithms to provide insightful interpretations. These interpretations are designed to supplement, not replace, professional medical advice.',
      name: 'Legal_Service_words',
      desc: '',
      args: [],
    );
  }

  /// `Medical Disclaimer`
  String get Legal_Disclaimer {
    return Intl.message(
      'Medical Disclaimer',
      name: 'Legal_Disclaimer',
      desc: '',
      args: [],
    );
  }

  /// `• Not a Medical Service: Our app does not provide medical services, diagnoses, treatments, or engage in any conduct that requires a professional license.\n• Supplementary Tool: The insights provided by our app serve as a supplementary tool for your understanding and are not intended as a sole basis for any diagnostics or treatment decisions.\n• Consult Health Professionals: Always seek the advice of your doctor or other qualified health provider with any questions you may have regarding a medical condition. Do not disregard professional medical advice or delay in seeking it because of something you have read on or accessed through our App.\n• No Liability for Accuracy: While we strive to use commercially acceptable means to ensure the accuracy of our machine learning models, we cannot guarantee that the provided information is accurate, complete, or applicable to your individual circumstances.`
  String get Legal_Disclaimer_Words {
    return Intl.message(
      '• Not a Medical Service: Our app does not provide medical services, diagnoses, treatments, or engage in any conduct that requires a professional license.\n• Supplementary Tool: The insights provided by our app serve as a supplementary tool for your understanding and are not intended as a sole basis for any diagnostics or treatment decisions.\n• Consult Health Professionals: Always seek the advice of your doctor or other qualified health provider with any questions you may have regarding a medical condition. Do not disregard professional medical advice or delay in seeking it because of something you have read on or accessed through our App.\n• No Liability for Accuracy: While we strive to use commercially acceptable means to ensure the accuracy of our machine learning models, we cannot guarantee that the provided information is accurate, complete, or applicable to your individual circumstances.',
      name: 'Legal_Disclaimer_Words',
      desc: '',
      args: [],
    );
  }

  /// `User Responsibilities`
  String get Legal_Responsibility {
    return Intl.message(
      'User Responsibilities',
      name: 'Legal_Responsibility',
      desc: '',
      args: [],
    );
  }

  /// `• Input Accuracy: You are responsible for ensuring that the information you input into the app is accurate and complete.\n• Use Compliance: You agree to use the app only for its intended purposes and not engage in any misuse of the app or its content.`
  String get Legal_Responsibility_words {
    return Intl.message(
      '• Input Accuracy: You are responsible for ensuring that the information you input into the app is accurate and complete.\n• Use Compliance: You agree to use the app only for its intended purposes and not engage in any misuse of the app or its content.',
      name: 'Legal_Responsibility_words',
      desc: '',
      args: [],
    );
  }

  /// `Intellectual Property Rights`
  String get Legal_Property {
    return Intl.message(
      'Intellectual Property Rights',
      name: 'Legal_Property',
      desc: '',
      args: [],
    );
  }

  /// `The content, features, and functionality of the app are and will remain the exclusive property of Scanly and its licensors. Our intellectual property may not be used in connection with any product or service without the prior written consent of Scanly.`
  String get Legal_Property_words {
    return Intl.message(
      'The content, features, and functionality of the app are and will remain the exclusive property of Scanly and its licensors. Our intellectual property may not be used in connection with any product or service without the prior written consent of Scanly.',
      name: 'Legal_Property_words',
      desc: '',
      args: [],
    );
  }

  /// `Limitation of Liability`
  String get Legal_Liability {
    return Intl.message(
      'Limitation of Liability',
      name: 'Legal_Liability',
      desc: '',
      args: [],
    );
  }

  /// `In no event will Scanly, its directors, employees, partners, agents, or affiliates be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from:\n• Your access to or use of or inability to access or use the app.\n• Any conduct or content of any third party on the service.\n• Unauthorized access, use, or alteration of your transmissions or content.`
  String get Legal_Liability_words {
    return Intl.message(
      'In no event will Scanly, its directors, employees, partners, agents, or affiliates be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from:\n• Your access to or use of or inability to access or use the app.\n• Any conduct or content of any third party on the service.\n• Unauthorized access, use, or alteration of your transmissions or content.',
      name: 'Legal_Liability_words',
      desc: '',
      args: [],
    );
  }

  /// `Jurisdiction`
  String get Legal_Jury {
    return Intl.message(
      'Jurisdiction',
      name: 'Legal_Jury',
      desc: '',
      args: [],
    );
  }

  /// `These Terms shall be governed and construed in accordance with the laws of Egypt, without regard to its conflict of law provisions.`
  String get Legal_Jury_words {
    return Intl.message(
      'These Terms shall be governed and construed in accordance with the laws of Egypt, without regard to its conflict of law provisions.',
      name: 'Legal_Jury_words',
      desc: '',
      args: [],
    );
  }

  /// `Changes to Terms`
  String get Legal_Change {
    return Intl.message(
      'Changes to Terms',
      name: 'Legal_Change',
      desc: '',
      args: [],
    );
  }

  /// `We reserve the right, at our sole discretion, to modify or replace these terms at any time. If a revision is material, we will provide at least 30 days notice prior to any new terms taking effect.`
  String get Legal_Change_words {
    return Intl.message(
      'We reserve the right, at our sole discretion, to modify or replace these terms at any time. If a revision is material, we will provide at least 30 days notice prior to any new terms taking effect.',
      name: 'Legal_Change_words',
      desc: '',
      args: [],
    );
  }

  /// `Test Name:`
  String get test_Name {
    return Intl.message(
      'Test Name:',
      name: 'test_Name',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get Date_Test {
    return Intl.message(
      'Date',
      name: 'Date_Test',
      desc: '',
      args: [],
    );
  }

  /// `Account Created`
  String get Account_Created {
    return Intl.message(
      'Account Created',
      name: 'Account_Created',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Email or Password`
  String get login_Error {
    return Intl.message(
      'Wrong Email or Password',
      name: 'login_Error',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get change_language {
    return Intl.message(
      'Select Language',
      name: 'change_language',
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
