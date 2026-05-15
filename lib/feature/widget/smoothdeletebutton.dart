import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/homepage.dart';

class SmoothDeleteButton extends StatelessWidget {
  final int id;
  final Function deleteNoteCallback;

  const SmoothDeleteButton({
    super.key,
    required this.id,
    required this.deleteNoteCallback,
  });

  @override
  Widget build(BuildContext context) {
    // شيلنا الـ Positioned من هنا عشان الـ Widget يبقى مرن ونقدر نحطه في أي Row أو Stack براحتنا
    return InkWell(
      onTap: () => _showDeleteDialog(context),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.delete_outline_rounded, // شكل الأيقونة الأرق والأنسب للصورة
          color: Colors.red[200], // لون هادي مش فاقع عشان يماشي التصميم
          size: 24,
        ),
      ),
    );
  }

  // فصلنا الـ Logic بتاع الدايلوج في Function لوحدها عشان الكود يبقى نضيف
  void _showDeleteDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: 'Warning',
      desc: 'Are you sure you want to delete this note?',
      btnCancelOnPress: () {},
      btnOkColor: Colors.redAccent,
      btnCancelColor: Colors.green,
      btnOkOnPress: () async {
        int response = await deleteNoteCallback(id);
        if (response > 0) {
          _showSnackbar('Success', 'Note deleted successfully.', Colors.green);
          Get.offAll(() => const Homepage(), transition: Transition.circularReveal);
        } else {
          _showSnackbar('Error', 'Failed to delete the note.', Colors.red);
        }
      },
    ).show();
  }

  void _showSnackbar(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color.withOpacity(0.8),
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      duration: const Duration(seconds: 2),
    );
  }
}