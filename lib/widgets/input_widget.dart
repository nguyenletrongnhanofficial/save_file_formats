import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../values/app_color.dart';

class InputWidget extends StatefulWidget {
  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget>
    with SingleTickerProviderStateMixin {
  TextEditingController formatController = TextEditingController();
  String saveFormat = "svg";
  String? customFormat;
  late String defaultFileName;

  @override
  void initState() {
    super.initState();
    defaultFileName = _getDefaultFileName();
  }

  String _getDefaultFileName() {
    DateTime now = DateTime.now();
    String fileName =
        '${now.second}_${now.minute}_${now.hour}_${now.month}_${now.year}';
    return fileName;
  }

  void saveToFile(String text, String format, String fileName) {
    final textBlob = Blob([text]);
    final url = Url.createObjectUrlFromBlob(textBlob);
    final anchorElement = AnchorElement()
      ..href = url
      ..download = '$fileName.$format';

    anchorElement.click();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Saved file successfully!',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Rubik-Bold',
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  void handleDownload() {
    String format = formatController.text.trim();

    if (saveFormat == "svg") {
      String removedText = format.replaceAll(
          'font-family="none" font-weight="none" font-size="none" text-anchor="none"',
          '');

      if (removedText.isNotEmpty) {
        saveToFile(removedText, saveFormat, defaultFileName);
      } else {
        _showErrorSnackBar('Please Input Code!');
      }
    } else {
      if (format.isNotEmpty) {
        saveToFile(format, saveFormat, defaultFileName);
      } else {
        _showErrorSnackBar('Please Input Code!');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Rubik-Bold',
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackBackground,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Input code",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Rubik-Bold',
                  color: AppColor.whiteText,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: formatController,
                maxLines: null,
                minLines: 7,
                decoration: InputDecoration(
                  fillColor: AppColor.blackBackgroundText,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.whiteBorder),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.whiteBorder),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Format",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Rubik-Bold',
                  color: AppColor.whiteText,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              DropdownButtonFormField(
                value: saveFormat,
                onChanged: (String? newValue) {
                  setState(() {
                    saveFormat = newValue!;
                  });
                },
                items: <String>[
                  'svg',
                  'txt',
                  'json',
                  'Custom',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Rubik-Bold',
                        color: AppColor.whiteText,
                      ),
                    ),
                  );
                }).toList(),
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Rubik-Bold',
                  color: AppColor.whiteText,
                ),
                decoration: InputDecoration(
                  fillColor: AppColor.blackBackgroundText,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.whiteBorder),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.whiteBorder),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                dropdownColor: AppColor.blackBackgroundText,
              ),
              if (saveFormat == "Custom")
                Column(
                  children: [
                    const SizedBox(height: 5),
                    TextField(
                      onChanged: (String value) {
                        setState(() {
                          customFormat = value;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Rubik-Bold',
                        color: AppColor.whiteText,
                      ),
                      decoration: InputDecoration(
                        fillColor: AppColor.blackBackgroundText,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColor.whiteBorder),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColor.whiteBorder),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16.0),
              const Text(
                "File name",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Rubik-Bold',
                  color: AppColor.whiteText,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                onChanged: (String value) {
                  defaultFileName = value;
                },
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Rubik-Bold',
                  color: AppColor.whiteText,
                ),
                decoration: InputDecoration(
                  fillColor: AppColor.blackBackgroundText,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.whiteBorder),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.whiteBorder),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              InkWell(
                onTap: handleDownload,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColor.botton,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/download.svg',
                        height: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('Download',
                          style: TextStyle(
                            color: AppColor.whiteText,
                            fontFamily: 'Rubik-Bold',
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
