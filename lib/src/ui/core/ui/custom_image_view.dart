import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')) {
      ImageType.file;
    } else {
      return ImageType.png;
    }
    return ImageType.png;
  }
}

enum ImageType { svg, png, network, file, unknow }

class CustomImageView extends StatelessWidget {
  const CustomImageView({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.margin,
    this.radius,
    this.border,
    this.placeHolder = 'assets/images/image_not_found.png',
  });

  ///[imagePath] is required parameter for showing image final String? imagePath;
  final String? imagePath;

  final double? height;

  final double? width;

  final Color? color;

  final BoxFit? fit;

  final String placeHolder;

  final Alignment? alignment;

  final VoidCallback? onTap;

  final EdgeInsetsGeometry? margin;

  final BorderRadius? radius;

  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildWidget(context))
        : _buildWidget(context);
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(context),
      ),
    );
  }

  ///build the image with border radius
  _buildCircleImage(BuildContext context) {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(context),
      );
    } else {
      return _buildImageWithBorder(context);
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder(BuildContext context) {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(context),
      );
    } else {
      return _buildImageView(context);
    }
  }

  Widget _buildImageView(BuildContext context) {
    if (imagePath != null) {
      switch (imagePath!.imageType) {
        case ImageType.svg:
          return SizedBox(
            height: height,
            width: width,
            child: SvgPicture.asset(
              imagePath!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              colorFilter: color != null
                  ? ColorFilter.mode(
                      color ?? Colors.transparent, BlendMode.srcIn)
                  : ColorFilter.mode(
                      Theme.of(context).colorScheme.primary, BlendMode.srcIn),
            ),
          );

        case ImageType.file:
          return Image.file(
            File(imagePath!),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );

        case ImageType.network:
          return CachedNetworkImage(
            height: height,
            width: width,
            imageUrl: imagePath!,
            color: color,
            placeholder: (context, url) => SizedBox(
              height: 30,
              width: 30,
              child: LinearProgressIndicator(
                color: Colors.grey.shade200,
                backgroundColor: Colors.grey.shade100,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(placeHolder,
                height: height, width: width, fit: fit ?? BoxFit.cover),
          );

        case ImageType.png:
        default:
          return Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
      }
    }
    return const SizedBox();
  }
}