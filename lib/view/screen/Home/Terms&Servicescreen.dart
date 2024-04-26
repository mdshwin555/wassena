import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constant/color.dart';

class TermsAndService extends StatelessWidget {
  const TermsAndService({super.key});

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              }),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'سياسة الخصوصية ',
            style:  TextStyle(
              color: AppColor.black,
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
        body: Container(
          height: 100.h,
          width: 100.w,
          margin: EdgeInsets.fromLTRB(1.w, 1.h, 5.w, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أهلا بك في تطبيق Order Now :',
                  style:  TextStyle(
                    color: AppColor.black,
                    fontFamily: 'ElMessiri',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h,),
                Text(
                  'هذه هي صفحة سياسة الاستخدام الخاصة بنا، ونرجو منك قراءتها بعناية قبل استخدام تطبيقنا. من خلال استخدام تطبيقنا، فإنك توافق على الشروط والأحكام الواردة في هذه السياسة.',
                  style:  TextStyle(
                    color: AppColor.black,
                    fontFamily: 'ElMessiri',
                    fontSize: 10.sp
                  ),
                ),
                SizedBox(height: 4.h,),
                Text(
                  '1. استخدام التطبيق :',
                  style:  TextStyle(
                      color: AppColor.black,
                      fontFamily: 'ElMessiri',
                      fontSize: 12.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 1.h,),
                Text(
                  '1.1 يجب عليك استخدام تطبيقنا فقط للأغراض القانونية والمسموح بها.',
                  style:  TextStyle(
                      color: AppColor.black,
                      fontFamily: 'ElMessiri',
                      fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 1.h,),
                Text(
                  '1.2 يُمنع استخدام التطبيق بطرق تنتهك حقوق الآخرين أو تعرّضهم للأذى',
                  style:  TextStyle(
                    color: AppColor.black,
                    fontFamily: 'ElMessiri',
                    fontSize: 11.sp,
                  ),
                ),

                SizedBox(height: 4.h,),

                Text(
                  '2. حقوق الملكية الفكرية  :',
                  style:  TextStyle(
                      color: AppColor.black,
                      fontFamily: 'ElMessiri',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 1.h,),
                Text(
                  '2.1 جميع حقوق الملكية الفكرية المتعلقة بتطبيقنا تعود لنا.',
                  style:  TextStyle(
                    color: AppColor.black,
                    fontFamily: 'ElMessiri',
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 1.h,),
                Text(
                 '2.2 يُمنع نسخ أو نقل أو تعديل أو توزيع أو استخدام أي جزء من التطبيق بدون إذن كتابي منا.',
                  style:  TextStyle(
                    color: AppColor.black,
                    fontFamily: 'ElMessiri',
                    fontSize: 11.sp,
                  ),
                ),

                SizedBox(height: 4.h,),

                Text(
                  '3. المحتوى :',
                  style:  TextStyle(
                      color: AppColor.black,
                      fontFamily: 'ElMessiri',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 1.h,),
                Text(
                  '3.1 نحن لا نتحمل مسؤولية المحتوى الذي يتم تحميله أو نشره من قبل المستخدمين.',
                  style:  TextStyle(
                    color: AppColor.black,
                    fontFamily: 'ElMessiri',
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 1.h,),
                Text(
                  '3.2 نحتفظ بالحق في إزالة أي محتوى ينتهك سياساتنا.',
                  style:  TextStyle(
                    color: AppColor.black,
                    fontFamily: 'ElMessiri',
                    fontSize: 11.sp,
                  ),
                ),

                SizedBox(height: 4.h,),

                Text(
                  '4. الخصوصية :',
                  style:  TextStyle(
                      color: AppColor.black,
                      fontFamily: 'ElMessiri',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 1.h,),
                Text(
                  '4.1 نحن نحترم خصوصيتك ونتعامل بجدية مع بيانات المستخدمين. يرجى قراءة سياسة الخصوصية لفهم كيفية جمع واستخدام البيانات.',
                  style:  TextStyle(
                    color: AppColor.black,
                    fontFamily: 'ElMessiri',
                    fontSize: 11.sp,
                  ),
                ),

                SizedBox(height: 4.h,),

                Text(
                  '5. تغييرات في السياسة :',
                  style:  TextStyle(
                      color: AppColor.black,
                      fontFamily: 'ElMessiri',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 1.h,),
                Text(
                  '5.1 نحتفظ بالحق في تعديل هذه السياسة في أي وقت. سيتم نشر أي تغييرات على هذه الصفحة.',
                  style:  TextStyle(
                    color: AppColor.black,
                    fontFamily: 'ElMessiri',
                    fontSize: 11.sp,
                  ),
                ),

                SizedBox(height: 4.h,),

                Text(
                  '6. تواصل معنا :',
                  style:  TextStyle(
                      color: AppColor.black,
                      fontFamily: 'ElMessiri',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 1.h,),
                Text(
                  'لأي استفسارات أو مخاوف بخصوص سياسة الاستخدام، يُرجى التواصل معنا عبر : ',
                  style:  TextStyle(
                    color: AppColor.black,
                    fontFamily: 'ElMessiri',
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 2.h,),
                Text(
                  'رقم الهاتف : 0958768548',
                  style:  TextStyle(
                    color: AppColor.black,
                    fontFamily: 'ElMessiri',
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 1.h,),
                Text(
                  'البريد الإلكتروني : contact@ordernow.com',
                  style:  TextStyle(
                    color: AppColor.black,
                    fontFamily: 'ElMessiri',
                    fontSize: 11.sp,
                  ),
                ),

                SizedBox(height: 7.h,),

                Text(
                  'شكرًا لاستخدام تطبيقنا !',
                  style:  TextStyle(
                      color: AppColor.black,
                      fontFamily: 'ElMessiri',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
