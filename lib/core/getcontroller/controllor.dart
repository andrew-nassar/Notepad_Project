import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/core/database/sql.dart';

class Searchcontroller extends GetxController {
    RxBool isSearching = false.obs ; 
    //RxString searchQuery = ''.obs;
    //ReadD readD = Get.find();
    void search() {
      isSearching.value = ! isSearching.value ;
    }
    RxString searchQuery ="".obs;
    void setValue(String value) {
      searchQuery.value = value;
    }
    RxList <Map> data = <Map>[].obs;
    RxList <Map> filterdata = <Map>[].obs;
    void fetchData() {
      filterdata.value = data.where((item) => item['NOTES_TILTTLES'].toString()
      .toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
      
    }
}
class ReadD extends GetxController {
  Sql sql = Sql();
  
  List<Map> allData = []; // المخزن الرئيسي للداتا
  List<Map> filteredData = []; // الداتا اللي بتظهر في الشاشة (بعد الفلترة)
  final TextEditingController searchController = TextEditingController();
  // دالة قراءة البيانات من القاعدة
  Future<void> readD() async {
    List<Map> response = await sql.readData("SELECT * FROM NOTES");
    allData = response;
    filteredData = response; // في البداية بنعرض كل الداتا
    update(); // تحديث الـ UI
  }

  @override
  void onClose() {
    // دي أهم خطوة: أول ما تخرج من الشاشة، الـ Controller ده بيتمسح فوراً
    searchController.dispose(); 
    super.onClose();
  }

  void filterNotes(String query) {
    filteredData = allData.where((note) {
      return note['NOTES_TILTTLES'].toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
    update();
  }
  Future<void> addNote({required String title, required String content, required String date}) async {
    // تنفيذ عملية الإدخال [cite: 11]
    int response = await sql.insertData(
      "INSERT INTO NOTES (`NOTES_TILTTLES`, `NOTES_CONTENT`, `data`) VALUES ('$title', '$content','$date')",
    );

    if (response > 0) {
      // ريفريش للداتا عشان الملاحظة الجديدة تظهر فوراً في الصفحة الرئيسية
      await readD(); 
      Get.back(); // الرجوع للشاشة السابقة بعد النجاح [cite: 11]
      Get.snackbar('Success', 'Note added successfully');
    } else {
      Get.snackbar('Error', 'Failed to save note');
    }
  }
}
