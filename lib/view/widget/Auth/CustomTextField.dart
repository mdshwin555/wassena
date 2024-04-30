import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../core/constant/color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;

  final TextInputType keyboardType;
  final TextEditingController textfieldcontroller;
  final String? Function(String?) valid;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.textfieldcontroller,
    this.keyboardType = TextInputType.text,
    required this.valid,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16.h,
      width: 100.w,
      child: Padding(
        padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: TextStyle(
                color: Colors.black,
                height: 0.2.h,
                fontSize: 13.sp,
                fontFamily: 'ElMessiri',
                letterSpacing: 1,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            TextFormField(
              validator: valid,
              controller: textfieldcontroller,
              keyboardType: keyboardType,
              maxLength: 10,
              cursorColor: AppColor.secondaryColor,
              style: TextStyle( // Define the TextStyle for the entered text
                fontFamily: 'ElMessiri',
                fontSize: 11.sp,
                color: Colors.black, // Customize color as needed
                // Add other style properties as needed
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: AppColor.grey),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: AppColor.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: AppColor.primaryColor),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: AppColor.red),
                ),
                errorStyle: TextStyle(
                  fontFamily: 'ElMessiri',
                    fontSize: 8.sp
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  height: 0.2.h,
                  fontSize: 11.sp,
                  fontFamily: 'ElMessiri',
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
