library giphy_picker;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:giphy_picker/src/model/giphy_client.dart';
import 'package:giphy_picker/src/model/giphy_decorator.dart';
import 'package:giphy_picker/src/model/giphy_preview_types.dart';
import 'package:giphy_picker/src/widgets/giphy_context.dart';
import 'package:giphy_picker/src/widgets/giphy_search_page.dart';

export 'package:giphy_picker/src/model/giphy_client.dart';
export 'package:giphy_picker/src/widgets/giphy_image.dart';
export 'package:giphy_picker/src/model/giphy_decorator.dart';
export 'package:giphy_picker/src/model/giphy_preview_types.dart';

typedef ErrorListener = void Function(dynamic error);

/// Provides Giphy picker functionality.
class GiphyPicker {
  /// Renders a full screen modal dialog for searching, and selecting a Giphy image.
  static Future<GiphyGif?> pickGif({
    required BuildContext context,
    required String apiKey,
    String rating = GiphyRating.g,
    String lang = GiphyLanguage.english,
    bool sticker = false,
    Widget? title,
    ErrorListener? onError,
    bool showPreviewPage = true,
    GiphyDecorator? decorator,
    bool fullScreenDialog = true,
    String searchText = 'Search GIPHY',
    GiphyPreviewType? previewType,
    String titlePreviewPage = 'Preview',
    String beforeWatchPreviewPage = 'Did you like it?',
    String afterWatchPreviewPage =
        'GIFs with very short durations can create a bad experience. \n Ideal duration is 1~3 seconds, you can edit the duration in the next step.',
    String searchTextInitial = "",
  }) async {
    GiphyGif? result;
    final _decorator = decorator ?? GiphyDecorator();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => GiphyContext(
          decorator: _decorator,
          previewType: previewType ?? GiphyPreviewType.previewGif,
          child: GiphySearchPage(
            title: title,
          ),
          apiKey: apiKey,
          rating: rating,
          language: lang,
          sticker: sticker,
          onError: onError ?? (error) => _showErrorDialog(context, error),
          onSelected: (gif) {
            result = gif;
            // pop preview page if necessary
            if (showPreviewPage) {
              Navigator.pop(context);
            }
            // pop giphy_picker
            Navigator.pop(context);
          },
          showPreviewPage: showPreviewPage,
          searchText: searchText,
          titlePreviewPage: titlePreviewPage,
          beforeWatchPreviewPage: beforeWatchPreviewPage,
          afterWatchPreviewPage: afterWatchPreviewPage,
          searchTextInitial: searchTextInitial,
        ),
        fullscreenDialog: fullScreenDialog,
      ),
    );

    return result;
  }

  static void _showErrorDialog(BuildContext context, dynamic error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Giphy error'),
          content: Text('An error occurred. $error'),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
