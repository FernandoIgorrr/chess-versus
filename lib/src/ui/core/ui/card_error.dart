import 'package:chess_versus/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardError extends StatelessWidget {
  CardError({super.key, required this.message, this.onTap});

  final String message;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Erro',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onError,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).colorScheme.error),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(16),
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.error,
                        color: Theme.of(context).colorScheme.error),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.somethingWentWrong,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
