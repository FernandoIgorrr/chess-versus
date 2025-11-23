import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:chess_versus/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../../../utils/image_constants.dart';
import '../../core/ui/custom_app_bar.dart';
import '../../core/ui/custom_image_view.dart';
import '../../tournament_form/view_models/tournament_form_view_model.dart';
import '../../tournament_form/widgets/tournament_form.dart';
import '../view_models/home_view_model.dart';
import 'home_body.dart';

class HomePage extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomePage({super.key, required this.viewModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Logger _log = Logger('HomePage');

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      floatingWidgetHeight: 64,
      floatingWidgetWidth: 64,
      floatingWidget: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: CustomImageView(
          color: Colors.white,
          imagePath: ImageConstants.iconTrophyLight,
          height: 56,
          width: 56,
        ),
        onPressed: () async {
          await _buildRegisterTournamentDialog(context);
        },
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
    await showModalBottomSheet(
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        context: context,
        builder: (_) {
          return TournamentForm(
              viewModel: TournamentFormViewModel(
            context.read(),
          ));
        });
    widget.viewModel.getTournaments();
  }
}
