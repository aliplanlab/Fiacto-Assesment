import 'package:common/common.dart';
import 'package:flutter/material.dart';

const kDropdownItemHeight = 48.0;
typedef DropDownOptionBuilder<T> = Widget Function(T item);

class SingleSelectDropdown<T> extends StatelessWidget {
  const SingleSelectDropdown({
    super.key,
    this.selectedOption,
    this.hint,
    this.options = const [],
    required this.onChanged,
    this.optionBuilder,
    this.selectedOptionBuilder,
    this.label,
    this.hintText,
    this.errorText,
    this.onTap,
    this.suffixIcon = const Icon(Icons.keyboard_arrow_down_rounded),
    this.prefixIcon,
    this.visibleOptionCount = 5,
    this.alignment = AlignmentDirectional.centerStart,
    this.border,
    this.readOnly = false,
    this.enabled = true,
    this.loading = false,
    this.dropdownColor,
  });

  final T? selectedOption;
  final List<T> options;
  final OnValue<T?>? onChanged;
  final DropDownOptionBuilder<T>? optionBuilder;
  final DropDownOptionBuilder<T>? selectedOptionBuilder;
  final Widget? label;
  final String? hintText;
  final String? hint;
  final String? errorText;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int visibleOptionCount;
  final AlignmentGeometry alignment;
  final InputBorder? border;
  final bool readOnly;
  final bool enabled;
  final bool loading;
  final Color? dropdownColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          label!,
          const SizedBox(height: 4),
        ],
        DropdownButtonFormField<T>(
          isExpanded: true,
          dropdownColor: dropdownColor,
          onChanged: enabled && !loading ? onChanged : null,
          onTap: onTap,
          value: selectedOption,
          itemHeight: kDropdownItemHeight,
          menuMaxHeight: 16.0 + (kDropdownItemHeight * visibleOptionCount),
          alignment: alignment,
          selectedItemBuilder: (BuildContext context) {
            return readOnly && selectedOption != null
                ? [selectedDropDownItem(context, selectedOption as T)]
                : [
                    if (hintText != null)
                      Text(
                        hintText!,
                        style: context.fourteen400.hint(context),
                      ),
                    ...options.map(
                      (item) => selectedDropDownItem(context, item),
                    ),
                  ];
          },
          items: readOnly && selectedOption != null
              ? [dropDownItem(context, selectedOption as T)]
              : <DropdownMenuItem<T>>[
                  if (hintText != null)
                    DropdownMenuItem(
                      child: Text(
                        hintText!,
                        style: context.sixteen400,
                      ),
                    ),
                  ...options.map(
                    (item) => dropDownItem(context, item),
                  ),
                ],
          style: context.fourteen400,
          hint: Text(
            hint ?? '',
            style: context.sixteen400.withColor(context.grey400),
          ),
          icon: loading ? const CustomProgress.small() : suffixIcon,
          decoration: InputDecoration(
            border: border,
            focusedBorder: border,
            enabledBorder: border,
            errorText: errorText,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<T> dropDownItem(BuildContext context, T item) =>
      DropdownMenuItem(
        value: item,
        child: optionBuilder != null
            ? optionBuilder!.call(item)
            : Text(
                item.toString(),
                style: item == selectedOption
                    ? context.fourteen400.hint(context)
                    : null,
              ),
      );

  Widget selectedDropDownItem(BuildContext context, T item) =>
      selectedOptionBuilder?.call(item) ??
      Text(
        item.toString(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
}
