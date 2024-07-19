import 'package:flutter/material.dart';
import 'package:revelation/utils/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
            //   padding: const EdgeInsets.all(50.0),
            //   child: Column(
            //     children: [
            //       TextFormField(
            //         initialValue: '',
            //         maxLength: 40,
            //         maxLines: 1,
            //         autofocus: false,
            //         onTap: () {
            //           filteredSearch = Future.value([]);
            //         },
            //         onChanged: (value) {
            //           _contents = value;
            //         },
            //         decoration: InputDecoration(
            //           labelText: 'Search',
            //           //labelStyle: TextStyle(fontSize: primaryTextSize),
            //           suffixIcon: IconButton(
            //             icon: const Icon(Icons.search),
            //             onPressed: () {
            //               FocusScope.of(context).unfocus();
            //               Future.delayed(
            //                 Duration(milliseconds: Globals.navigatorDelay),
            //                 () {
            //                   _contents.isEmpty
            //                       ? emptyInputDialog(context)
            //                       : runFilter(_contents);
            //                 },
            //               );
            //             },
            //           ),
            //         ),
            //       ),
            //       // const SizedBox(
            //       //   height: 20,
            //       // ),
            //       Expanded(
            //         child: FutureBuilder<List<Bible>>(
            //           future: filteredSearch,
            //           builder: (BuildContext context, snapshot) {
            //             if (snapshot.hasData) {
            //               return ListView.separated(
            //                 itemCount: snapshot.data!.length,
            //                 itemBuilder: (context, index) {
            //                   return listTileMethod(snapshot, index);
            //                 },
            //                 separatorBuilder: (BuildContext context, int index) =>
            //                     const Divider(),
            //               );
            //             }
            //             return const Center(
            //               child: CircularProgressIndicator(),
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            ),
      ),
    );
  }
}