import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/homepage.dart';
import 'package:untitled2/core/database/sql.dart';
import 'package:untitled2/core/style/appstyle.dart';
import 'package:untitled2/core/sizeconfig/sizeconig.dart';

import '../shared/widget/custom_app_bar.dart';
import '../shared/widget/custom_input_field.dart';

class Updated extends StatefulWidget {
  const Updated({super.key, required this.id, required this.color});
  final int id; // معرف الملاحظة
  final Color color; // لون الكارت المختار

  @override
  State<Updated> createState() => _UpdatedState(); // [cite: 3]
}

class _UpdatedState extends State<Updated> {
  final TextEditingController title = TextEditingController(); // [cite: 3]
  final TextEditingController content = TextEditingController(); // [cite: 4]
  final Sql sql = Sql(); // [cite: 4]
  String date = ''; // [cite: 4]

  // جلب البيانات من القاعدة بناءً على الـ ID [cite: 5]
  Future<void> readD() async {
    List<Map> response = await sql
        .readData("SELECT * FROM NOTES WHERE ID = '${widget.id}'"); // [cite: 5]
    if (response.isNotEmpty) {
      setState(() {
        title.text = response[0]['NOTES_TILTTLES']; //
        content.text = response[0]['NOTES_CONTENT']; //
        date = response[0]['data']; //
      });
    }
  }

  @override
  void initState() {
    super.initState();
    readD(); // [cite: 7]
  }

  @override
  Widget build(BuildContext context) {
    Sizeconig().init(context); // تفعيل كلاس الأبعاد

    return GestureDetector(
      onTap: () =>
          FocusScope.of(context).unfocus(), // إغلاق الكيبورد عند الضغط خارجاً
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF9F6), // نفس لون الخلفية الموحد
        floatingActionButton: Container(
          height: Sizeconig.defaultsize! * 6.5,
          width: Sizeconig.defaultsize! * 6.5,
          decoration: BoxDecoration(
            color: const Color(0xFF191B28), // الكحلي الغامق
            borderRadius: BorderRadius.circular(22),
          ),
          child: IconButton(
            onPressed: () async {
              // التحقق من أن الحقول ليست فارغة [cite: 8]
              if (title.text.isEmpty || content.text.isEmpty) {
                Get.snackbar(
                    'Error', 'Title and content cannot be empty.'); // [cite: 8]
                return; // [cite: 9]
              }

              // تحديث البيانات في القاعدة [cite: 9]
              int response = await sql.updateData('''
                UPDATE NOTES
                SET NOTES_TILTTLES = '${title.text}', NOTES_CONTENT = '${content.text}' 
                WHERE ID = "${widget.id}"'''); // [cite: 9]

              if (response > 0) {
                Get.snackbar(
                    'Success', 'Note Updated successfully.'); // [cite: 10]
                Get.offAll(
                    () => const Homepage()); // الرجوع للرئيسية [cite: 10]
              } else {
                Get.snackbar('Error', 'Failed to Update note.'); // [cite: 10]
              }
            },
            icon: const Icon(Icons.file_upload_outlined,
                color: Colors.white, size: 30),
          ),
        ),
        body: Column(
          children: [
            const CustomNoteAppBar(
                title: 'Edit Note'), // استخدام الـ Widget الموحد مع اسم مختلف
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(Sizeconig.defaultsize! * 2.4),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, //
                    children: [
                      // عرض التاريخ المخزن [cite: 13]
                      Text(date, style: Appstyle.datetittle),
                      SizedBox(height: Sizeconig.defaultsize! * 2),

                      // حقل العنوان [cite: 12]
                      CustomNoteField(
                        controller: title,
                        hint: 'Title',
                        style: Appstyle.maintittle
                            .copyWith(fontSize: 32, color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      SizedBox(
                          height: Sizeconig.defaultsize! * 1.8), // [cite: 14]

                      // حقل المحتوى [cite: 14]
                      CustomNoteField(
                        controller: content,
                        hint: 'Start typing...',
                        style: Appstyle.maincontent.copyWith(fontSize: 18),
                        maxLines: null, // [cite: 14]
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
