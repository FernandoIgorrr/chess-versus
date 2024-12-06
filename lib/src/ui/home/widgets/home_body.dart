import 'package:chess_versus/src/ui/core/themes/dimends.dart';
import 'package:chess_versus/src/ui/core/ui/card_error.dart';
import 'package:chess_versus/src/ui/home/view_models/home_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../view_models/home_view_model.dart';

class HomeBody extends StatefulWidget {
  final HomeViewModel viewModel;

  const HomeBody({super.key, required this.viewModel});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getTournaments();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, child) {
                Widget body = Container();
                final state = widget.viewModel.state;

                if (state is LoadingTournamentsState) {
                  body = const Center(child: CircularProgressIndicator());
                } else if (state is FailedGetTournamentsState) {
                  body = CardError(
                      message: state.message,
                      onTap: widget.viewModel.getTournaments);
                } else if (state is SucessGetTournamentsState) {
                  body = Center(
                    child: state.tournaments.isEmpty
                        ? Text(AppLocalizations.of(context)!.emptyTournaments)
                        : ListView.builder(
                            itemCount: state.tournaments.length,
                            itemBuilder: (context, index) {
                              return Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: Dimens.of(context)
                                          .paddingScreenHorizontal),
                                  child: ListTile(
                                      horizontalTitleGap: Dimens.of(context)
                                          .paddingScreenHorizontal,
                                      minVerticalPadding: Dimens.of(context)
                                          .paddingScreenVertical,
                                      tileColor:
                                          Theme.of(context).colorScheme.surface,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          )),
                                      title: Text(
                                        state.tournaments[index].getName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.tournaments[index]
                                                      .getDescription ??
                                                  AppLocalizations.of(context)!
                                                      .tournamentNullDescription,
                                            ),
                                            Text(
                                              state.tournaments[index]
                                                  .getTypeName
                                                  .toString(),
                                            ),
                                            Text(
                                              DateFormat('dd/MM/yyyy').format(
                                                  state.tournaments[index]
                                                      .getStartedAt),
                                            )
                                          ])),
                                ),
                              );
                            },
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
