import 'package:flutter/material.dart';
import 'package:revelation/main/model.dart';
import 'package:revelation/main/queries.dart';
import 'package:revelation/utils/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

RevQueries revQueries = RevQueries();

String contents = '';

Future<List<Rev>>? results;
Future<List<Rev>>? blankSearch;
Future<List<Rev>>? filteredSearch;

List<IconData> icons = [
  Icons.search,
  Icons.close,
];

// Icon button var
int x = 0;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

Future emptyInputDialog(context) async {
  showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return const AlertDialog(
        // title: Text('Empty Input!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Please enter a search text!'),
            ],
          ),
        ),
      );
    },
  );
}

class _SearchPageState extends State<SearchPage> {
  @override
  initState() {
    super.initState();
    blankSearch = Future.value([]);
    filteredSearch = blankSearch;

    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) {
    //     bibleVersion = context.read<VersionBloc>().state;
    //     bibleLang = Utilities(bibleVersion).getLanguage();
    //   },
    // );
  }

  Future<void> runFilter(String enterdKeyWord) async {
    //debugPrint(enterdKeyWord);
    //enterdKeyWord = " $enterdKeyWord"; // add leading space

    enterdKeyWord.isEmpty
        ? results = blankSearch
        : results = RevQueries().getSearchedValues(enterdKeyWord);

        // Print a Future<List> from database 
        results?.then((List<Rev> list){
              for(var i = 0; i < list.length; i++){
                debugPrint(list[i].t.toString());
              }
        });

    // Refresh the UI
    // setState(
    //   () {
    //     filteredSearch = results;
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
          title: Text(AppLocalizations.of(context)!.search,
              style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
        body: Container(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: '',
                maxLength: 40,
                maxLines: 1,
                autofocus: false,
                // onTap: () {
                //   filteredSearch = Future.value([]);
                // },
                onChanged: (value) {
                  contents = value;
                },
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.search,
                  suffixIcon: IconButton(
                    icon: Icon(icons[x]), //const Icon(Icons.search),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Future.delayed(
                        Duration(milliseconds: Globals.navigatorDelay),
                        () {
                          if (contents.isEmpty) {
                            // input is empty
                            emptyInputDialog(context).then((onValue) {
                              Future.delayed(
                                Duration(
                                    milliseconds: Globals.navigatorDialogDelay),
                                () {
                                  Navigator.of(context).pop();
                                },
                              );
                            });
                          } else {
                            // input not empty
                            setState(() {
                              x = 1;
                            });
                            runFilter(contents);
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder<List<Rev>>(
                  future: filteredSearch,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                         // return listTileMethod(snapshot, index);
                         ListTile(
                          title: Text(snapshot.data!.first.t));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
