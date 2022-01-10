import 'package:final_exam/bloc/add_phone_bloc.dart';
import 'package:final_exam/bloc/home_bloc.dart';
import 'package:final_exam/utils/app_color.dart';
import 'package:final_exam/utils/app_dialog.dart';
import 'package:final_exam/utils/app_text_style.dart';
import 'package:final_exam/utils/string_util.dart';
import 'package:final_exam/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class AddPhoneScreen extends StatefulWidget {
  const AddPhoneScreen({Key? key}) : super(key: key);

  @override
  _AddPhoneScreenState createState() => _AddPhoneScreenState();
}

class _AddPhoneScreenState extends State<AddPhoneScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _manufacturerController = TextEditingController();
  TextEditingController _cpuController = TextEditingController();
  TextEditingController _screenController = TextEditingController();
  TextEditingController _ramController = TextEditingController();
  TextEditingController _InternalMemoryController = TextEditingController();

  FocusNode _nameNode = FocusNode();
  FocusNode _priceNode = FocusNode();
  FocusNode _manufacturerNode = FocusNode();
  FocusNode _cpuNode = FocusNode();
  FocusNode _screenNode = FocusNode();
  FocusNode _ramNode = FocusNode();
  FocusNode _InternalMemoryNode = FocusNode();
  late AddPhoneBloC _addPhoneBloC;

  @override
  void initState() {
    _addPhoneBloC = AddPhoneBloC.getInstance();
    _addPhoneBloC.clearData();
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

    _nameNode.dispose();
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
                    child: 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                            textField(
                              context,
                              controller: _nameController,
                              focusNode: _nameNode,
                              labelText: 'Tên sản phẩm',
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              maxLength: 60,
                              onChanged: (value) =>
                                  _addPhoneBloC.Name = value,
                              onSubmitted: (value) {
                                _priceNode.requestFocus();
                              },
                            ),
                            SizedBox(height: 18.0),
                            textField(
                              context,
                              controller: _priceController,
                              focusNode: _priceNode,
                              keyboardType: TextInputType.number,
                              labelText: 'Giá',
                              maxLength: 10,
                              onChanged: (value) => _addPhoneBloC.Price = value,
                              onSubmitted: (value) {
                                _manufacturerNode.requestFocus();
                              },
                            ),
                            SizedBox(height: 18.0),
                            textField(
                              context,
                              controller: _manufacturerController,
                              focusNode: _manufacturerNode,
                              labelText: 'hãng sản xuất',
                              textCapitalization: TextCapitalization.words,
                              maxLength: 50,
                              onChanged: (value) => _addPhoneBloC.Manufacturer = value,
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
                              textCapitalization: TextCapitalization.words,
                              maxLength: 50,
                              onChanged: (value) => _addPhoneBloC.Cpu = value,
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
                              textCapitalization: TextCapitalization.words,
                              maxLength: 50,
                              onChanged: (value) => _addPhoneBloC.Screen = value,
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
                              textCapitalization: TextCapitalization.words,
                              maxLength: 50,
                              onChanged: (value) => _addPhoneBloC.Ram = value,
                              onSubmitted: (value) {
                                _InternalMemoryNode.requestFocus();
                              },
                            ),
                            SizedBox(height: 18.0),
                            textField(
                              context,
                              controller: _InternalMemoryController,
                              focusNode: _InternalMemoryNode,
                              labelText: 'Bộ nhớ trong',
                              keyboardType: TextInputType.text,
                              onChanged: (value) =>
                                  _addPhoneBloC.InternalMemory = value,
                              onSubmitted: (value) {},
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
        'Thêm Điện Thoại',
        style: AppTextStyle.mediumBlack1A.copyWith(fontSize: 18),
      ),
      centerTitle: true,
    );
  }

  Widget _saveButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: AppColor.colorWhite,
      child: StreamBuilder<bool>(
          stream: _addPhoneBloC.saveButtonState,
          builder: (_, snapshot) {
            bool isEnable = snapshot.data ?? false;
            return MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              disabledColor: AppColor.colorGrey97,
              minWidth: double.infinity,
              height: 54,
              color: AppColor.colorDarkBlue,
              onPressed: isEnable ? addPhone : null,
              child: Text(
                'Thêm',
                style: TextStyle(
                  color: AppColor.colorWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              padding: EdgeInsets.all(0),
            );
          }),
    );
  }

  Widget _loadingState(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _addPhoneBloC.loadingState,
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

  void addPhone() {
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
    _addPhoneBloC.addPhone().then((sucess) {
      HomeBloC.getInstance().getListPhone();
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return succesfulMessageDialog(context, content: 'Thêm Điện thoại');
        },
      ).then((_) {
        Navigator.pop(context);
      });
    }).catchError((error) {
      _addPhoneBloC.hideLoading();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(StringUtil.stringFromException(error))));
    });
  }
}
