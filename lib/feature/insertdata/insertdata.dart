import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled2/core/sizeconfig/sizeconig.dart'; // استيراد كلاس الأبعاد الخاص بك
import 'package:untitled2/core/database/sql.dart'; // [cite: 1]
import 'package:untitled2/core/style/appstyle.dart'; // [cite: 1]
import '../../core/getcontroller/controllor.dart';
import '../shared/widget/custom_app_bar.dart';
import '../shared/widget/custom_input_field.dart';

class Insertdata extends StatefulWidget {
  const Insertdata({super.key});
  @override
  State<Insertdata> createState() => _InsertdataState(); // [cite: 2]
}

class _InsertdataState extends State<Insertdata> {
  final TextEditingController title = TextEditingController(); // [cite: 2]
  final TextEditingController content = TextEditingController(); // [cite: 3]
  final Sql sql = Sql(); // [cite: 3]

  String getFormattedDateTime() {
    DateTime now = DateTime.now(); // [cite: 3]
    String formattedDate =
        DateFormat('MMM dd, yyyy').format(now).toUpperCase(); // [cite: 4]
    String formattedTime = DateFormat('hh:mm a').format(now); // [cite: 5]
    return '$formattedDate • $formattedTime'; // [cite: 6]
  }

  @override
  Widget build(BuildContext context) {
    // تفعيل كلاس الأبعاد
    Sizeconig().init(context);
    double spacing = Sizeconig.defaultsize! * 2; // استخدام الأبعاد المخصصة
    final ReadD control = Get.find();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // [cite: 8]
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF9F6), // [cite: 8]
        floatingActionButton: Container(
          height: Sizeconig.defaultsize! * 6.5, // متجاوب مع حجم الشاشة
          width: Sizeconig.defaultsize! * 6.5,
          decoration: BoxDecoration(
            color: const Color(0xFF191B28), // [cite: 9]
            borderRadius: BorderRadius.circular(22), // [cite: 9]
          ),
          child: IconButton(
            onPressed: () async {
              if (title.text.isEmpty || content.text.isEmpty) {
                Get.snackbar('Warning', 'Please fill all fields');
                return;
              }

              // 2. استدعاء الـ Logic من الكنترولر [cite: 11]
              control.addNote(
                title: title.text,
                content: content.text,
                date: getFormattedDateTime(), // التاريخ اللي حسبناه
              );
              Get.back(); // [cite: 11]
            },
            icon: const Icon(Icons.file_upload_outlined,
                color: Colors.white, size: 30),
          ),
        ),
        body: Column(
          children: [
            const CustomNoteAppBar(
                title: 'Add Note'), // استدعاء الـ Widget المنفصل
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(
                    Sizeconig.defaultsize! * 2.4), // Padding متجاوب
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // [cite: 20]
                    children: [
                      Text(getFormattedDateTime(),
                          style: Appstyle.datetittle), // [cite: 20, 21]
                      SizedBox(height: spacing),
                      CustomNoteField(
                        controller: title,
                        hint: 'Title',
                        style: Appstyle.maintittle
                            .copyWith(fontSize: 32, color: Colors.black26),
                      ),
                      SizedBox(height: spacing / 2),
                      CustomNoteField(
                        controller: content,
                        hint: 'Start typing your thoughts...',
                        style: Appstyle.maincontent.copyWith(fontSize: 18),
                        maxLines: null,
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
