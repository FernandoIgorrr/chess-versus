import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config/assets.dart';
import '../../../routing/routes.dart';
import '../../core/ui/card_error.dart';
import '../../core/ui/custom_app_bar.dart';
import '../../core/ui/custom_image_view.dart';
import '../view_models/page_view_view_model.dart';
import '../view_models/players/players_view_model.dart';
import '../view_models/tournament_state.dart';
import '../view_models/tournament_view_model.dart';
import 'content/classification_content/tournament_classification_content.dart';
import 'content/information_content/informations_content.dart';
import 'content/players_content/tournament_players_content.dart';
import 'content/tournament_rounds_content.dart';

class TournamentPage extends StatefulWidget {
  final TournamentViewModel _tournamentViewModel;
  final PageViewViewModel _pageViewViewModel;
  final PlayersViewModel _playersViewModel;
  const TournamentPage(
      {super.key,
      required TournamentViewModel tournamentViewModel,
      required PageViewViewModel pageViewViewModel,
      required PlayersViewModel playersViewModel})
      : _tournamentViewModel = tournamentViewModel,
        _pageViewViewModel = pageViewViewModel,
        _playersViewModel = playersViewModel;

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  final _log = Logger("TournamentPage");

  double iconSize = 32;

  @override
  void initState() {
    super.initState();
    //widget._pageViewViewModel.pageController.initialPage = 0;
    widget._pageViewViewModel
        .emit(widget._pageViewViewModel.pageController.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    Map<int, String> title = {
      0: AppLocalizations.of(context)!.classification,
      1: AppLocalizations.of(context)!.rounds,
      2: AppLocalizations.of(context)!.players,
      3: AppLocalizations.of(context)!.informations
    };
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) context.go(Routes.home);
      },
      child: ListenableBuilder(
          listenable: widget._tournamentViewModel,
          builder: (context, child) {
            var state = widget._tournamentViewModel.state;
            Widget body = Container();
            if (state is LoadingTournamentState) {
              body = const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessTournamentState) {
              _log.fine('state is TournamentSuccessState');
              widget._playersViewModel.getPlayers(state.tournament.getId);
              body = ListenableBuilder(
                  listenable: widget._pageViewViewModel,
                  builder: (context, child) {
                    return PageView(
                      controller: widget._pageViewViewModel.pageController,
                      onPageChanged: widget._pageViewViewModel.emit,
                      children: [
                        TournamentClassificationContent(
                          tournamentViewModel: widget._tournamentViewModel,
                          playersViewModel: widget._playersViewModel,
                        ),
                        const TournamentRoundsContent(),
                        TournamentPlayersContent(
                          tournamentViewModel: widget._tournamentViewModel,
                          playersViewModel: widget._playersViewModel,
                        ),
                        TournamentInformationsContent(
                          tournamentViewModel: widget._tournamentViewModel,
                          playersViewModel: widget._playersViewModel,
                        ),
                      ],
                    );
                  });
            } else if (state is FailureTournamentState) {
              _log.warning('state is TournamentFailureState');
              body = Center(
                child: CardError(message: state.message),
              );
            }

            return Scaffold(
              appBar: CustomAppBar(
                themeViewModel: context.read(),
                title: AnimatedBuilder(
                    animation: widget._pageViewViewModel,
                    builder: (context, child) {
                      var page = widget._pageViewViewModel.page;
                      return Text(title[page]!);
                    }),
              ),
              body: body,
              bottomNavigationBar: ListenableBuilder(
                  listenable: widget._pageViewViewModel,
                  builder: (context, child) {
                    return BottomNavigationBar(
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      iconSize: iconSize,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      // selectedItemColor: Theme.of(context).colorScheme.tertiary,
                      currentIndex: widget._pageViewViewModel.page,
                      items: [
                        _buildBottomNavigationBarItem(
                            IconAssets.iconGroupOfMenRunning,
                            'Classificação',
                            0),
                        _buildBottomNavigationBarItem(
                            IconAssets.iconCharmBinary, 'Rodadas', 1),
                        _buildBottomNavigationBarItem(
                            IconAssets.iconElGroup, 'Jogadores', 2),
                        _buildBottomNavigationBarItem(
                            IconAssets.iconInfo, 'Info', 3),
                      ],
                      onTap: widget._pageViewViewModel.animateToPage,
                    );
                  }),
            );
          }),
    );
  }

  _buildBottomNavigationBarItem(String imagePath, String label, int index) {
    return BottomNavigationBarItem(
      icon: CustomImageView(
        color: index == widget._pageViewViewModel.page
            ? Colors.white
            : Theme.of(context).colorScheme.onPrimaryContainer,
        imagePath: imagePath,
        height: iconSize,
        width: iconSize,
      ),
      label: label,
    );
  }
}
