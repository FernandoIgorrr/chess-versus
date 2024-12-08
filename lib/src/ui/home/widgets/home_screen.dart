import 'package:chess_versus/src/ui/core/themes/provider/theme_provider.dart';
import 'package:chess_versus/src/ui/core/ui/custom_app_bar.dart';
import 'package:chess_versus/src/ui/home/view_models/home_view_model.dart';
import 'package:chess_versus/src/ui/home/widgets/home_body.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../utils/image_constants.dart';
import '../../core/ui/custom_image_view.dart';
import 'home_create_tournament.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewModel viewModel;
  final themeViewModel = ThemeProvider.getInstance();
  HomeScreen({super.key, required this.viewModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      floatingWidgetHeight: 64,
      floatingWidgetWidth: 64,
      floatingWidget: FloatingActionButton(
        child: CustomImageView(
          imagePath: ImageConstants.iconTrophyLight,
          height: 56,
          width: 56,
        ),
        onPressed: () => {_buildRegisterTournamentDialog(context)},
      ),
      mainScreenWidget: Scaffold(
        appBar: CustomAppBar(
          title: Text(AppLocalizations.of(context)!.tournaments),
        ),
        body: HomeBody(viewModel: widget.viewModel),
      ),
    );
  }

  Future<void> _buildRegisterTournamentDialog(BuildContext context) {
    return showDialog<void>(
        useRootNavigator: true,
        context: context,
        builder: (BuildContext context) {
          return const CreateTournamentWidget();
        });
  }
}
