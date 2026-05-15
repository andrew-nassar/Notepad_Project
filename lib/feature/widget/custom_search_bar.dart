import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/core/style/appstyle.dart';

import '../../core/getcontroller/controllor.dart';

class CustomSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onSearch; // وظيفة الفلترة

  const CustomSearchAppBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final ReadD control = Get.find();
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF9D59B), // لون الـ Peach اللي في الصورة
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Notes',
                    style: Appstyle.til.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF191B28),
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(height: 10),
              // حقل البحث الفعلي للفلترة
              TextField(
                controller: control.searchController, // ربط الـ Controller
                onChanged: onSearch,
                decoration: InputDecoration(
                  hintText: 'Search by title...',
                  prefixIcon: const Icon(Icons.search_off_rounded, size: 20),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(160); // طول الـ AppBar المخصص
}