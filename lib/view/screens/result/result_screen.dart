import 'package:currency_conversion/models/currency_change_model.dart';
import 'package:currency_conversion/models/currency_model.dart';
import 'package:currency_conversion/providers/data_provider.dart';
import 'package:currency_conversion/utils/app_strings.dart';
import 'package:currency_conversion/utils/dimensions.dart';
import 'package:currency_conversion/utils/empty_space_extension.dart';
import 'package:currency_conversion/view/widgets/custom_button.dart';
import 'package:currency_conversion/view/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {Key? key, required this.currencyFrom, required this.currencyTo})
      : super(key: key);

  final CurrencyModel currencyFrom;
  final CurrencyModel currencyTo;

  @override
  Widget build(BuildContext context) {
    final currencyChanges = context.watch<DataProvider>().rates;
    final appBar = AppBar(
      title: const Text(AppStrings.result),
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back_ios),
      ),
    );
    return CustomLoader(
      isLoading: currencyChanges == null,
      child: Scaffold(
        appBar: appBar,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: SfCartesianChart(
                      primaryXAxis: DateTimeAxis(),
                      series: <ChartSeries>[
                        LineSeries<CurrencyChangeModel, DateTime>(
                          dataSource: currencyChanges!,
                          xValueMapper: (CurrencyChangeModel data, _) =>
                              DateTime.parse(data.date!),
                          yValueMapper: (CurrencyChangeModel data, _) =>
                              data.value,
                        ),
                      ],
                    ),
                  ),
                  14.ph,
                  Text(
                    'Currency Changes Over Time From ${currencyFrom.description} To ${currencyTo.description}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            14.ph,
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    vertical: Dimensions.PADDING_SIZE_LARGE),
                children: currencyChanges
                    .map(
                      (change) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(title: change.date!),
                              ),
                              20.pw,
                              Expanded(
                                child: CustomButton(
                                    title:
                                        '${change.value} ${currencyTo.code}'),
                              ),
                            ],
                          ),
                          10.ph,
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
