import 'package:flutter/material.dart';
import 'package:giphy_picker/src/model/giphy_client.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:giphy_picker/src/model/giphy_decorator.dart';

/// Provides the context for a Giphy search operation, and makes its data available to its widget sub-tree.
class GiphyContext extends InheritedWidget {
  final String apiKey;
  final String rating;
  final String language;
  final bool sticker;
  final ValueChanged<GiphyGif>? onSelected;
  final ErrorListener? onError;
  final bool showPreviewPage;
  final GiphyDecorator decorator;
  final String searchText;
  final GiphyPreviewType? previewType;

  final String titlePreviewPage;
  final String beforeWatchPreviewPage;
  final String afterWatchPreviewPage;
  final Widget? moldura;
  final String searchTextInitial;

  /// Debounce delay when searching
  final Duration searchDelay;

  const GiphyContext({
    Key? key,
    required Widget child,
    required this.apiKey,
    this.rating = GiphyRating.g,
    this.language = GiphyLanguage.english,
    this.sticker = false,
    this.onSelected,
    this.onError,
    this.showPreviewPage = true,
    this.searchText = 'Search Giphy',
    this.searchDelay = const Duration(milliseconds: 500),
    this.titlePreviewPage = 'Preview',
    this.beforeWatchPreviewPage = 'Did you like it?',
    this.afterWatchPreviewPage =
        'GIFs with very short durations can create a bad experience. \n Ideal duration is 1~3 seconds, you can edit the duration in the next step.',
    required this.decorator,
    this.moldura,
    this.previewType,
    this.searchTextInitial = "",
  }) : super(key: key, child: child);

  void select(GiphyGif gif) => onSelected?.call(gif);
  void error(dynamic error) => onError?.call(error);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static GiphyContext of(BuildContext context) {
    final settings = context.getElementForInheritedWidgetOfExactType<GiphyContext>()?.widget as GiphyContext?;

    if (settings == null) {
      throw 'Required GiphyContext widget not found. Make sure to wrap your widget with GiphyContext.';
    }
    return settings;
  }
}
