import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../insertdata/insertdata.dart'; // تأكد من المسار الصح لصفحة الإضافة

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.0,
      width: 64.0,
      decoration: BoxDecoration(
        color: const Color(0xFF191B28), // الكحلي الغامق
        borderRadius: BorderRadius.circular(22.0), // تدوير الزوايا (Squircle)
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: RawMaterialButton(
        onPressed: () {
          Get.to(() => const Insertdata(), transition: Transition.rightToLeftWithFade);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
        elevation: 0,
        child: const Icon(
          Icons.edit_note_outlined, // أيقونة القلم والمربع
          color: Color(0xFFDCC28D), // اللون الذهبي الهادي
          size: 35.0,
        ),
      ),
    );
  }
}