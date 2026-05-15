import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/core/database/sql.dart';
import 'package:untitled2/core/style/appstyle.dart';
import 'package:untitled2/feature/update/updated.dart';
import '../widget/smoothdeletebutton.dart';

class Datacard extends StatefulWidget {
  const Datacard({
    super.key,
    required this.title,
    required this.content,
    required this.data,
    required this.id,
  });

  final String title;
  final String content;
  final String data;
  final int id;

  @override
  State<Datacard> createState() => _DatacardState();
}

class _DatacardState extends State<Datacard> {
  final Sql sql = Sql();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          Get.to(
            () => Updated(id: widget.id, color: Colors.white),
            transition: Transition.fadeIn,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white, // نفس لون الصورة
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // السطر الأول: العنوان وزر الحذف
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: Appstyle.maintittle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2D3142),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // بتضيف الـ ... لوحدها
                    ),
                  ),
                  // زر الحذف في مكانه الصحيح (فوق يمين)
                  SmoothDeleteButton(
                    id: widget.id,
                    deleteNoteCallback: (id) async {
                      return await sql.deleteData('DELETE FROM NOTES WHERE id = $id');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // السطر الثاني: المحتوى
              Text(
                widget.content,
                style: Appstyle.maincontent.copyWith(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.5,
                ),
                maxLines: 3, // عشان ميبقاش طويل بزيادة
                overflow: TextOverflow.ellipsis, // بتضيف الـ ... لوحدها
              ),
              const SizedBox(height: 20),
              // السطر الثالث: التاريخ (Align يمين)
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.data.toUpperCase(),
                  style: Appstyle.datetittle.copyWith(
                    fontSize: 12,
                    letterSpacing: 0.5,
                    color: Colors.black26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}