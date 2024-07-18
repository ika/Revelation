import 'dart:async';
import 'dart:io';
import 'package:revelation/bloc/bloc_font.dart';
import 'package:revelation/bloc/bloc_italic.dart';
import 'package:revelation/bloc/bloc_size.dart';
import 'package:revelation/fonts/list.dart';
import 'package:revelation/utils/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late int selectedFont;
late int fontNumber;
late bool italicIsOn;
late double textSize;

class FontsPage extends StatefulWidget {
  const FontsPage({super.key});

  @override
  State<FontsPage> createState() => _FontsPageState();
}

class _FontsPageState extends State<FontsPage> {
  @override
  void initState() {
    super.initState();
    selectedFont = context.read<FontBloc>().state;
    italicIsOn = context.read<ItalicBloc>().state;
    textSize = context.read<SizeBloc>().state;
  }

  Future<dynamic> fontConfirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(fontsList[fontNumber]),
          content: Text(
            AppLocalizations.of(context)!.ps23,
            softWrap: true,
            style: TextStyle(
              fontFamily: fontsList[fontNumber],
              fontStyle: (italicIsOn) ? FontStyle.italic : FontStyle.normal,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<FontBloc>()
                          .add(UpdateFont(font: fontNumber));
                      Future.delayed(
                        Duration(milliseconds: Globals.navigatorDelay),
                        () {
                          Navigator.of(context).pop();
                          //Navigator.of(context).pop();
                          setState(() {
                            selectedFont = fontNumber;
                          });
                        },
                      );
                    },
                    child: Text(AppLocalizations.of(context)!.yes),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context)!.no),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  //late String valueChosen;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
         // centerTitle: true,
          elevation: 5,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () {
              //backButton(context);
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
          //elevation: 16,
          title: Text(
            "${AppLocalizations.of(context)!.fontsize} $textSize",
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          actions: [
            //   Switch(
            //     value: italicIsOn,
            //     onChanged: (bool value) {
            //       context.read<ItalicBloc>().add(ChangeItalic(value));
            //       setState(() {
            //         italicIsOn = value;
            //       });
            //     },
            //   )
            PopupMenuButton(
              icon: const Icon(Icons.format_size_sharp),
              itemBuilder: (context) {
                if (Platform.isLinux || Platform.isWindows) {
                  return [
                    const PopupMenuItem<int>(
                      value: 14,
                      child: Text("14.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 16,
                      child: Text("16.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 18,
                      child: Text("18.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 20,
                      child: Text("20.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 22,
                      child: Text("22.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 24,
                      child: Text("24.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 26,
                      child: Text("26.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 28,
                      child: Text("28.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 30,
                      child: Text("30.0"),
                    ),
                  ];
                } else {
                  return [
                    const PopupMenuItem<int>(
                      value: 12,
                      child: Text("12.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 14,
                      child: Text("14.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 16,
                      child: Text("16.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 18,
                      child: Text("18.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 20,
                      child: Text("20.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 22,
                      child: Text("22.0"),
                    ),
                    const PopupMenuItem<int>(
                      value: 24,
                      child: Text("24.0"),
                    ),
                  ];
                }
              },
              onSelected: (int value) {
                double val = value.toDouble();
                context.read<SizeBloc>().add(UpdateSize(size: val));
                setState(() {
                  textSize = val;
                });
              },
            ),
            PopupMenuButton(
              icon: const Icon(Icons.format_italic_sharp),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(AppLocalizations.of(context)!.normal),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text(AppLocalizations.of(context)!.italic,
                        style: const TextStyle(fontStyle: FontStyle.italic)),
                  ),
                ];
              },
              onSelected: (int value) {
                bool on = (value == 1) ? true : false;
                context.read<ItalicBloc>().add(ChangeItalic(italicIsOn: on));
                setState(() {
                  italicIsOn = on;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: ListView.builder(
            itemCount: fontsList.length,
            itemBuilder: (BuildContext context, int index) {
              String t = (italicIsOn)
                  ? AppLocalizations.of(context)!.italic
                  : AppLocalizations.of(context)!.normal;

              return ListTile(
                title: Text("${fontsList[index]} $t",
                    style: TextStyle(
                      fontStyle:
                          (italicIsOn) ? FontStyle.italic : FontStyle.normal,
                    )),
                subtitle: Text(
                  AppLocalizations.of(context)!.shepherd,
                  style: TextStyle(
                      backgroundColor: (index == selectedFont)
                          ? Theme.of(context).colorScheme.tertiaryContainer
                          : null,
                      fontStyle:
                          (italicIsOn) ? FontStyle.italic : FontStyle.normal,
                      fontFamily: fontsList[index],
                      fontSize: textSize),
                ),
                onTap: () {
                  fontNumber = index;

                  fontConfirmDialog(context);

                  // fontConfirmDialog(context).then(
                  //   (value) {
                  //     // pop and set state on main page
                  //     int c = 2;
                  //     Navigator.of(context).popUntil((route) => c++ == 2);
                  //     setState(() {});
                  //   },
                  // );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
