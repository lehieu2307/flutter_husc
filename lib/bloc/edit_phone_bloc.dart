import 'dart:async';

import 'package:final_exam/bloc/base_bloc.dart';
import 'package:final_exam/models/phone.dart';
import 'package:final_exam/services/phone_services.dart';

class EditPhoneBloC extends BaseBloC {
  static final EditPhoneBloC _instance = EditPhoneBloC._();
  EditPhoneBloC._() {
     _phoneServices = PhoneServices();
  }

  static EditPhoneBloC getInstance() {
    return _instance;
  }

  late PhoneServices _phoneServices;
  late Phone _phone;

  set phone(Phone value) {
    _phone = value;

  }

    set Name(String Name) {
    _phone.Name = Name;
  }

  set Price(String Price) {
    _phone.Price = Price;
  }
  set Manufacturer(String Manufacturer) {
    _phone.Manufacturer = Manufacturer;
  }
  set Cpu(String Cpu) {
    _phone.Cpu = Cpu;
  }
  set Screen(String Screen) {
    _phone.Screen = Screen;
  }
  set Ram(String Ram) {
    _phone.Name = Ram;
  }
  set InternalMemory(String InternalMemory) {
    _phone.InternalMemory = InternalMemory;
  }


  Future<bool> updatePhone() async {
    showLoading();
    bool result = await _phoneServices.editPhone(_phone);
    hideLoading();
    return result;
  }

  @override
  void clearData() {
    hideLoading();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
