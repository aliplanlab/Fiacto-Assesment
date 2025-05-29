import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.isRequired = false,
    this.hasError = false,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autocorrect = false,
    this.initialValue,
    this.keyboardType,
    this.helperText,
    this.hintText,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.onChanged,
    this.onTap,
    this.contentPadding,
    this.borderRadius,
    this.borderSide,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.hintTextStyle,
    this.textInputAction,
    this.inputFormatters,
    this.fillColor,
    this.filled,
  });

  final TextEditingController? controller;
  final String? labelText;
  final bool? isRequired;
  final String? initialValue;
  final bool hasError;
  final bool readOnly;
  final bool enabled;
  final bool autocorrect;
  final bool obscureText;
  final int maxLines;
  final String? helperText;
  final String? errorText;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final TextStyle? hintTextStyle;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final bool? filled;

  bool get _showErrorText => hasError && (errorText != null);

  bool get _showHintText => !_showErrorText && (helperText != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          _LabelText(
            key: const Key('label-text'),
            labelText: labelText,
            isRequired: isRequired,
          ),
          const SizedBox(height: 12.0),
        ],
        TextFormField(
          inputFormatters: inputFormatters,
          controller: controller,
          initialValue: initialValue,
          style: context.sixteen400,
          keyboardType: keyboardType,
          obscureText: obscureText,
          obscuringCharacter: '*',
          maxLines: maxLines,
          textInputAction: textInputAction,
          readOnly: readOnly,
          onChanged: onChanged,
          onTap: onTap,
          enabled: enabled,
          autocorrect: autocorrect,
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: filled,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: hintTextStyle ?? context.sixteen400.hint(context),
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 12.0,
                ),
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                  borderSide: borderSide ??
                      BorderSide(
                        color: context.grey400,
                      ),
                  borderRadius: borderRadius ?? BorderRadius.circular(10.0),
                ),
            disabledBorder: disabledBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: context.grey400,
                  ),
                  borderRadius: borderRadius ?? BorderRadius.circular(10.0),
                ),
            border: OutlineInputBorder(
              borderSide: borderSide ??
                  BorderSide(
                    color: context.grey400,
                  ),
              borderRadius: borderRadius ?? BorderRadius.circular(10.0),
            ),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: context.primary500,
                  ),
                  borderRadius: borderRadius ?? BorderRadius.circular(10.0),
                ),
          ),
        ),
        if (_showHintText) ...[
          const SizedBox(height: 4.0),
          _HelperText(
            key: const Key('helper-text'),
            helperText: helperText!,
          ),
        ],
        if (_showErrorText) ...[
          const SizedBox(height: 4.0),
          _ErrorText(
            key: const Key('error-text'),
            errorText: errorText!,
          ),
        ],
      ],
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText({
    super.key,
    required this.errorText,
  });

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Text(
      errorText,
      style: context.twelve400.withColor(
        context.error500,
      ),
    );
  }
}

class _HelperText extends StatelessWidget {
  const _HelperText({
    super.key,
    required this.helperText,
  });

  final String helperText;

  @override
  Widget build(BuildContext context) {
    return Text(
      helperText,
      style: context.twelve400,
    );
  }
}

class _LabelText extends StatelessWidget {
  const _LabelText({
    super.key,
    required this.labelText,
    bool? isRequired,
  }) : isRequired = isRequired ?? false;

  final String? labelText;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          labelText!,
          style: context.textTheme.titleSmall,
        ),
        if (isRequired) ...[
          const SizedBox(width: 4.0),
          Text(
            '*',
            key: const Key('required-indicator'),
            style: context.textTheme.displaySmall,
          ),
        ],
      ],
    );
  }
}
