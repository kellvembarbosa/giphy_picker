import 'package:flutter/material.dart';
import 'package:giphy_picker/src/model/giphy_repository.dart';
import 'package:giphy_picker/src/widgets/giphy_context.dart';
import 'package:giphy_picker/src/widgets/giphy_preview_page.dart';
import 'package:giphy_picker/src/widgets/giphy_thumbnail.dart';

/// A selectable grid view of gif thumbnails.
class GiphyThumbnailGrid extends StatelessWidget {
  final GiphyRepository repo;
  final ScrollController? scrollController;

  const GiphyThumbnailGrid({Key? key, required this.repo, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
        childAspectRatio: 1.6,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      padding: EdgeInsets.all(10),
      controller: scrollController,
      itemCount: repo.totalCount,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: GiphyThumbnail(key: Key('$index'), repo: repo, index: index),
          onTap: () async {
            // display preview page
            final giphy = GiphyContext.of(context);
            final gif = await repo.get(index);
            if (giphy.showPreviewPage) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Theme(
                    data: giphy.decorator.giphyTheme ?? Theme.of(context),
                    child: GiphyPreviewPage(
                      titlePreviewPage: giphy.titlePreviewPage,
                      afterWatchPreviewPage: giphy.afterWatchPreviewPage,
                      beforeWatchPreviewPage: giphy.beforeWatchPreviewPage,
                      gif: gif,
                      onSelected: giphy.onSelected,
                    ),
                  ),
                ),
              );
            } else {
              giphy.onSelected?.call(gif);
            }
          }),
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
      //   childAspectRatio: 1.6,
      //   crossAxisSpacing: 5,
      //   mainAxisSpacing: 5,
      // ),
    );
  }
}
