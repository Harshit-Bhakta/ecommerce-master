import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/presentation/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({super.key,required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              // colorFilter: const ColorFilter.mode(Colors.red, BlendMode.colorBurn)
          ),
        ),
      ),
      placeholder: (context, url) => const CenterLoader(),
      errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.red,),
    );
  }
}
