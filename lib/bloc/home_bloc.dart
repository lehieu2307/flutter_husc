import 'dart:async';

import 'package:final_exam/bloc/base_bloc.dart';
import 'package:final_exam/models/phone.dart';
import 'package:final_exam/services/phone_services.dart';

class HomeBloC extends BaseBloC {
  static final HomeBloC _instance = HomeBloC._();
  HomeBloC._() {
    _phoneServices = PhoneServices();
  }

  static HomeBloC getInstance() {
    return _instance;
  }

  late PhoneServices _phoneServices;

  StreamController<List<Phone>> _listPhoneController =
      StreamController<List<Phone>>.broadcast();

  Stream<List<Phone>> get listPhoneStream => _listPhoneController.stream;

  Future<List<Phone>> getListPhone() async {
    List<Phone> list = await _phoneServices.getListPhone();
    _listPhoneController.sink.add(list);
    return list;
  }

  Future<bool> deletePhone(Phone phone) async {
    bool deleteSuccess = await _phoneServices.deletePhone(phone);
    await getListPhone();
    return deleteSuccess;
  }

  @override
  void clearData() {}

  @override
  void dispose() {
    _listPhoneController.close();
    super.dispose();
  }
}
