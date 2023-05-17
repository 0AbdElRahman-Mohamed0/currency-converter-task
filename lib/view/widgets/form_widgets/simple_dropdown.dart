import 'package:currency_conversion/utils/app_colors.dart';
import 'package:currency_conversion/utils/dimensions.dart';
import 'package:currency_conversion/utils/empty_space_extension.dart';
import 'package:flutter/material.dart';

class SimpleDropDown<T> extends StatefulWidget {
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final String? labelText;
  final String? text;
  final bool small;
  final List<T>? list;
  final FormFieldValidator<T>? validator;
  final FormFieldSetter<T>? onSaved;
  final Widget? prefixIcon;

  const SimpleDropDown({
    Key? key,
    this.value,
    @required this.onChanged,
    this.hintText,
    this.small = false,
    this.labelText,
    this.text,
    @required this.list,
    @required this.validator,
    @required this.onSaved,
    this.prefixIcon,
  }) : super(key: key);

  @override
  State<SimpleDropDown> createState() => _SimpleDropDownState<T>();
}

class _SimpleDropDownState<T> extends State<SimpleDropDown<T>> {
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.text != null) ...{
          Text(
            widget.text!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.w500),
          ),
          4.ph,
        },
        DropdownButtonFormField<T>(
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          value: widget.value,
          onChanged: widget.onChanged,
          focusNode: _focus,
          validator: widget.validator,
          onSaved: widget.onSaved,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: Dimensions.FONT_SIZE_LARGE),
          icon: widget.list!.isNotEmpty
              ? const Icon(Icons.keyboard_arrow_down)
              : Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.secondary,
                ),
          selectedItemBuilder: (context) => widget.list!
              .map(
                (e) => widget.small
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: Text(
                          '$e',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Dimensions.FONT_SIZE_LARGE),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : Text(
                        '$e',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: Dimensions.FONT_SIZE_LARGE),
                        overflow: TextOverflow.ellipsis,
                      ),
              )
              .toList(),
          items: widget.list
              ?.map((T e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(
                    '$e',
                    overflow: TextOverflow.ellipsis,
                  )))
              .toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.primary,
            hintText: widget.hintText,
            labelText: widget.labelText,
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 24, maxWidth: 24),
            contentPadding:
                const EdgeInsets.only(right: 16, left: 10, top: 12, bottom: 12),
          ),
        ),
      ],
    );
  }
}
