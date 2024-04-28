import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LegalTermsConditions extends StatelessWidget {
  const LegalTermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xfffafafa),
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left:8.w),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Introduction",style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text("Welcome to Scanly our Medical Lab Test Analysis App, designed to provide insightful analysis of your laboratory test results using advanced machine learning (ML) models. By utilizing our app, you agree to abide by these Terms and Conditions. Please read them carefully before using the app.",style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
              Text("Acceptance of Terms",style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text("By accessing or using our app, you confirm that you agree to these terms and understand them. If you do not agree with them, you should not use our app.",style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
              Text("Description of Service",style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text("Scanly offers users the capability to input their medical lab test results, which are then analyzed by our proprietary machine learning algorithms to provide insightful interpretations. These interpretations are designed to supplement, not replace, professional medical advice.",style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
              Text("Medical Disclaimer",style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text("• Not a Medical Service: Our app does not provide medical services, diagnoses, treatments, or engage in any conduct that requires a professional license.\n• Supplementary Tool: The insights provided by our app serve as a supplementary tool for your understanding and are not intended as a sole basis for any diagnostics or treatment decisions.\n• Consult Health Professionals: Always seek the advice of your doctor or other qualified health provider with any questions you may have regarding a medical condition. Do not disregard professional medical advice or delay in seeking it because of something you have read on or accessed through our App.\n• No Liability for Accuracy: While we strive to use commercially acceptable means to ensure the accuracy of our machine learning models, we cannot guarantee that the provided information is accurate, complete, or applicable to your individual circumstances.",style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
              Text("User Responsibilities",style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text("• Input Accuracy: You are responsible for ensuring that the information you input into the app is accurate and complete.\n• Use Compliance: You agree to use the app only for its intended purposes and not engage in any misuse of the app or its content.",style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
              Text("Intellectual Property Rights",style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text("The content, features, and functionality of the app are and will remain the exclusive property of Scanly and its licensors. Our intellectual property may not be used in connection with any product or service without the prior written consent of Scanly.",style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),Text("Limitation of Liability",style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text("In no event will [Your Company Name], its directors, employees, partners, agents, or affiliates be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from:\n• Your access to or use of or inability to access or use the app.\n• Any conduct or content of any third party on the service.\n• Unauthorized access, use, or alteration of your transmissions or content.",style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),Text("Jurisdiction",style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text("These Terms shall be governed and construed in accordance with the laws of Egypt, without regard to its conflict of law provisions.",style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
              Text("Changes to Terms",style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text("We reserve the right, at our sole discretion, to modify or replace these terms at any time. If a revision is material, we will provide at least 30 days' notice prior to any new terms taking effect.",style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
