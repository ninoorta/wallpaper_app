import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DisplayImage extends StatelessWidget {
  const DisplayImage({
    Key key,
    @required this.imageURL,
  }) : super(key: key);

  final String imageURL;

  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: Duration(days: 1),
    )
  );

  @override
  Widget build(BuildContext context) {
    // return Stack(children: <Widget>[
    //   Container(
    //     decoration: BoxDecoration(
    //         color: Colors.black12, borderRadius: BorderRadius.circular(15.0)),
    //     child: Center(
    //       child: CircularProgressIndicator(
    //         backgroundColor: Colors.transparent,
    //         // valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // default
    //       ),
    //     ),
    //   ),
    //   ClipRRect(
    //     borderRadius: BorderRadius.circular(15.0),
    //     child: FadeInImage.memoryNetwork(
    //       placeholder: kTransparentImage,
    //       height: 180,
    //       image: imageURL,
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    // ]);
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        // maxHeightDiskCache: 180,
        // maxWidthDiskCache: 126,
        cacheManager: customCacheManager,
        key: UniqueKey(),
        imageUrl: imageURL,
        height: 180,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.black12,
          ),
          child: Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url , error) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.black12
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Icon(Icons.error, color: Colors.red,),
                Text(error),
              ],
            ),
          ),
        ),
      ),
    );
  }
}