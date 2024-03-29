import 'introduction_info.dart';

class IntroductionItem{
  List<IntroductionInfo> items = [
    IntroductionInfo(
        title: 'Welcome to Scanly',
        description: 'Your personal medical test analysis assistant',
        image:("assets/images/logo_only.png")
    ),
    IntroductionInfo(
        title: 'Simple Test Analysis Process',
        description: 'Upload your test results, let our app analyze them, and receive valuable insights',
        image:("assets/images/how_it_works.png")
    ),
    IntroductionInfo(
        title: 'Tailored Recommendations',
        description: 'Receive personalized suggestions based on your unique test results',
        image:("assets/images/dr_recom.png")
    ),
    IntroductionInfo(
        title: 'Stay Updated on Your Health',
        description: 'Track your progress, set reminders, and gain insights into your well-being.',
        image:("assets/images/health.png")
    ),

  ];
}