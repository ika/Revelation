import 'package:flutter/material.dart';
import 'package:revelation/main/model.dart';
import 'package:revelation/main/queries.dart';
import 'package:revelation/utils/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String contents = '';
Future<List<Rev>>? filteredSearch;
Future<List<Rev>>? blankSearch;
Future<List<Rev>>? results;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<Rev> list = List<Rev>.empty();

  @override
  void initState() {
    super.initState();
    blankSearch = Future.value([]);
    filteredSearch = blankSearch;
  }

  Future<void> runFilter(String enterdKeyWord) async {
    enterdKeyWord.isEmpty
        ? results = blankSearch
        : results = RevQueries().getSearchedValues(enterdKeyWord);

    //   // Print a Future<List> from database
    //   results?.then((List<Rev> list) {
    //     for (var i = 0; i < list.length; i++) {
    //       debugPrint(list[i].t.toString());
    //     }
    //   });

    setState(
      () {
        filteredSearch = results;
      },
    );
  }

  Future emptyInputDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        // Schedule a delayed dismissal of the alert dialog after 3 seconds
        Future.delayed(Duration(milliseconds: Globals.navigatorDialogDelay),
            () {
          Navigator.of(context).pop(); // Close the dialog
        });

        return const AlertDialog(
            //title: Text('Empty Input!'),
            content: SingleChildScrollView(
          child: ListBody(
            children: [Text('Please enter a search text!')],
          ),
        ));
      },
    );
  }

  RichText highLiteSearchWord(String t, String m) {
    int idx = t.toLowerCase().indexOf(m.toLowerCase());

    if (idx != -1) {
      return RichText(
        //softWrap: true,
        text: TextSpan(
          text: t.substring(0, idx),
          style: Theme.of(context).textTheme.bodyMedium,
          // style: TextStyle(
          //   color: Theme.of(context).colorScheme.primary,
          // ),
          children: [
            TextSpan(
              text: t.substring(idx, idx + m.length),
              //style: Theme.of(context).textTheme.bodyMedium,
              style: TextStyle(
                //fontWeight: FontWeight.w700
                //color: Theme.of(context).colorScheme.primary
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
              ),
            ),
            TextSpan(
              text: t.substring(idx + m.length),
              style: Theme.of(context).textTheme.bodyMedium,
              //style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      );
    } else {
      return RichText(
        //softWrap: true,
        text: TextSpan(
          text: t,
          style: const TextStyle(
            //fontSize: primaryTextSize,
            color: Colors.black,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: Text(
          AppLocalizations.of(context)!.search,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Search...',
                suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      (contents.isEmpty)
                          ? emptyInputDialog(context)
                          : runFilter(contents);
                    }),
              ),
              // onTap: () {
              //   filteredSearch = Future.value([]);
              // },
              onChanged: (value) {
                contents = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<Rev>>(
                future: filteredSearch,
                builder: (context, AsyncSnapshot<List<Rev>> snapshot) {
                  if (snapshot.hasData) {
                    list = snapshot.data!;
                    return ListView.separated(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            list[index].t,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
