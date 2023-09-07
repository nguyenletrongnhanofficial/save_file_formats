import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import '../values/app_color.dart';

class HeadingView extends StatelessWidget {
  const HeadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title = Wrap(
      alignment: WrapAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/svgs/download.svg",
          color: AppColor.botton,
          height: 60,
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          'Save File Formats',
          style: TextStyle(
            fontSize: 60,
            fontFamily: 'Rubik-Bold',
            color: AppColor.whiteText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );

    title = title.animate(adapter: ValueAdapter(0.5)).shimmer(
      colors: [
        Colors.white,
        const Color(0xFF45FFCA),
        const Color(0xFFFEFFAC),
        const Color(0xFFFFB6D9),
        const Color(0xFFD67BFF),
      ],
    );

    title = title
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .saturate(delay: 2.seconds, duration: 3.seconds)
        .then()
        .tint(color: const Color(0xFF80DDFF))
        .then()
        .blurXY(end: 24)
        .fadeOut();

    return Padding(padding: const EdgeInsets.all(10), child: title);
  }
}
