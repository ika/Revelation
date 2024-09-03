import 'dart:async';

import 'package:revelation/bloc/bloc_scroll.dart';
import 'package:revelation/chapters/model.dart';
import 'package:revelation/chapters/queries.dart';
import 'package:revelation/main/page.dart';
import 'package:revelation/utils/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Chapters

final CaQueries caQueries = CaQueries();

Future confirmDialog(BuildContext context, List list, int index) async {
  return showDialog(
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.delete), // title
      content:
          Text("${list[index].title}\n${list[index].subtitle}"), // subtitle
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context)!.yes,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        TextButton(
          child: Text(AppLocalizations.of(context)!.no,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    ),
    context: context,
  );
}

class CaMarksPage extends StatefulWidget {
  const CaMarksPage({super.key});

  @override
  CaMarksPageState createState() => CaMarksPageState();
}

class CaMarksPageState extends State<CaMarksPage> {
  List<CaModel> list = List<CaModel>.empty();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CaModel>>(
      future: caQueries.getChapterList(),
      builder: (context, AsyncSnapshot<List<CaModel>> snapshot) {
        if (snapshot.hasData) {
          list = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 5,
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Future.delayed(
                      Duration(milliseconds: Globals.navigatorDelay),
                      () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
              title: Text(AppLocalizations.of(context)!.chapters,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    // contentPadding: const EdgeInsets.symmetric(
                    //     horizontal: 20.0, vertical: 10.0),
                    title: Text(
                      list[index].title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Row(
                      children: [
                        Icon(Icons.linear_scale,
                            color: Theme.of(context).colorScheme.primary),
                        Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            //strutStyle: const StrutStyle(fontSize: 12.0),
                            text: TextSpan(
                              text: " ${list[index].subtitle}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20.0),
                    onTap: () {
                      // update scroll
                      context.read<ScrollBloc>().add(
                            UpdateScroll(index: list[index].para),
                          );
                  
                      // pop before return
                      // int c = 0;
                      // Navigator.of(context).popUntil((route) => c++ == 2);
                  
                      switch (list[index].doc) {
                        case 1:
                          Future.delayed(
                            Duration(milliseconds: Globals.navigatorDelay),
                            () {
                              Navigator.pushNamed(context, '/root');
                            },
                          );
                          break;
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class ProofsPage {}
