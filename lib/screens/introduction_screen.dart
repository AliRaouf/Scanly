import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/model/introduction_items.dart';
import 'package:scanly/screens/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/custom_page_route.dart';

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
              count: controller.items.length,
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
                    child: Image.asset(controller.items[index].image,fit: BoxFit.contain,)),
                Text(controller.items[index].title,
                style: GoogleFonts.montserrat(color:Color(0xff232425),fontSize:16.sp,fontWeight:FontWeight.bold),
                ),
                 SizedBox(height: 10.h,),
                Text(controller.items[index].description,
                  style:GoogleFonts.nunito(color:Colors.grey,fontSize:14.sp), textAlign: TextAlign.center,),
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

