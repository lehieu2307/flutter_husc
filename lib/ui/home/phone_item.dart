import 'package:final_exam/bloc/home_bloc.dart';
import 'package:final_exam/models/phone.dart';
import 'package:final_exam/ui/home/edit_phone_screen.dart';
import 'package:final_exam/utils/app_color.dart';
import 'package:final_exam/utils/app_dialog.dart';
import 'package:final_exam/utils/app_text_style.dart';
import 'package:final_exam/utils/string_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneItem extends StatefulWidget {
  final Animation<double> animation;
  final Phone phone;
  final Function()? onRemoved;
  const PhoneItem(
      {Key? key,
      required this.phone,
      required this.animation,
      this.onRemoved})
      : super(key: key);

  @override
  _PhoneItemState createState() => _PhoneItemState();
}

class _PhoneItemState extends State<PhoneItem> {
  late Phone phone;
  @override
  void initState() {
    phone = widget.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      axis: Axis.vertical,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Color(0xff141A1A1A),
              blurRadius: 32,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    '''${phone.Name}''',
                    style: AppTextStyle.mediumBlack1A.copyWith(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ),
                _buildButton(context, 'Sửa', editPhone,
                    color: AppColor.colorGreen),
                SizedBox(width: 5.0),
                _buildButton(context, 'Xoá', deletePhone,
                    color: AppColor.colorRed),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'Giá: ${phone.Price}',
              style: AppTextStyle.regularBlack1A,
              textAlign: TextAlign.left,
            ),
            Text(
              'Hãng sản xuất: ${phone.Manufacturer}',
              style: AppTextStyle.regularBlack1A,
              textAlign: TextAlign.left,
            ),
            Text(
              'CPU: ${phone.Cpu}',
              style: AppTextStyle.regularBlack1A,
              textAlign: TextAlign.left,
            ),
            Text(
              'Độ rộng màn hình: ${phone.Screen}',
              style: AppTextStyle.regularBlack1A,
              textAlign: TextAlign.left,
            ),
            Text(
              'Ram: ${phone.Ram}',
              style: AppTextStyle.regularBlack1A,
              textAlign: TextAlign.left,
            ),
            Text(
              'Bộ nhớ trong: ${phone.InternalMemory}',
              style: AppTextStyle.regularBlack1A,
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String label, void Function()? onPressed,
      {Color color = AppColor.colorGreen}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        elevation: 0.0,
      ),
      child: Text(label),
    );
  }

  void editPhone() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => EditPhoneScreen(phone: phone)));
  }

  void deletePhone() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return confirmDialog(
            context, 'Xoá', 'Bạn chắc chắn muốn xoá danh bạ này?');
      },
    ).then((acceptDelete) {
      if (acceptDelete ?? false) {
        HomeBloC.getInstance().deletePhone(phone).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(StringUtil.stringFromException(error))));
        });
        if (widget.onRemoved != null) {
          widget.onRemoved!.call();
        }
      }
    });
  }
}
