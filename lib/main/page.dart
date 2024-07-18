import 'package:revelation/bkmarks/model.dart';
import 'package:revelation/bloc/bloc_font.dart';
import 'package:revelation/bloc/bloc_italic.dart';
import 'package:revelation/bloc/bloc_scroll.dart';
import 'package:revelation/bloc/bloc_size.dart';
import 'package:revelation/fonts/list.dart';
import 'package:revelation/main/model.dart';
import 'package:revelation/main/queries.dart';
import 'package:revelation/utils/globals.dart';
import 'package:revelation/utils/menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:share_plus/share_plus.dart';

// Revelation

late bool refsAreOn;

RevQueries revQueries = RevQueries();

class RevPage extends StatefulWidget {
  const RevPage({super.key});

  @override
  RevPageState createState() => RevPageState();
}

class RevPageState extends State<RevPage> {
  ItemScrollController initialScrollController = ItemScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Rev> paragraphs = List<Rev>.empty();

  @override
  void initState() {
    super.initState();

    // refsAreOn = context.read<RefsBloc>().state;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Future.delayed(Duration(milliseconds: Globals.navigatorLongDelay), () {
          if (initialScrollController.isAttached) {
            initialScrollController.scrollTo(
              index: context.read<ScrollBloc>().state,
              duration: Duration(milliseconds: Globals.navigatorLongDelay),
              curve: Curves.easeInOutCubic,
            );
            // reset scroll index
            context.read<ScrollBloc>().add(
                  UpdateScroll(index: 0),
                );
          } else {
            debugPrint("initialScrollController in NOT attached");
          }
        });
      },
    );
  }

  drawerCode() {
    return Drawer(
      //backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 150.0,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                  //color: Theme.of(context).colorScheme.inversePrimary
                  ),
              child: Baseline(
                baseline: 80,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  AppLocalizations.of(context)!.index,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              AppLocalizations.of(context)!.bookmarks,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.pushNamed(context, '/bookmarks');
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              AppLocalizations.of(context)!.chapters,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.pushNamed(context, '/chapters');
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              AppLocalizations.of(context)!.fonts,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.pushNamed(context, '/fonts').then((value) {
                    setState(() {});
                  });
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.pushNamed(context, '/theme');
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              AppLocalizations.of(context)!.about,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.pushNamed(context, '/about');
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              AppLocalizations.of(context)!.share,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            dense: true,
            onTap: () {
              Navigator.pop(context);
              Share.share(
                  'https://play.google.com/store/apps/details?id=org.armstrong.ika.revelation');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Rev>>(
      future: revQueries.getRev(),
      builder: (context, AsyncSnapshot<List<Rev>> snapshot) {
        if (snapshot.hasData) {
          paragraphs = snapshot.data!;
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              elevation: 5,
              // actions: [
              //   Switch(
              //     value: refsAreOn,
              //     onChanged: (bool value) {
              //       context.read<RefsBloc>().add(ChangeRefs(refsAreOn: value));
              //       setState(() {
              //         refsAreOn = value;
              //         (refsAreOn)
              //             ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //                 content:
              //                     Text(AppLocalizations.of(context)!.noteson)))
              //             : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //                 content: Text(
              //                     AppLocalizations.of(context)!.notesoff)));
              //       });
              //     },
              //   ),
              // ],
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Future.delayed(
                      Duration(milliseconds: Globals.navigatorDelay),
                      () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                    );
                  },
                ),
              ),
              title: Text(AppLocalizations.of(context)!.revelation,
                  style: const TextStyle(fontWeight: FontWeight.w700)
                  // style: const TextStyle(
                  //   color: Colors.yellow,
                  // ),
                  ),
            ),
            drawer: drawerCode(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScrollablePositionedList.builder(
                itemCount: paragraphs.length,
                itemScrollController: initialScrollController,
                itemBuilder: (BuildContext context, int index) {
                  String verseText = paragraphs[index].t;
                  // String verseText = (refsAreOn)
                  //     ? paragraphs[index].t
                  //     : paragraphs[index]
                  //         .t
                  //         .replaceAll(RegExp('\\[.*?\\]'), "* ");
                  return ListTile(
                    title: Text(
                      verseText, // with footnote links
                      style: TextStyle(
                          fontFamily: fontsList[context.read<FontBloc>().state],
                          fontStyle: (context.read<ItalicBloc>().state)
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontSize: context.read<SizeBloc>().state),
                    ),
                    onTap: () {
                      final model = BmModel(
                          title: AppLocalizations.of(context)!.revelation,
                          subtitle: paragraphs[index].t,
                          doc: 1, // Prefrences
                          page: 0, // not used
                          para: index);

                      showPopupMenu(context, model);
                    },
                  );
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
