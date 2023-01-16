import 'package:charja_charity/core/utils/extension/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.isRequired = false,
    this.fieldStateKey,
    this.useObscure = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.canSubmit = true,
    this.hintText,
    this.onChanged,
    this.isSuffixIcon,
    this.suffixIcon,
    this.initialValue,
    this.hintColor,
    this.textEditingController,
    this.onTab,
    this.keyboardType,
    this.focusNode,
    this.validator,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.nextFocusNode,
    this.autovalidateMode,
    this.labelColor,
    this.labelText,
    this.labelStyle,
    this.enabled,
    this.maxLine = 1,
  }) : super(key: key);

  final GlobalKey<FormFieldState<String>>? fieldStateKey;

  final bool isRequired;
  final String? hintText;
  final bool useObscure;
  final bool? isSuffixIcon;
  final Widget? suffixIcon;
  final Color? hintColor;
  final Color? labelColor;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  final String? initialValue;
  final Function? onTab;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final bool canSubmit;
  final AutovalidateMode? autovalidateMode;
  final bool autoFocus;
  final String? labelText;
  final TextStyle? labelStyle;
  final bool? enabled;
  final int? maxLine;
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;
  bool focused = false;

  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) widget.textEditingController?.value = TextEditingValue(text: widget.initialValue!);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && !focused) {
        if (mounted) setState(() => focused = true);
      } else if (!_focusNode.hasFocus && focused) {
        if (mounted) setState(() => focused = false);
        if (widget.validator != null && widget.textEditingController?.text.isNullOrEmpty == false) {
          widget.fieldStateKey?.currentState?.validate();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText != null
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  widget.labelText!,
                  style: widget.labelStyle ?? AppTheme.bodyText2.copyWith(fontSize: 14),
                  maxLines: 1,
                ),
              )
            : const SizedBox.shrink(),
        TextFormField(
          key: widget.fieldStateKey,
          style: TextStyle(
            color: widget.hintColor,
          ),

          keyboardType: widget.keyboardType ?? TextInputType.text,
          focusNode: _focusNode,
          onTap: widget.onTab as void Function()?,
          autofocus: widget.autoFocus,
          // ignore: avoid_bool_literals_in_conditional_expressions
          obscureText: widget.useObscure ? !showPassword : false,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          maxLines: widget.maxLine,
          // style: titleMedium(context),
          // initialValue: widget.initialValue,
          controller: widget.textEditingController,
          textInputAction: widget.nextFocusNode == null ? TextInputAction.done : TextInputAction.next,
          onFieldSubmitted: (text) {
            //widget.textEditingController?.text.trim();
            if (widget.nextFocusNode != null) {
              widget.nextFocusNode!.requestFocus();
              widget.fieldStateKey?.currentState?.validate();
            } else if (widget.canSubmit) {
              widget.onFieldSubmitted?.call(text);
            }
          },
          readOnly: widget.readOnly,
          inputFormatters: widget.keyboardType == TextInputType.number
              ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
              : [
                  NoLeadingSpaceFormatter(),
                ],
          decoration: InputDecoration(
            errorMaxLines: 3,
            hintText: widget.hintText,
            fillColor: AppColors.kLightColor,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColors.kMediumLightColor, width: 0.5),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.kMediumLightColor, width: 0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kMediumColor, width: 0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintStyle: AppTheme.subtitle1.copyWith(color: AppColors.kGrayTextField, fontSize: 14),
            labelStyle: TextStyle(color: widget.hintColor, fontSize: 14),
            // labelStyle: labelMedium(context,color: widgets.hintColor),
            suffixIcon: widget.isSuffixIcon == true
                ? (widget.suffixIcon ??
                    IconButton(
                      onPressed: () => setState(() => showPassword = !showPassword), //widget.onPressed,
                      icon: Icon(
                        size: 20,
                        color: AppColors.kPDarkBlueColor,
                        showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ))
                : null,
          ),
        ),
      ],
    );
  }

  String? getLabel() {
    if (widget.hintText == null) {
      return null;
    }
    if (!widget.isRequired) {
      return widget.hintText;
    }
    return '${widget.hintText} *';
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}
