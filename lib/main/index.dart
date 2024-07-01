import 'package:revelation/about/page.dart';
import 'package:revelation/bkmarks/page.dart';
import 'package:revelation/bloc/bloc_chapters.dart';
import 'package:revelation/fonts/fonts.dart';
import 'package:revelation/main/page.dart';
import 'package:revelation/theme/theme.dart';
import 'package:revelation/utils/globals.dart';
import 'package:revelation/utils/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

// subject: AppLocalizations.of(context)!.title);
// onShareLink(uri) async {
//   final result = await Share.share(uri);
//   if (result.status == ShareResultStatus.success) {
//     debugPrint('success');
//   }
// }

// onShareLink(uri) {
//   Share.share(uri);
// }

class _IndexPageState extends State<IndexPage> {
  List<String> tableIndex = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BMMarksPage(),
                    ),
                  );
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
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FontsPage(),
                    ),
                  );
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
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThemePage(),
                    ),
                  );
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
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutPage(),
                    ),
                  );
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
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
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
    // reset chapter
    // context.read<ChapterBloc>().add(
    //       UpdateChapter(chapter: 1),
    //     );
    return FutureBuilder<List<String>>(
      future: Utils().getTableIndex(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          tableIndex = snapshot.data!;
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              elevation: 5,
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
              title: Text(
                AppLocalizations.of(context)!.table,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            drawer: drawerCode(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ListView.separated(
                  itemCount: tableIndex.length,
                  itemBuilder: (BuildContext context, int index) {
                    int num = index + 1;
                    String chap =
                        '${AppLocalizations.of(context)!.chapter} $num:';
                    return ListTile(
                      title: Text(
                        chap,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: Row(
                        children: [
                          Icon(Icons.linear_scale,
                              color: Theme.of(context).colorScheme.primary),
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: " ${tableIndex[index]}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          )
                        ],
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20.0),
                      onTap: () {
                        context
                            .read<ChapterBloc>()
                            .add(UpdateChapter(chapter: index));
                        Future.delayed(
                          Duration(milliseconds: Globals.navigatorDelay),
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ConfPage(),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
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
