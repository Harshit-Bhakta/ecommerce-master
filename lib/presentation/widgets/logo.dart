import 'package:ecommerce/presentation/utils/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  final double scale;
  final String path;
  const Logo({
    super.key,
    required this.scale,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: scale,
      width: scale,

    );
  }
}