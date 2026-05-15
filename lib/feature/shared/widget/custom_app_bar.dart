import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/style/appstyle.dart'; // [cite: 1]

class CustomNoteAppBar extends StatelessWidget {
  final String title;
  const CustomNoteAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160, // [cite: 13]
      padding: const EdgeInsets.symmetric(horizontal: 20), // [cite: 13]
      decoration: const BoxDecoration(
        color: Color(0xFFF9D59B), // [cite: 13]
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40), // [cite: 14]
          bottomRight: Radius.circular(40), // [cite: 14]
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // [cite: 15]
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20), // [cite: 15]
              onPressed: () => Get.back(), // [cite: 16]
            ),
            Text(
              title, // [cite: 17]
              style: Appstyle.maintittle.copyWith(
                fontSize: 28, // [cite: 17]
                fontWeight: FontWeight.bold, // [cite: 17]
                color: const Color(0xFF191B28), // [cite: 17]
              ),
            ),
            const SizedBox(width: 48), // [cite: 18]
          ],
        ),
      ),
    );
  }
}