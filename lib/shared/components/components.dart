import 'package:flutter/material.dart';
import 'package:flutter_shop_app/shared/constants/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defultText({
  required String text,
  int? maxLines,
  TextOverflow? textOverflow,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  bool isUpper = false,
  TextDecoration? decoration,
  TextAlign? textAlign,
}) =>
    Text(
      isUpper ? text.toUpperCase() : text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
      ),
    );

Widget defultTextButton({
  required Function onPressed,
  required String text,
  int? maxLines,
  TextOverflow? textOverflow,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) =>
    TextButton(
      onPressed: () {
        onPressed();
      },
      child: defultText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        maxLines: maxLines,
        textOverflow: textOverflow,
      ),
    );

void navigateTo(context, Widget widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(context, Widget widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget defultTextFormField({
  required TextEditingController controller,
  required String textValidate,
  Function? onFieldSubmitted,
  Function? onChanged,
  required String labelText,
  required Function onPressedSuffixIcon,
  required IconData prefixIconData,
  required TextInputType textInputType,
  bool obscureText = false,
  int maxLines = 1,
  double? fontSize,
  FontWeight? fontWeight,
  Color color = defultApplicationColor,
  IconData? suffixIconData,
  double? iconSize,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      cursorColor: defultApplicationColor,
      maxLines: maxLines,
      validator: (value) {
        if (value!.isEmpty) {
          return textValidate;
        }
        return null;
      },
      onChanged: (value){
        onChanged!(value);
      },
      onFieldSubmitted: (value) {
        onFieldSubmitted!(value);
      },
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
        prefixIcon: Icon(
          prefixIconData,
          size: iconSize,
          color: defultApplicationColor,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            onPressedSuffixIcon();
          },
          icon: Icon(
            suffixIconData,
            size: iconSize,
            color: defultApplicationColor,
          ),
        ),
      ),
    );

Widget defultIconButton({
  required Function onPressed,
  required IconData iconData,
}) =>
    IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        onPressed();
      },
      icon: Icon(
        iconData,
      ),
    );

Widget defultCatIconButton({
  required Function onPressed,
  required IconData iconData,
}) =>
    IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        onPressed();
      },
      icon: Icon(
        iconData,
        size: 20,
        color: Colors.white,
      ),
    );

Widget defultMaterialButton({
  required Function onPressed,
  required String text,
  double width = double.infinity,
  double height = 40,
  double border = 10,
  double fontSize = 20,
  FontWeight fontWeight = FontWeight.bold,
  Color backgroundColor = defultApplicationColor,
  Color textColor = Colors.white,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(border),
      ),
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        child: defultText(
          text: isUpperCase ? text.toUpperCase() : text,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
    );

Future<bool?> defultFlutterToast({
  required String text,
  Toast? toastLength = Toast.LENGTH_LONG,
  ToastGravity? toastGravity = ToastGravity.BOTTOM,
  int timeInSecForIosWeb = 1,
  ToastStates? toastStates,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: toastLength,
      gravity: toastGravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: chooseToastColor(toastStates!),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[100],
      ),
    );

Widget defultCircularProgressIndicator() => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: CircularProgressIndicator()),
          const SizedBox(
            height: 10,
          ),
          defultText(
            text: 'Loading',
          )
        ],
      ),
    );
