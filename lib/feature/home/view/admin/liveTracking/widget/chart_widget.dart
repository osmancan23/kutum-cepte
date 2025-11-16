import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/app/color_constants.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key, this.completePercent, this.waitingPercent, this.height = 450, this.width = 380});
  final int? completePercent;
  final int? waitingPercent;
  final double width;
  final double height;
  @override
  State<StatefulWidget> createState() => ChartWidgetState();
}

class ChartWidgetState extends State<ChartWidget> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width.w,
      height: widget.height.h,
      decoration: BoxDecoration(color: Colors.white, borderRadius: context.border.highBorderRadius),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            'Genel Bakış',
            textStyle: context.general.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          20.h.ph,
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.3,
                child: AspectRatio(
                  aspectRatio: 1,
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
                            touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 80.w,
                      sections: showingSections(),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: 5.h,
                child: Align(
                  child: CircleAvatar(
                    radius: 40.r,
                    backgroundColor: locator<ColorConstants>().brightGray,
                    child: SvgPicture.asset(IconEnums.box.svgPathIcon),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(30, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Container(
                  width: 2.w,
                  height: 5.h,
                  color: (index % 4 == 0) ? locator<ColorConstants>().philippineGreen : Colors.orange.withOpacity(0.3),
                ),
              );
            }),
          ),
          20.h.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Indicator(color: locator<ColorConstants>().philippineGreen, text: 'Toplanan'),
              30.w.pw,
              const Indicator(color: Colors.orange, text: 'Bekleyen'),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.sp : 16.sp;
      final radius = isTouched ? 60.0 : 50.0;
      final widgetSize = isTouched ? 65.0 : 50.0;

      switch (i) {
        case 0:
          // Waiting Percent
          return PieChartSectionData(
            showTitle: false,
            color: context.general.colorScheme.primary,
            value: widget.waitingPercent?.toDouble(),
            radius: radius - 10,
            badgeWidget: _Badge(
              widget.waitingPercent ?? 0,
              size: widgetSize,
              textColor: context.general.colorScheme.primary,
              fontSize: fontSize,
            ),
            badgePositionPercentageOffset: .8,
          );
        case 1:
          // Collected Percent
          return PieChartSectionData(
            color: const Color(0xff087F41),
            value: widget.completePercent?.toDouble(),
            radius: radius,
            showTitle: false,
            badgeWidget: _Badge(
              widget.completePercent ?? 0,
              size: widgetSize,
              textColor: locator<ColorConstants>().philippineGreen,
              fontSize: fontSize,
            ),
            badgePositionPercentageOffset: 0.8,
          );

        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.percent, {
    required this.size,
    required this.textColor,
    required this.fontSize,
  });
  final int percent;
  final double size;
  final Color textColor;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: CustomText(
          '%$percent',
          textStyle: context.general.textTheme.bodyMedium?.copyWith(
            fontSize: fontSize,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    required this.color,
    required this.text,
    super.key,
  });
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        5.w.pw,
        CustomText(
          text,
          textStyle: context.general.textTheme.bodySmall?.copyWith(
            color: locator<ColorConstants>().gray,
          ),
        ),
      ],
    );
  }
}
