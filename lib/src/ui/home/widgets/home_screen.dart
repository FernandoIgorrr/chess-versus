import 'package:chess_versus/src/ui/home/view_models/home_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewModel viewModel;

  const HomeScreen({super.key, required this.viewModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.deleteTournament.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.deleteTournament.removeListener(_onResult);
    widget.viewModel.deleteTournament.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.deleteTournament.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(),
    );
  }

  void _onResult() {
    if (widget.viewModel.deleteTournament.completed) {
      widget.viewModel.deleteTournament.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              AppLocalizations.of(context)!.successWhileDeletingATournament),
        ),
      );
    }

    if (widget.viewModel.deleteTournament.error) {
      widget.viewModel.deleteTournament.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(AppLocalizations.of(context)!.errorWhileDeletingATournament),
        ),
      );
    }
  }
}
