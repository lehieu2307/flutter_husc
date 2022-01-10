import 'package:final_exam/bloc/edit_phone_bloc.dart';
import 'package:final_exam/bloc/home_bloc.dart';
import 'package:final_exam/models/phone.dart';
import 'package:final_exam/utils/app_color.dart';
import 'package:final_exam/utils/app_dialog.dart';
import 'package:final_exam/utils/app_text_style.dart';
import 'package:final_exam/utils/string_util.dart';
import 'package:final_exam/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class EditPhoneScreen extends StatefulWidget {
  final Phone phone;
  const EditPhoneScreen({Key? key, required this.phone}) : super(key: key);

  @override
  _EditPhoneScreenState createState() => _EditPhoneScreenState();
}

class _EditPhoneScreenState extends State<EditPhoneScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _manufacturerController = TextEditingController();
  TextEditingController _cpuController = TextEditingController();
  TextEditingController _screenController = TextEditingController();
  TextEditingController _ramController = TextEditingController();
  TextEditingController _InternalMemoryController = TextEditingController();


  FocusNode _priceNode = FocusNode();
  FocusNode _manufacturerNode = FocusNode();
  FocusNode _cpuNode = FocusNode();
  FocusNode _screenNode = FocusNode();
  FocusNode _ramNode = FocusNode();
  FocusNode _InternalMemoryNode = FocusNode();
  EditPhoneBloC _editBloC = EditPhoneBloC.getInstance();
  late Phone phone;

  @override
  void initState() {
    _editBloC.clearData();
    _editBloC.phone = widget.phone;
    phone = widget.phone;
    _nameController.text = '${phone.Name}';
    _priceController.text = '${phone.Price}';
    _manufacturerController.text = '${phone.Manufacturer}';
    _cpuController.text = '${phone.Cpu}';
    _screenController.text = '${phone.Screen}';
    _ramController.text = '${phone.Ram}';
    _InternalMemoryController.text = '${phone.InternalMemory}';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _manufacturerController.dispose();
    _cpuController.dispose();
    _screenController.dispose();
    _ramController.dispose();
    _InternalMemoryController.dispose();

    _priceNode.dispose();
    _manufacturerNode.dispose();
    _cpuNode.dispose();
    _screenNode.dispose();
    _ramNode.dispose();
    _InternalMemoryNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Stack(
        children: [
          Scaffold(
            appBar: _buildAppBar(context),
            backgroundColor: Theme.of(context).backgroundColor,
            resizeToAvoidBottomInset: true,
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        textField(
                          context,
                          controller: _nameController,
                          labelText: 'Tên sản phẩm',
                          keyboardType: TextInputType.text,
                          onChanged: (value) => _editBloC.Name =value,
                          onSubmitted: (value) {
                            _priceNode.requestFocus();
                          },
                        ),
                        SizedBox(height: 18.0),
                        textField(
                          context,
                          controller: _priceController,
                          focusNode: _priceNode,
                          labelText: 'giá',
                          keyboardType: TextInputType.text,
                          onChanged: (value) => _editBloC.Price =
                              value,
                          onSubmitted: (value) {
                            _manufacturerNode.requestFocus();
                          },
                        ),
                        SizedBox(height: 18.0),
                        textField(
                          context,
                          controller: _manufacturerController,
                          focusNode: _manufacturerNode,
                          labelText: 'Nhà sản xuất',
                          keyboardType: TextInputType.text,
                          onChanged: (value) => _editBloC.Manufacturer =
                              value,
                          onSubmitted: (value) {
                            _cpuNode.requestFocus();
                          },
                        ),
                        SizedBox(height: 18.0),
                        textField(
                          context,
                          controller: _cpuController,
                          focusNode: _cpuNode,
                          labelText: 'CPU',
                          keyboardType: TextInputType.text,
                          onChanged: (value) => _editBloC.Cpu =
                              value,
                          onSubmitted: (value) {
                            _screenNode.requestFocus();
                          },
                        ),
                        SizedBox(height: 18.0),
                        textField(
                          context,
                          controller: _screenController,
                          focusNode: _screenNode,
                          labelText: 'Độ rộng màn hình',
                          keyboardType: TextInputType.text,
                          onChanged: (value) => _editBloC.Screen =
                              value,
                          onSubmitted: (value) {
                            _ramNode.requestFocus();
                          },
                        ),
                        SizedBox(height: 18.0),
                        textField(
                          context,
                          controller: _ramController,
                          focusNode: _ramNode,
                          labelText: 'Ram',
                          keyboardType: TextInputType.text,
                          onChanged: (value) => _editBloC.Ram =
                              value,
                          onSubmitted: (value) {
                            _InternalMemoryNode.requestFocus();
                          },
                        ),
                        SizedBox(height: 18.0),textField(
                          context,
                          controller: _InternalMemoryController,
                          focusNode: _InternalMemoryNode,
                          labelText: 'Bộ nhớ trong',
                          keyboardType: TextInputType.text,
                          onChanged: (value) => _editBloC.InternalMemory =
                              value,
                          onSubmitted: (value) {
                          },
                        ),
                        SizedBox(height: 18.0),
                        
                      ],
                    ),
                  ),
                ),
                _saveButton(context),
              ],
            ),
          ),
          _loadingState(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      leading: BackButton(),
      title: Text(
        'Thông tin điện thoại',
        style: AppTextStyle.mediumBlack1A.copyWith(fontSize: 18),
      ),
      centerTitle: true,
    );
  }

  Widget _saveButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: AppColor.colorWhite,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        disabledColor: AppColor.colorGrey97,
        minWidth: double.infinity,
        height: 54,
        color: AppColor.colorDarkBlue,
        onPressed: updatePhone,
        child: Text(
          'Cập nhật',
          style: TextStyle(
            color: AppColor.colorWhite,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        padding: EdgeInsets.all(0),
      ),
    );
  }

  Widget _loadingState(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _editBloC.loadingState,
        builder: (_, snapshot) {
          bool isLoading = snapshot.data ?? false;
          if (isLoading) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: AppColor.colorGrey97.withOpacity(0.5),
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox.shrink();
        });
  }

  void updatePhone() {
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
    _editBloC.updatePhone().then((success) {
      HomeBloC.getInstance().getListPhone();
      showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return succesfulMessageDialog(context, content: 'Cập nhật');
        },
      ).then((value) => Navigator.pop(context));
    }).catchError((error) {
      _editBloC.hideLoading();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(StringUtil.stringFromException(error))));
    });
  }
}
