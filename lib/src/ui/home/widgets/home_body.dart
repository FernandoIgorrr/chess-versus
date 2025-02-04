import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

import '../../../routing/routes.dart';
import '../../../utils/image_constants.dart';
import '../../core/theme_config/dimends.dart';
import '../../core/ui/card_error.dart';
import '../../core/ui/custom_image_view.dart';
import '../view_models/home_state.dart';
import '../view_models/home_view_model.dart';

class HomeBody extends StatefulWidget {
  final HomeViewModel viewModel;

  const HomeBody({super.key, required this.viewModel});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _log = Logger('HomeBody');
  @override
  void initState() {
    super.initState();
    widget.viewModel.getTournaments();
    //_log.fine('initState and getTournaments');
  }

  @override
  void didUpdateWidget(covariant HomeBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    //oldWidget.viewModel.getTournaments();
    widget.viewModel.getTournaments();
    // _log.fine('didUpdateWidget and getTournaments');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //   const SizedBox(height: 16),
        Expanded(
          child: ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, child) {
                Widget body = Container();
                final state = widget.viewModel.state;

                if (state is LoadingTournamentsState) {
                  body = const Center(child: CircularProgressIndicator());
                } else if (state is FailureGetTournamentsState) {
                  body = CardError(
                      message: state.message,
                      onTap: widget.viewModel.getTournaments);
                } else if (state is SucessGetTournamentsState) {
                  body = Center(
                    child: state.tournaments.isEmpty
                        ? Text(
                            AppLocalizations.of(context)!.emptyTournaments,
                            style: const TextStyle(
                              //color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          )
                        : ListView(
                            children:
                                state.tournaments.reversed.map((tournament) {
                              return Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: tournament == state.tournaments.last
                                          ? 16
                                          : 8,
                                      bottom:
                                          tournament == state.tournaments.first
                                              ? 16
                                              : 8,
                                      left: 16,
                                      right: 16),
                                  child: ListTile(
                                      onTap: () => context.push(
                                          Routes.tournamentWithId(
                                              tournament.id)),
                                      leading: SizedBox(
                                        height: 48,
                                        width: 48,
                                        child: CustomImageView(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                            imagePath:
                                                ImageConstants.iconTrophyLight),
                                      ),
                                      trailing: const Icon(Icons.chevron_right),
                                      horizontalTitleGap: Dimens.of(context)
                                          .paddingScreenHorizontal,
                                      minVerticalPadding: Dimens.of(context)
                                          .paddingScreenVertical,
                                      // tileColor: Theme.of(context).colorScheme.secondary,
                                      title: Text(
                                        tournament.name.toString(),
                                      ),
                                      subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer,
                                            ),
                                            Text(
                                              tournament.description ??
                                                  AppLocalizations.of(context)!
                                                      .tournamentNullDescription,
                                            ),
                                            Text(
                                              tournament.typeName.toString(),
                                            ),
                                            Text(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(tournament.startedAt),
                                            )
                                          ])),
                                ),
                              );
                            }).toList(),
                          ),
                  );
                }

                return body;
              }),
        ),
      ],
    );
  }
}
