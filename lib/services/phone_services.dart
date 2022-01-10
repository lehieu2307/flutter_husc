import 'dart:convert';

import 'package:final_exam/models/phone.dart';
import 'package:final_exam/services/file_services.dart';
import 'package:flutter/services.dart';

//ghi các thông tin của student trong file students.json
class PhoneServices extends FileServices {
  final String fileName = 'phone.json';

  ///lấy data student từ file [phone.json]
  ///trả về default data từ assets nếu không có dữ liệu từ file
  Future<List<Phone>> getListPhone() async {
    try {
      String data = await readData(fileName);
      List jsonData = json.decode(data);
      return jsonData.map<Phone>((e) => Phone.fromJson(e)).toList();
    } catch (error) {
      String studentData =
          await rootBundle.loadString('assets/json/phone_data.json');
      await writeData(fileName, studentData);
      List jsonData = json.decode(studentData);
      return jsonData.map<Phone>((e) => Phone.fromJson(e)).toList();
    }
  }

  Future<bool> addPhone(Phone phone) async {
    List<Phone> listUser = await getListPhone();
    int index = listUser
        .indexWhere((element) => element.Name == phone.Name);
    listUser.insert(0, phone);
    List<Map<String, dynamic>> list = [];
    listUser.forEach((element) {
      list.add(element.toJson());
    });
    await writeData(fileName, list);
    return true;
  }

  Future<bool> deletePhone(Phone phone) async {
    List<Phone> listUser = await getListPhone();
    int index = listUser
        .indexWhere((element) => element.Name == phone.Name);
    listUser.removeAt(index);
    List<Map<String, dynamic>> list = [];
    listUser.forEach((element) {
      list.add(element.toJson());
    });
    await writeData(fileName, list);
    return true;
  }

  Future<bool> editPhone(Phone phone) async {
    List<Phone> listUser = await getListPhone();
    int index = listUser
        .indexWhere((element) => element.Name == phone.Name);
    listUser[index] = phone;
    List<Map<String, dynamic>> list = [];
    listUser.forEach((element) {
      list.add(element.toJson());
    });
    await writeData(fileName, list);
    return true;
  }
}
