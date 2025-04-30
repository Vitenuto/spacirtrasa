import 'package:flutter/material.dart';
import 'package:remove_markdown/remove_markdown.dart';

import '../../models/map_entity.dart';

class FavoriteTile extends ListTile {
  final MapEntity mapEntity;

  const FavoriteTile({super.key, required this.mapEntity});

  @override
  ListTile build(BuildContext context) {
    return ListTile(
      leading:
      mapEntity.imgUrl != null
          ? ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Image.network(mapEntity.imgUrl!),
      )
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(mapEntity.title), mapEntity.icon],
      ),
      subtitle: Text(
        mapEntity.markdownData.removeMarkdown(useImgAltText: false, replaceLinksWithURL: false),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      // onTap: () => , TODO: open details page
    );
  }
}
