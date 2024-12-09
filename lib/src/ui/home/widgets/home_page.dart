import 'package:chess_versus/src/ui/core/ui/custom_app_bar.dart';
import 'package:chess_versus/src/ui/home/view_models/home_view_model.dart';
import 'package:chess_versus/src/ui/home/widgets/home_body.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/image_constants.dart';
import '../../core/ui/custom_image_view.dart';
import 'home_create_tournament_widget.dart';

class HomePage extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomePage({super.key, required this.viewModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      floatingWidgetHeight: 64,
      floatingWidgetWidth: 64,
      floatingWidget: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
          themeViewModel: context.read(),
        ),
        body: HomeBody(viewModel: widget.viewModel),
      ),
    );
  }

  Future<void> _buildRegisterTournamentDialog(BuildContext context) async {
    showModalBottomSheet(
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        context: context,
        builder: (_) {
          return const HomeCreateTournamentWidget();
        });
  }
}
