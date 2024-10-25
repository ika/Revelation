import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:revelation/about/page.dart';
import 'package:revelation/bkmarks/page.dart';
import 'package:revelation/bloc/bloc_font.dart';
import 'package:revelation/bloc/bloc_italic.dart';
import 'package:revelation/bloc/bloc_scroll.dart';
import 'package:revelation/bloc/bloc_size.dart';
import 'package:revelation/bloc/bloc_theme.dart';
import 'package:revelation/chapters/page.dart';
import 'package:revelation/fonts/fonts.dart';
import 'package:revelation/main/page.dart';
import 'package:revelation/search/search.dart';
import 'package:revelation/theme/apptheme.dart';
import 'package:revelation/theme/theme.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  //DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<RefsBloc>(
        //   create: (context) => RefsBloc(),
        // ),
        BlocProvider<ScrollBloc>(
          create: (context) => ScrollBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<FontBloc>(
          create: (context) => FontBloc(),
        ),
        BlocProvider<ItalicBloc>(
          create: (context) => ItalicBloc(),
        ),
        BlocProvider<SizeBloc>(
          create: (context) => SizeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, bool>(
        builder: (context, state) {
          return MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: const [
              Locale('en'), // English
              //Locale('es'), // Spanish
            ],
            debugShowCheckedModeBanner: false,
            title: 'The Revelation of John',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state ? ThemeMode.light : ThemeMode.dark,
            initialRoute: '/root',
            routes: {
              '/root': (context) => const RevPage(),
              '/bookmarks': (context) => const BMMarksPage(),
              '/chapters': (context) => const CaMarksPage(),
              '/fonts': (context) => const FontsPage(),
              '/theme': (context) => const ThemePage(),
              '/about': (context) => const AboutPage(),
              '/search': (context) => const SearchPage()
            },
          );
        },
      ),
    );
  }
}
