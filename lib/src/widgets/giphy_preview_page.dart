import 'package:flutter/material.dart';
import 'package:giphy_picker/src/model/giphy_client.dart';
import 'package:giphy_picker/src/widgets/giphy_context.dart';
import 'package:giphy_picker/src/widgets/giphy_image.dart';

/// Presents a Giphy preview image.
class GiphyPreviewPage extends StatelessWidget {
  final GiphyGif gif;
  final ValueChanged<GiphyGif>? onSelected;

  final String titlePreviewPage;
  final String beforeWatchPreviewPage;
  final String afterWatchPreviewPage;

  const GiphyPreviewPage({
    required this.gif,
    required this.onSelected,
    required this.titlePreviewPage,
    required this.beforeWatchPreviewPage,
    required this.afterWatchPreviewPage,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(titlePreviewPage), actions: <Widget>[IconButton(icon: Icon(Icons.check), onPressed: () => onSelected?.call(gif))]),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  beforeWatchPreviewPage,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: media.size.height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(color: Colors.grey, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  width: 220,
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: GiphyImage.original(
                        renderGiphyOverlay: false,
                        gif: gif,
                        width: 220, //media.orientation == Orientation.portrait ? double.maxFinite : null,
                        height: 250,
                        //height: media.orientation == Orientation.landscape ? double.maxFinite : null,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  afterWatchPreviewPage,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        bottom: false,
      ),
    );
  }
}
