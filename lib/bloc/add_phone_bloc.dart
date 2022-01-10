import 'dart:async';

import 'package:final_exam/bloc/base_bloc.dart';
import 'package:final_exam/models/phone.dart';
import 'package:final_exam/services/phone_services.dart';

class AddPhoneBloC extends BaseBloC {
  static final AddPhoneBloC _instance = AddPhoneBloC._();
  AddPhoneBloC._() {
    _phoneServices = PhoneServices();
  }

  static AddPhoneBloC getInstance() {
    return _instance;
  }

  late PhoneServices _phoneServices;
  late Phone _phone;

  StreamController<bool> _saveButtonController =
      StreamController<bool>.broadcast();

  Stream<bool> get saveButtonState => _saveButtonController.stream;


  set Name(String value) {
    _phone.Name = value.trim();
    _saveButtonController.sink.add(_phone.isFullInformation());
  }

  set Price(String value) {
    _phone.Price = value.trim();
    _saveButtonController.sink.add(_phone.isFullInformation());
  }

  set Manufacturer(String value) {
    _phone.Manufacturer = value.trim();
    _saveButtonController.sink.add(_phone.isFullInformation());
  }

  set Cpu(String value) {
    _phone.Cpu = value.trim();
    _saveButtonController.sink.add(_phone.isFullInformation());
  }

  set Screen(String value) {
    _phone.Screen = value.trim();
    _saveButtonController.sink.add(_phone.isFullInformation());
  }

  set Ram(String value) {
    _phone.Ram = value.trim();
    _saveButtonController.sink.add(_phone.isFullInformation());
  }

  
  set InternalMemory(String value) {
    _phone.InternalMemory = value.trim();
    _saveButtonController.sink.add(_phone.isFullInformation());
  }

  Future<bool> addPhone() async {
    showLoading();
    bool result = await _phoneServices.addPhone(_phone);
    hideLoading();
    return result;
  }

  @override
  void clearData() {
    hideLoading();
    _saveButtonController.sink.add(false);
    _phone = Phone();
  }

  @override
  void dispose() {
    _saveButtonController.close();
    super.dispose();
  }
}
