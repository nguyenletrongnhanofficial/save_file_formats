import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_file_formats/widgets/input_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../animations/type_writer_effect.dart';
import '../values/app_color.dart';
import '../animations/draw_clip.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: const Duration(seconds: 10),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Transform(
                transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                alignment: Alignment.center,
                child: ClipPath(
                  clipper: DrawClip(_controller.value),
                  child: Container(
                    height: size.height * 0.71,
                    decoration: const BoxDecoration(color: AppColor.yellow),
                  ),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: DrawClip(_controller.value),
                child: Container(
                  height: size.height * 0.65,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.white,
                          Colors.white,
                        ]),
                  ),
                ),
              ),
            );
          },
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 35, 10, 35),
                child: Column(
                  children: [
                    Wrap(
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
                          "Save File Formats",
                          style: TextStyle(
                            fontSize: 60,
                            fontFamily: 'Rubik-Bold',
                            color: AppColor.whiteText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const TypeWriterTextEffect(
                      text:
                          'This magical website helps you save any code snippets as any file you want, enjoy it😇',
                    ),
                  ],
                ),
              ),
              Container(
                  height: size.height * 0.7,
                  width: size.width * 0.85,
                  constraints: const BoxConstraints(maxWidth: 700),
                  decoration: BoxDecoration(
                      color: AppColor.botton,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColor.botton,
                          spreadRadius: 0.5,
                          blurRadius: 10,
                        ),
                      ]),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: InputWidget())),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        launchUrl(Uri.parse(
                            'https://www.facebook.com/nguyenletrongnhanofficial'));
                      },
                      child: SvgPicture.asset(
                        "assets/svgs/facebook.svg",
                        color: AppColor.blackBackground,
                        height: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        launchUrl(Uri.parse(
                            'https://github.com/nguyenletrongnhanofficial/save_file_formats'));
                      },
                      child: SvgPicture.asset(
                        "assets/svgs/github.svg",
                        color: AppColor.blackBackground,
                        height: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Made by NGUYEN LE TRONG NHAN",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Rubik-SemiBold',
                        color: AppColor.blackBackgroundText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
