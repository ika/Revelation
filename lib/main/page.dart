import 'dart:ui';
import 'package:revelation/bkmarks/model.dart';
import 'package:revelation/bloc/bloc_chapters.dart';
import 'package:revelation/bloc/bloc_font.dart';
import 'package:revelation/bloc/bloc_italic.dart';
import 'package:revelation/bloc/bloc_refs.dart';
import 'package:revelation/bloc/bloc_scroll.dart';
import 'package:revelation/bloc/bloc_size.dart';
import 'package:revelation/fonts/list.dart';
import 'package:revelation/main/model.dart';
import 'package:revelation/main/queries.dart';
import 'package:revelation/utils/globals.dart';
import 'package:revelation/utils/menu.dart';
import 'package:revelation/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

late bool refsAreOn;
int indexNumber = 0;

late PageController? pageController;

class ConfPage extends StatefulWidget {
  const ConfPage({super.key});

  //final int page;

  @override
  State<ConfPage> createState() => _ConfPageState();
}

class _ConfPageState extends State<ConfPage> {
  ItemScrollController initialScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    
    refsAreOn = context.read<RefsBloc>().state;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Future.delayed(Duration(milliseconds: Globals.navigatorLongDelay), () {
          if (initialScrollController.isAttached) {
            initialScrollController
                .scrollTo(
              index: indexNumber, //context.read<ScrollBloc>().state,
              duration: Duration(milliseconds: Globals.navigatorLongDelay),
              curve: Curves.easeInOutCubic,
            )
                .then((value) {
              // reset scrollto
              context.read<ScrollBloc>().add(
                    UpdateScroll(index: 0),
                  );
            });
          } else {
            debugPrint("initialScrollController is NOT attached");
          }
        });
      },
    );
  }

  itemScrollControllerSelector() {
    initialScrollController = ItemScrollController();
  }

  void getPageController() {
    //pageController = PageController(initialPage: pageNumber);
    pageController =
        PageController(initialPage: context.read<ChapterBloc>().state);
  }

  Widget showListTile(Wesminster chapter) {
   // return (refsAreOn)
        // ? ListTile(
        //     title: LinkifyText(
        //       "${chapter.t}",
        //       linkStyle: const TextStyle(color: Colors.red),
        //       linkTypes: const [LinkType.hashTag],
        //       textStyle: TextStyle(
        //           fontFamily: fontsList[context.read<FontBloc>().state],
        //           fontStyle: (context.read<ItalicBloc>().state)
        //               ? FontStyle.italic
        //               : FontStyle.normal,
        //           fontSize: context.read<SizeBloc>().state),
        //       onTap: (link) {
        //         int lnk = int.parse(link.value!.toString().replaceAll('#', ''));

        //         debugPrint("${chapter.c}:${chapter.v}:$lnk");

        //         // ReQueries().getRef(lnk).then(
        //         //   (value) {
        //         //     String n = value.elementAt(0).n.toString();
        //         //     String t = value.elementAt(0).t.toString();

        //         //     // remove number from the text
        //         //     int p = t.indexOf(' ');
        //         //     t = t.substring(p).trim();

        //         //     Map<String, String> data = {'header': n, 'contents': t};

        //         //     GetRef().refDialog(context, data);
        //         //   },
        //         // );
        //       },
        //     ),
        //   )
        return ListTile(
            title: Text(
              chapter.t!,
              style: TextStyle(
                  fontFamily: fontsList[context.read<FontBloc>().state],
                  fontStyle: (context.read<ItalicBloc>().state)
                      ? FontStyle.italic
                      : FontStyle.normal,
                  fontSize: context.read<SizeBloc>().state),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint("SCROLL TO INDEX ${context.read<ScrollBloc>().state}");

    indexNumber = context.read<ScrollBloc>().state;
    //pageNumber = widget.page;

    getPageController();
    // context
    //     .read<ChapterBloc>()
    //     .add(UpdateChapter(chapter: pageController!.page!.toInt()));
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          actions: [
            Switch(
              value: refsAreOn,
              onChanged: (bool value) {
                context.read<RefsBloc>().add(ChangeRefs(refsAreOn: value));
                setState(() {
                  refsAreOn = value;
                });
              },
            ),
          ],
          title: BlocBuilder<ChapterBloc, int>(
            builder: (context, state) {
              int p = state + 1;
              return Text(
                "${AppLocalizations.of(context)!.chapter} $p",
                style: const TextStyle(fontWeight: FontWeight.w700),
              );
            },
          ),
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () {
              Future.delayed(Duration(microseconds: Globals.navigatorDelay),
                  () {
                Navigator.of(context).pop();
              });
            },
          ),
        ),
        body: FutureBuilder<int>(
          future: WeQueries(refsAreOn).getChapterCount(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasData) {
              int chapterCount = snapshot.data!.toInt();
              return ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse
                  },
                ),
                child: PageView.builder(
                  controller: pageController,
                  itemCount: chapterCount,
                  physics: const BouncingScrollPhysics(),
                  pageSnapping: true,
                  itemBuilder: (BuildContext context, int index) {
                    itemScrollControllerSelector();
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<List<Wesminster>>(
                        future: WeQueries(refsAreOn).getChapter(
                            index + 1), // index +1 from page controller
                        initialData: const [],
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Wesminster>> snapshot) {
                          if (snapshot.hasData) {
                            return ScrollablePositionedList.builder(
                              itemCount: snapshot.data!.length,
                              itemScrollController: initialScrollController,
                              itemBuilder: (BuildContext context, int index) {
                                final chapter = snapshot.data![index];
                                return GestureDetector(
                                  child: showListTile(chapter),
                                  onTap: () {
                                    final model = BmModel(
                                        title: tableIndex[chapter.c! - 1],
                                        subtitle: chapter.t!,
                                        doc: 1, // document one
                                        page: chapter.c!,
                                        para: index);

                                    showPopupMenu(context, model);
                                  },
                                );
                              },
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    // move to next chapter
                    //pageNumber = index + 1;
                    context
                        .read<ChapterBloc>()
                        .add(UpdateChapter(chapter: index));
                  },
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
