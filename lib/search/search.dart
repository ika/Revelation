import 'package:flutter/material.dart';
import 'package:revelation/main/model.dart';
import 'package:revelation/main/queries.dart';
import 'package:revelation/utils/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<Rev> list = List<Rev>.empty();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Rev>>(
      future: RevQueries().getSearchedValues('topaz'),
      builder: (context, AsyncSnapshot<List<Rev>> snapshot) {
        if (snapshot.hasData) {
          list = snapshot.data!;
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
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
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
