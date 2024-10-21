import 'dart:async';

import 'package:revelation/bkmarks/model.dart';
import 'package:revelation/bkmarks/queries.dart';
import 'package:revelation/bloc/bloc_scroll.dart';
import 'package:revelation/utils/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bookmarks

final BMQueries bmQueries = BMQueries();

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

class BMMarksPage extends StatefulWidget {
  const BMMarksPage({super.key});

  @override
  BMMarksPageState createState() => BMMarksPageState();
}

class BMMarksPageState extends State<BMMarksPage> {
  List<BmModel> list = List<BmModel>.empty();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BmModel>>(
      future: bmQueries.getBookMarkList(),
      builder: (context, AsyncSnapshot<List<BmModel>> snapshot) {
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
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                ),
              ),
              title: const Text('Bookmarks',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (details.primaryVelocity! > 0 ||
                          details.primaryVelocity! < 0) {
                        confirmDialog(context, list, index).then((value) {
                          if (value) {
                            bmQueries
                                .deleteBookMark(list[index].id!)
                                .then((value) {
                              setState(() {});
                            });
                          }
                        });
                      }
                    },
                    child: ListTile(
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

                        switch (list[index].doc) {
                          case 1:
                            Future.delayed(
                              Duration(milliseconds: Globals.navigatorDelay),
                              () {
                                if (context.mounted) {
                                  Navigator.pushNamed(context, '/root');
                                }
                              },
                            );
                            break;
                        }
                      },
                    ),
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
