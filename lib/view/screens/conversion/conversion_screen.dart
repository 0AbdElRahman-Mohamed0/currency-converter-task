import 'package:currency_conversion/data/extension_methods/dio_error_extention.dart';
import 'package:currency_conversion/models/currency_model.dart';
import 'package:currency_conversion/providers/currencies_provider.dart';
import 'package:currency_conversion/providers/data_provider.dart';
import 'package:currency_conversion/utils/app_colors.dart';
import 'package:currency_conversion/utils/app_strings.dart';
import 'package:currency_conversion/utils/dimensions.dart';
import 'package:currency_conversion/utils/empty_space_extension.dart';
import 'package:currency_conversion/view/screens/result/result_screen.dart';
import 'package:currency_conversion/view/widgets/custom_button.dart';
import 'package:currency_conversion/view/widgets/custom_loader.dart';
import 'package:currency_conversion/view/widgets/error_pop_up.dart';
import 'package:currency_conversion/view/widgets/form_widgets/input_form_field.dart';
import 'package:currency_conversion/view/widgets/form_widgets/simple_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  CurrencyModel? _currencyFrom;
  CurrencyModel? _currencyTo;
  PickerDateRange? _dateRange;
  num? _amount;
  bool _convertOnly = false;
  bool _isLoading = false;

  _submit() async {
    if (!_formKey.currentState!.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    if (_dateRange == null && !_convertOnly) {
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: 'Please select date range',
        backgroundColor: AppColors.primary,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    } else if ((_dateRange?.startDate == null || _dateRange?.endDate == null) &&
        !_convertOnly) {
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
    try {
      _isLoading = true;
      setState(() {});
      if (_convertOnly) {
        await context.read<DataProvider>().convertCurrency(
            _currencyFrom!.code!, _currencyTo!.code!, _amount ?? 1);
      } else {
        await context.read<DataProvider>().getCurrencyChanges(
            _dateRange!.startDate!.toString(),
            _dateRange!.endDate!.toString(),
            _currencyFrom!.code!,
            _currencyTo!.code!);
        if (!mounted) return;

        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => ResultScreen(
              currencyFrom: _currencyFrom!,
              currencyTo: _currencyTo!,
            ),
          ),
        );
      }
      _isLoading = false;
      setState(() {});
    } on DioError catch (e) {
      _isLoading = false;
      setState(() {});
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              ErrorPopUp(message: e.readableError));
    } catch (e) {
      _isLoading = false;
      setState(() {});
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            const ErrorPopUp(message: 'Something went wrong please try again.'),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      _isLoading = true;
      setState(() {});
      await context.read<CurrenciesProvider>().getCurrencies();
      _isLoading = false;
      setState(() {});
    } on DioError catch (e) {
      _isLoading = false;
      setState(() {});
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              ErrorPopUp(message: e.readableError));
    } catch (e) {
      _isLoading = false;
      setState(() {});
      showDialog(
        context: context,
        builder: (BuildContext context) => const ErrorPopUp(
            message: 'Something went wrong please restart the application.'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencies = context.watch<CurrenciesProvider>().currencies;
    final converted = context.watch<DataProvider>().convertResult;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: CustomLoader(
        isLoading: currencies == null || _isLoading,
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            children: [
              SimpleDropDown<CurrencyModel>(
                text: 'Convert from',
                hintText: 'From',
                list: currencies,
                validator: Validator(
                  rules: [
                    RequiredRule(validationMessage: 'Required'),
                  ],
                ),
                onSaved: (currencyFrom) => _currencyFrom = currencyFrom,
                onChanged: (v) {},
              ),
              20.ph,
              SimpleDropDown<CurrencyModel>(
                text: 'Convert to',
                hintText: 'To',
                list: currencies,
                validator: Validator(
                  rules: [
                    RequiredRule(validationMessage: 'Required'),
                  ],
                ),
                onSaved: (currencyTo) => _currencyTo = currencyTo,
                onChanged: (v) {},
              ),
              22.ph,
              if (_convertOnly)
                InputFormField(
                  labelText: 'Amount',
                  above: true,
                  initialValue: '1',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  hintText: 'Enter amount you want to convert',
                  onSaved: (amount) {
                    _amount = num.parse(amount ?? '1');
                  },
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
                      selectionMode: DateRangePickerSelectionMode.range,
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
              if (_convertOnly && converted != null) ...{
                20.ph,
                Text(
                  '$_amount ${_currencyFrom!.description} = $converted ${_currencyTo!.description}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      fontWeight: FontWeight.w700),
                ),
              },
              70.ph,
              CustomButton(
                onTap: _submit,
                title: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
