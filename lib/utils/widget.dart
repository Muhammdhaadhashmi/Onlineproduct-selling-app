import 'package:flutter/material.dart';
import 'package:onicame/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

InputDecoration inputDecoration(
    {String? labelText, Icon? icon, String? pretext}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: secondaryTextStyle(),
    prefixIcon: icon,
    prefixText: pretext,
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primaryColor), borderRadius: radius()),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: viewLineColor), borderRadius: radius()),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: errorColor), borderRadius: radius()),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: errorColor), borderRadius: radius()),
    disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: viewLineColor), borderRadius: radius()),
  );
}
