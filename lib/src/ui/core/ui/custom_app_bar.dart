import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../themes/view_models/theme_state.dart';
import '../themes/view_models/theme_view_model.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, this.title});

  final themeViewModel = ThemeViewModel.getInstance();

  Widget? title;
  @override
  State<StatefulWidget> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title,
      centerTitle: true,
      actions: [
        IconButton(
          tooltip: AppLocalizations.of(context)!.settings,
          iconSize: 30,
          onPressed: () async {
            await _buildSettings(context);
          },
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }

  Future<void> _buildSettings(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary, width: 2)),
            title: Text(AppLocalizations.of(context)!.settings,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.dark_mode_sharp,
                      size: 30, color: Theme.of(context).colorScheme.onPrimary),
                  Text(AppLocalizations.of(context)!.darkMode,
                      style: Theme.of(context).textTheme.titleMedium),
                  Switch(
                      value: widget.themeViewModel.state is DarkThemeState,
                      onChanged: (value) {
                        widget.themeViewModel.switchTheme();
                      }),
                ]),
          );
        });
  }
}
