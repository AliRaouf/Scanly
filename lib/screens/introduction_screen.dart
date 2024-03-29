import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter/material.dart';
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
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage? getStarted() :  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){ Navigator.push(
                context,
                AnimatedRoute(page: StartScreen()));},
                child: const Text('Skip',style:TextStyle(color:Colors.cyan),)),
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
            onDotClicked: (index)=> pageController.animateToPage(index,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeIn),
            effect: WormEffect(
              activeDotColor: Colors.cyan
            ),),
            TextButton(
                onPressed: ()=>pageController.nextPage(duration: Duration(microseconds: 600), curve: Curves.easeIn),
                child: Text('Next',style:TextStyle(color:Colors.cyan),)),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index)=> setState(()=> isLastPage = controller.items.length-1 == index ),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context,index){
              return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(controller.items[index].image),
                const SizedBox(height: 15,),
                Text(controller.items[index].title,
                style: const TextStyle(fontSize:21,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15,),
                Text(controller.items[index].description,
                  style: const TextStyle(fontSize:17,color:Colors.grey), textAlign: TextAlign.center,),
    ],
              );
    }
      )
    ));
  }
 Widget getStarted(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.cyan),
      width: MediaQuery.of(context).size.width*0.9,
      height: 55,
      child: TextButton(
          onPressed: ()async{
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool("onboarding", true);

            if(!mounted)return;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StartScreen()));},
          child: Text("Get started",style: TextStyle(color:Colors.white),)),
    );
 }
}

