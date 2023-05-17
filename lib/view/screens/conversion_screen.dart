import 'package:currency_conversion/utils/app_colors.dart';
import 'package:currency_conversion/utils/app_strings.dart';
import 'package:currency_conversion/utils/dimensions.dart';
import 'package:currency_conversion/utils/empty_space_extension.dart';
import 'package:currency_conversion/view/widgets/custom_button.dart';
import 'package:currency_conversion/view/widgets/form_widgets/input_form_field.dart';
import 'package:currency_conversion/view/widgets/form_widgets/simple_dropdown.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({Key? key}) : super(key: key);

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String? _currencyFrom;
  String? _currencyTo;
  PickerDateRange? _dateRange;
  String? _amount;
  bool _convertOnly = false;

  _submit() async {
    if (!_formKey.currentState!.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    if (_dateRange == null) {
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: 'Please select date range',
        backgroundColor: AppColors.primary,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    } else if (_dateRange?.startDate == null || _dateRange?.endDate == null) {
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: 'Please select start and end range',
        backgroundColor: AppColors.primary,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }
    _formKey.currentState!.save();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          children: [
            Row(
              children: [
                Expanded(
                  child: SimpleDropDown(
                    text: 'Convert from',
                    hintText: 'From',
                    list: const ['1', '2', '3'],
                    validator: Validator(
                      rules: [
                        RequiredRule(validationMessage: 'Required'),
                      ],
                    ),
                    onSaved: (currencyFrom) => _currencyFrom = currencyFrom,
                    onChanged: (v) {},
                  ),
                ),
                20.pw,
                Expanded(
                  child: SimpleDropDown(
                    text: 'Convert to',
                    hintText: 'To',
                    list: const ['1', '2', '3'],
                    validator: Validator(
                      rules: [
                        RequiredRule(validationMessage: 'Required'),
                      ],
                    ),
                    onSaved: (currencyTo) => _currencyTo = currencyTo,
                    onChanged: (v) {},
                  ),
                ),
              ],
            ),
            22.ph,
            if (_convertOnly)
              InputFormField(
                labelText: 'Amount',
                above: true,
                hintText: 'Enter amount you want to convert',
                onSaved: (amount) => _amount = amount,
                prefixIcon: const Icon(Icons.currency_exchange),
                validator: Validator(
                  rules: [
                    RequiredRule(validationMessage: 'Required'),
                  ],
                ),
              )
            else
              Column(
                children: [
                  Text(
                    'Select start and end dates to show currency changes over time',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        fontWeight: FontWeight.w700),
                  ),
                  14.ph,
                  SfDateRangePicker(
                    rangeSelectionColor: Colors.black.withOpacity(0.4),
                    endRangeSelectionColor: AppColors.secondary,
                    startRangeSelectionColor: AppColors.secondary,
                    selectionTextStyle: Theme.of(context).textTheme.bodySmall,
                    maxDate: DateTime.now(),
                    onSelectionChanged: (range) {
                      _dateRange = range.value;
                      setState(() {});
                    },
                    selectionMode: DateRangePickerSelectionMode.extendableRange,
                  ),
                ],
              ),
            Row(
              children: [
                Checkbox(
                  value: _convertOnly,
                  onChanged: (value) {
                    _convertOnly = !_convertOnly;
                    setState(() {});
                  },
                  activeColor: AppColors.primary,
                ),
                Text(
                  _convertOnly
                      ? 'Uncheck to get currency changes.'
                      : 'Only convert currency? please check here.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            70.ph,
            CustomButton(
              onTap: _submit,
              title: 'Submit',
            ),
          ],
        ),
      ),
    );
  }
}
