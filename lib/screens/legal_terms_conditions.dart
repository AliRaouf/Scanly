import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../generated/l10n.dart';

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
              Text(S.of(context).Legal_intro,style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text(S.of(context).Legal_intro_words,style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
              Text(S.of(context).Legal_Acceptance,style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text(S.of(context).Legal_Acceptance_words,style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
              Text(S.of(context).Legal_Service,style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text(S.of(context).Legal_Service_words,style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
              Text(S.of(context).Legal_Disclaimer,style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text(S.of(context).Legal_Disclaimer_Words,style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
              Text(S.of(context).Legal_Responsibility,style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text(S.of(context).Legal_Responsibility_words,style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
              Text(S.of(context).Legal_Property,style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text(S.of(context).Legal_Property_words,style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),Text(S.of(context).Legal_Liability,style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text(S.of(context).Legal_Liability_words,style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),Text(S.of(context).Legal_Jury,style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text(S.of(context).Legal_Jury_words,style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
              Text(S.of(context).Legal_Change,style: GoogleFonts.nunito(fontSize:24.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),),
              Padding(
                padding:  EdgeInsets.only(left:8.0),
                child: Text(S.of(context).Legal_Change_words,style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425),fontWeight:FontWeight.w300),),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
