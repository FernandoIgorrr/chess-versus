import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../theme_config/view_models/theme_state.dart';
import '../theme_config/view_models/theme_switch_view_model.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ThemeSwitchViewModel themeViewModel;
  CustomAppBar({super.key, this.title, required this.themeViewModel});

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
            title: Text(AppLocalizations.of(context)!.settings,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.dark_mode_sharp,
                        size: 30,
                      ),
                      Text(
                        AppLocalizations.of(context)!.darkMode,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      ListenableBuilder(
                          listenable: widget.themeViewModel,
                          builder: (context, child) {
                            return Switch(
                                value: widget.themeViewModel.state
                                    is DarkThemeState,
                                onChanged: (value) {
                                  widget.themeViewModel.toggle;
                                });
                          }),
                    ]),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.language,
                      size: 30,
                    ),
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const Icon(Icons.account_box_outlined)
                  ],
                )
              ],
            ),
          );
        });
  }
}
