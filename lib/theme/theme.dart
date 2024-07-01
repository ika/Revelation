import 'package:revelation/bloc/bloc_theme.dart';
import 'package:revelation/utils/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  ThemePageState createState() => ThemePageState();
}

class ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
          title: Text(AppLocalizations.of(context)!.switcher, style: const TextStyle(fontWeight: FontWeight.w700)),
          // actions: [
          //   Switch(
          //     value: (context.read<ThemeBloc>()) ? true : false,
          //     onChanged: (bool value) {
          //       context.read<ThemeBloc>().add(ChangeTheme(value));
          //     },
          //   ),
          // ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.lightdark,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () =>
                        context.read<ThemeBloc>().add(ChangeTheme(isDark:  false)),
                    child: Text(AppLocalizations.of(context)!.light),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    onPressed: () =>
                        context.read<ThemeBloc>().add(ChangeTheme(isDark:  true)),
                    child: Text(AppLocalizations.of(context)!.dark),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
