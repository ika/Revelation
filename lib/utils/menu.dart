import 'package:revelation/bkmarks/model.dart';
import 'package:revelation/bkmarks/queries.dart';
import 'package:revelation/utils/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

BMQueries bmQueries = BMQueries();

Future<dynamic> showPopupMenu(BuildContext context, BmModel model) async {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height * .3;

  await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(width, height, 50, 0),
    items: [
      PopupMenuItem(
        child: Text(AppLocalizations.of(context)!.bookmark),
        onTap: () {
          bmQueries.getBookMarkExists(model.doc, model.page, model.para).then(
            (value) {
              (value < 1)
                  ? bmQueries.saveBookMark(model).then((value) {
                      Future.delayed(
                          Duration(microseconds: Globals.navigatorDelay), () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizations.of(context)!.added),
                          ),
                        );
                      });
                    })
                  : ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!.exists),
                      ),
                    );
            },
          );
        },
      ),
      PopupMenuItem(
        child: Text(AppLocalizations.of(context)!.copy),
        onTap: () {
          final copyText = <String>[model.subtitle];

          final sb = StringBuffer();
          sb.writeAll(copyText);

          Clipboard.setData(
            ClipboardData(text: sb.toString()),
          ).then((_) {
            Future.delayed(Duration(milliseconds: Globals.navigatorLongDelay),
                () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.copied),
                ),
              );
            });
          });
        },
      ),
    ],
    elevation: 8.0,
  );
}
