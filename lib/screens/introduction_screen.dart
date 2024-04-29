import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scanly/bloc/language/language_cubit.dart';
import 'package:scanly/model/introduction_items.dart';
import 'package:scanly/model/language_enums.dart';
import 'package:scanly/screens/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/custom_page_route.dart';
import '../generated/l10n.dart';
import '../model/introduction_info.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final controller =IntroductionItem();
  final pageController =PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    List<IntroductionInfo> items = [
      IntroductionInfo(
          title: S.of(context).welcome,
          description: S.of(context).intro_description1,
          image:("assets/images/logo_only.png")
      ),
      IntroductionInfo(
          title: S.of(context).intro_title2,
          description: S.of(context).intro_description2,
          image:("assets/images/how_it_works.png")
      ),
      IntroductionInfo(
          title: S.of(context).intro_title3,
          description: S.of(context).intro_description3,
          image:("assets/images/dr_recom.png")
      ),
      IntroductionInfo(
          title: S.of(context).intro_title4,
          description: S.of(context).intro_description4,
          image:("assets/images/health.png")
      ),

    ];
    return Scaffold(
      bottomSheet: Container(
        color: Color(0xfffafafa),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: isLastPage? getStarted() :  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: ()async{
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool("onboarding", true);
              if(!mounted)return;
              Navigator.push(
                  context,
                  AnimatedRoute(page: StartScreen()));},
                child: Text('Skip',style:GoogleFonts.montserrat(color:Color(0xff1684b5),fontSize:14.sp,fontWeight:FontWeight.w600),)),
            SmoothPageIndicator(
              controller: pageController,
              count: items.length,
            onDotClicked: (index)=> pageController.animateToPage(index,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeIn),
            effect: WormEffect(
              activeDotColor: Color(0xff1684b5)
            ),),
            TextButton(
                onPressed: ()=>pageController.nextPage(duration: Duration(microseconds: 600), curve: Curves.easeIn),
                child: Text('Next',style:GoogleFonts.montserrat(color:Color(0xff1684b5),fontSize:14.sp,fontWeight:FontWeight.w600))),
          ],
        ),
      ),
      body: Container(color: Color(0xfffafafa),
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        child: PageView.builder(
          onPageChanged: (index)=> setState(()=> isLastPage = controller.items.length-1 == index ),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context,index){
              return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 400.h,
                    child: Image.asset(items[index].image,fit: BoxFit.contain,)),
                Text(items[index].title,
                style: GoogleFonts.montserrat(color:Color(0xff232425),fontSize:16.sp,fontWeight:FontWeight.bold),
                ),
                 SizedBox(height: 10.h,),
                Text(items[index].description,
                  style:GoogleFonts.nunito(color:Colors.grey,fontSize:14.sp), textAlign: TextAlign.center,),
                index==0?TextButton(onPressed: ()async{
                  return await showLanguageDialog(context);

                }, child: Text("Select Language")):SizedBox.shrink()
              ],
              );
    }
      )
    ));
  }
 Widget getStarted(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Color(0xff1A83B6)),
      width: 0.6.sw,
      height: 50.h,
      child: TextButton(
          onPressed: ()async{
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool("onboarding", true);
            print(prefs.getBool("onboarding"));
            if(!mounted)return;
            Navigator.push(
                context,
                AnimatedRoute(page: StartScreen()));
            },
          child: Text("Get started",style: GoogleFonts.nunito(color:Color(0xfffafafa),fontSize:20.sp,fontWeight:FontWeight.bold),)),
    );
 }
}
Map<String, String> LocaleNames = {
  'en': 'English',
  'ar': 'العربية',
};
Future<void> showLanguageDialog(BuildContext context) async {
  String? selectedLanguageCode = await showDialog<String>(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: const Text('Select language'),
        children: [
          SimpleDialogOption(
            child: Text(LocaleNames['en'] ?? 'Unknown'),
            onPressed: () => Navigator.pop(context, 'en'),
          ),
          SimpleDialogOption(
            child: Text(LocaleNames['ar'] ?? 'Unknown'),
            onPressed: () => Navigator.pop(context, 'ar'),
          ),
        ],
      );
    },
  );

  if (selectedLanguageCode != null) {
    if(selectedLanguageCode=="ar"){
      LanguageCubit.get(context).languageFunction(LanguageEnums.ArabicLanguage);
    }else{
      LanguageCubit.get(context).languageFunction(LanguageEnums.EnglishLanguage);
    }
  }
}
