import 'package:final_exam/bloc/home_bloc.dart';
import 'package:final_exam/models/list_model.dart';
import 'package:final_exam/models/phone.dart';
import 'package:final_exam/models/user.dart';
import 'package:final_exam/ui/auth/login_screen.dart';
import 'package:final_exam/ui/home/add_phone_screen.dart';
import 'package:final_exam/ui/home/phone_item.dart';
import 'package:final_exam/utils/app_color.dart';
import 'package:final_exam/utils/app_dialog.dart';
import 'package:final_exam/utils/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  HomeBloC _homeBloC = HomeBloC.getInstance();
  late ListModel<Phone> _list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: AppColor.colorGreyF5F5F7,
      body: FutureBuilder<List<Phone>>(
          future: _homeBloC.getListPhone(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Đã có lỗi xảy ra.'),
              );
            }
            return StreamBuilder<List<Phone>>(
                stream: _homeBloC.listPhoneStream,
                initialData: snapshot.data,
                builder: (__, listSnapshot) {
                  if (listSnapshot.data!.isEmpty) {
                    return Center(
                      child: Text('Danh sách điện thoại rỗng.'),
                    );
                  }
                  _list = ListModel<Phone>(
                    listKey: _listKey,
                    initialItems: listSnapshot.data!,
                    removedItemBuilder: (context, item, animation) =>
                        PhoneItem(
                      phone: item,
                      animation: animation,
                    ),
                  );
                  return AnimatedList(
                    key: _listKey,
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 60.0),
                    initialItemCount: listSnapshot.data!.length,
                    itemBuilder: (context, index, animation) {
                      return PhoneItem(
                        key: Key('student ${_list[index].Name}'),
                        phone: _list[index],
                        animation: animation,
                        onRemoved: () {
                          _list.removeAt(index);
                        },
                      );
                    },
                  );
                });
          }),
      floatingActionButton: _addPhoneButton(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.colorGreyF5F5F7,
      title: Text(
        'Quản lý cửa hàng điện thoại',
        style: AppTextStyle.mediumBlack1A.copyWith(fontSize: 18),
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () => logout(context),
          child: Text('Đăng xuất'),
        ),
      ],
    );
  }

  Widget _addPhoneButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddPhoneScreen()));
      },
      backgroundColor: AppColor.colorDarkBlue,
      child: Icon(
        Icons.add,
        color: AppColor.colorWhite,
      ),
    );
  }

  void logout(BuildContext context) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return confirmDialog(
            context, 'Đăng xuất', 'Bạn chắc chắn muốn đăng xuất?');
      },
    ).then((acceptLogout) {
      if (acceptLogout ?? false) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
      }
    });
  }
}
