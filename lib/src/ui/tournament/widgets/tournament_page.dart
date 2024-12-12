import 'package:chess_versus/src/routing/router.dart';
import 'package:chess_versus/src/ui/core/ui/card_error.dart';
import 'package:chess_versus/src/ui/core/ui/custom_app_bar.dart';
import 'package:chess_versus/src/ui/tournament/view_models/tournament_state.dart';
import 'package:chess_versus/src/ui/tournament/view_models/tournament_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../../../routing/routes.dart';

class TournamentPage extends StatefulWidget {
  final TournamentViewModel _viewModel;

  const TournamentPage({super.key, required TournamentViewModel viewModel})
      : _viewModel = viewModel;

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  final _log = Logger("TournamentPage");

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) context.go(Routes.home);
      },
      child: SafeArea(
          child: ListenableBuilder(
              listenable: widget._viewModel,
              builder: (context, child) {
                var state = widget._viewModel.state;
                CustomAppBar appBar =
                    CustomAppBar(themeViewModel: context.read());
                Widget body = Container();

                if (state is TournamentSuccessState) {
                  appBar = CustomAppBar(
                    themeViewModel: context.read(),
                    title: Text(state.tournament.getName.toString()),
                  );
                  body = const Center(
                    child: Text("Qualquer coisa"),
                  );
                } else if (state is TournamentFailureState) {
                  _log.warning('state is TournamentFailureState');
                  body = Center(
                    child: CardError(message: state.message),
                  );
                }

                return Scaffold(
                  appBar: appBar,
                  body: body,
                );
              })),
    );
  }
}
