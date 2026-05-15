import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/feature/widget/data_card.dart';
import 'package:untitled2/core/getcontroller/controllor.dart';

import 'feature/widget/cusstom_floating_btn.dart';
import 'feature/widget/custom_search_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

// داخل ملف الـ Homepage
class _HomepageState extends State<Homepage> {
  // بننادي الكنترولر مرة واحدة [cite: 3]
  final ReadD control = Get.put(ReadD());

  @override
  void initState() {
    control.readD(); // قراءة البيانات عند التشغيل [cite: 4]
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // السطر ده وظيفته يسحب الـ Focus من أي حاجة (يقفل الكيبورد)
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomSearchAppBar(
          onSearch: (value) => control.filterNotes(value),
        ),
        floatingActionButton: const CustomFloatingButton(),
        // باستخدام الـ NotificationListener بنقدر نحس بالـ Scroll ونقفل الكيبورد برضه
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
              FocusScope.of(context)
                  .unfocus(); // يقفل الكيبورد أول ما تبدأ تعمل Scroll
            }
            return false;
          },
          child: GetBuilder<ReadD>(
            builder: (val) {
              if (val.filteredData.isEmpty) {
                return const Center(child: Text("No notes found"));
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: val.filteredData.length,
                itemBuilder: (context, index) {
                  var dataItem = val.filteredData[index];
                  return Datacard(
                    title: dataItem['NOTES_TILTTLES'],
                    content: dataItem['NOTES_CONTENT'],
                    data: dataItem['data'],
                    id: dataItem['ID'],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
