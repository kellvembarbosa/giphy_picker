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
      appBar: AppBar(title: Text(titlePreviewPage), actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.green,
              size: 32,
            ),
            onPressed: () => onSelected?.call(gif))
      ]),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Stack(
                  children: [
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
                      height: 260,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: GiphyImage.original(
                            renderGiphyOverlay: false,
                            gif: gif,
                            width: 220, //media.orientation == Orientation.portrait ? double.maxFinite : null,
                            height: 260,
                            //height: media.orientation == Orientation.landscape ? double.maxFinite : null,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.8,
                      child: SizedBox(
                        height: 260,
                        width: 220,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 24.0,
                            right: 16,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "TUE 24 ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "11:10",
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 36,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  beforeWatchPreviewPage,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        //fontSize: media.size.height * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      afterWatchPreviewPage,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
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
