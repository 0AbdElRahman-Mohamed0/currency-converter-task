import 'package:currency_conversion/utils/app_strings.dart';
import 'package:currency_conversion/view/widgets/graph_chart.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  Widget _buildBody() {
    return Column(
      children: const [
        LineChartSample2(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text(AppStrings.result),
    );
    return Scaffold(
      appBar: appBar,
      body: _buildBody(),
    );
  }
}
