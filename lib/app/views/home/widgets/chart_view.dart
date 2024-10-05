import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../shared/shared.dart';
import 'indicator.dart';

class MiPieChart extends StatefulWidget {
  const MiPieChart({super.key});

  @override
  State<StatefulWidget> createState() => MiPieChartState();
}

class MiPieChartState extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 50,
                sections: showingSections(theme),
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Indicator(
                    color: AppColors.greenO,
                    text: 'Paiement versé',
                  ),
                  Gap(4),
                  Indicator(
                    color: AppColors.orange,
                    text: 'Paiement en attente',
                  ),
                  Gap(4),
                  Indicator(
                    color: AppColors.red,
                    text: 'Paiement non-versé',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(ThemeData theme) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 90.0 : 80.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.greenO,
            value: 55,
            title: '55%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              color: theme.highlightColor,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.orange,
            value: 30,
            title: '30%',
            radius: radius,
            borderSide: BorderSide(
              color: theme.cardColor,
              width: 2,
            ),
            titleStyle: TextStyle(
              fontSize: fontSize,
              color: theme.highlightColor,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.red,
            value: 15,
            title: '15%',
            radius: radius,
            borderSide: BorderSide(
              color: theme.cardColor,
              width: 2,
            ),
            titleStyle: TextStyle(
              fontSize: fontSize,
              color: theme.highlightColor,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
