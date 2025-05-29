import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.initialValue,
    this.controller,
    this.labelText,
    this.label,
    this.helperText,
    this.errorText,
    this.error,
    this.hintText,
    this.textStyle,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.autocorrect = true,
    this.enabled,
    this.readOnly = false,
    this.mandatory = false,
    this.obscureText = false,
    this.autofocus = false,
    this.fillColor,
    this.borderColor,
    this.borderRadius = 16,
    this.borderWidth,
    this.dropShadow,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.margin,
    this.iconConstraints = const BoxConstraints(minWidth: 56, minHeight: 24),
    this.validator,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
  });

  const CustomTextField.form({
    super.key,
    this.initialValue,
    this.controller,
    this.labelText,
    this.label,
    this.helperText,
    this.errorText,
    this.error,
    this.hintText = 'Enter here',
    this.textStyle,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.autocorrect = true,
    this.enabled,
    this.readOnly = false,
    this.mandatory = false,
    this.obscureText = false,
    this.autofocus = false,
    this.fillColor,
    this.borderColor,
    this.borderRadius = 8,
    this.borderWidth = 1,
    this.dropShadow,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    this.margin,
    this.iconConstraints = const BoxConstraints(minWidth: 56, minHeight: 24),
    this.validator,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
  });

  final String? initialValue;
  final TextEditingController? controller;
  final String? labelText;
  final Widget? label;
  final String? helperText;
  final String? errorText;
  final Widget? error;
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool autocorrect;
  final bool? enabled;
  final bool readOnly;
  final bool mandatory;
  final bool obscureText;
  final bool autofocus;
  final Color? fillColor;
  final Color? borderColor;
  final double borderRadius;
  final double? borderWidth;
  final double? dropShadow;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? iconConstraints;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  int? get _maxLines =>
      (maxLines ?? 0) <= (minLines ?? 0) ? minLines : maxLines;

  OutlineInputBorder border(Color color) => OutlineInputBorder(
        borderSide: borderWidth != null
            ? BorderSide(
                width: borderWidth!,
                color: color,
              )
            : BorderSide.none,
        borderRadius: BorderRadius.circular(borderRadius),
      );

  @override
  Widget build(BuildContext context) {
    return dropShadow != null
        ? CustomInkWell(
            margin: margin,
            borderRadius: borderRadius,
            dropShadow: dropShadow,
            color: fillColor ?? context.white,
            child: _buildTextField(context),
          )
        : Container(
            margin: margin,
            child: _buildTextField(context),
          );
  }

  Column _buildTextField(BuildContext context) {
    final enabled = this.enabled ?? true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText?.isNotEmpty == true || label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: label ??
                TextFieldLabel(
                  labelText!,
                  mandatory: mandatory,
                ),
          ),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          style: textStyle ?? context.sixteen400,
          textInputAction: textInputAction,
          autocorrect: autocorrect,
          enabled: enabled,
          readOnly: readOnly,
          maxLines: _maxLines,
          minLines: minLines,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          initialValue: initialValue,
          obscureText: obscureText,
          autofocus: autofocus,
          onTap: onTap,
          validator: validator,
          decoration: InputDecoration(
            errorText: errorText,
            hintText: hintText,
            hintStyle: hintStyle ?? context.sixteen400.hint(context),
            filled: true,
            fillColor:
                enabled ? fillColor ?? context.white : const Color(0xFFF7F7F7),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            prefixIconConstraints: iconConstraints,
            suffixIconConstraints: iconConstraints,
            contentPadding: padding,
            border: border(borderColor ?? context.outline),
            enabledBorder: border(borderColor ?? context.outline),
            focusedBorder: border(context.primary500),
            errorBorder: border(context.error500.outline),
            focusedErrorBorder: border(context.error500),
            disabledBorder: border(context.outline),
          ),
        ),
        if (helperText?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: TextFieldHelper(helperText!),
          ),
      ],
    );
  }
}

class SuffixIcon extends StatelessWidget {
  const SuffixIcon({
    super.key,
    this.icon,
    this.color,
    this.upsideDown = false,
  });

  final Widget? icon;
  final Color? color;
  final bool upsideDown;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.hint;
    return icon == null
        ? const SizedBox.shrink()
        : CupertinoTheme(
            data: CupertinoThemeData(
              primaryColor: color,
            ),
            child: IconTheme(
              data: context.theme.iconTheme.copyWith(
                color: color,
              ),
              child: AnimatedRotation(
                turns: upsideDown ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: icon,
              ),
            ),
          );
  }
}

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel(
    this.text, {
    super.key,
    this.trailing,
    this.style,
    this.color,
    this.mandatory = false,
    this.mainAxisAlignment,
  });

  const TextFieldLabel.mandatory(
    this.text, {
    super.key,
    this.trailing,
    this.style,
    this.color,
    this.mainAxisAlignment,
  }) : mandatory = true;

  final String text;
  final String? trailing;
  final TextStyle? style;
  final Color? color;
  final bool mandatory;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.fourteen400;
    final color = this.color ?? context.grey400;
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: text,
            style: style.withColor(color),
            children: [
              if (mandatory)
                TextSpan(
                  text: ' *',
                  style: style.error(context),
                ),
            ],
          ),
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: style.hint(context),
          ),
      ],
    );
  }
}

class TextFieldHelper extends StatelessWidget {
  const TextFieldHelper(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.twelve400,
    );
  }
}

class TextFieldError extends StatelessWidget {
  const TextFieldError(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.twelve400.error(context),
    );
  }
}

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.loading = false,
    this.autofocus = false,
    this.controller,
    this.hintText = 'Search',
    this.prefixIcon = const AssetIcon.monotone(AssetIcons.search),
    this.textInputAction = TextInputAction.search,
    this.inputFormatters,
    this.margin = const EdgeInsets.fromLTRB(16, 0, 16, 16),
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
  });

  final bool loading;
  final bool autofocus;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      autofocus: autofocus,
      controller: controller,
      hintText: hintText,
      margin: margin,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      textStyle: context.sixteen400,
      hintStyle: context.sixteen400.hint(context),
      prefixIcon: prefixIcon,
      textInputAction: textInputAction,
      inputFormatters: [...Forms.notEmptyFormatters, ...?inputFormatters],
      suffixIcon: loading ? const CustomProgress.small(centered: false) : null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      dropShadow: 8,
    );
  }
}
