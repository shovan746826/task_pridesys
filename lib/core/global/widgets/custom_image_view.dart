import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/asset_config.dart';


class CustomImageView extends StatelessWidget {
  final String? imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;
  final Alignment alignment;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  final BoxBorder? border;
  final VoidCallback? onTap;

  final String placeHolder;
  final Widget? placeHolderWidget;

  const CustomImageView({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.margin,
    this.radius,
    this.border,
    this.onTap,
    this.placeHolder = "assets/icons/not_found.png",
    this.placeHolderWidget,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = _buildImageView();

    if (border != null) {
      child = Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: child,
      );
    }

    if (radius != null) {
      child = ClipRRect(
        borderRadius: radius  ?? BorderRadius.zero,
        child: child,
      );
    }

    if (onTap != null) {
      child = InkWell(onTap: onTap, child: child);
    }

    if (margin != null) {
      child = Padding(padding: margin!, child: child);
    }

    return Align(alignment: alignment, child: child);
  }

  Widget _buildImageView() {
    if (imagePath == null || imagePath!.isEmpty) {
      return _buildPlaceHolder();
    }

    switch (imagePath!.imageType) {
      case ImageType.svg:
        return _buildSvg();
      case ImageType.file:
        return _buildFile();
      case ImageType.gif:
        return _buildGif();
      case ImageType.network:
        return _buildNetwork();
      case ImageType.png:
      case ImageType.unknown:
      default:
        return _buildAsset();
    }
  }

  Widget _buildSvg() {
    if (imagePath!.startsWith('http')) {
      return SvgPicture.network(
        imagePath!,
        height: height,
        width: width,
        fit: fit,
        color: color,
        placeholderBuilder: (_) => _buildPlaceHolder(),
      );
    } else {
      return SvgPicture.asset(
        imagePath!,
        height: height,
        width: width,
        fit: fit,
        color: color,
      );
    }
  }

  Widget _buildAsset() {
    return Image.asset(
      imagePath!,
      height: height,
      width: width,
      fit: fit,
      color: color,
      errorBuilder: (_, __, ___) => _buildError(),
    );
  }

  Widget _buildFile() {
    return Image.file(
      File(imagePath!),
      height: height,
      width: width,
      fit: fit,
      color: color,
      errorBuilder: (_, __, ___) => _buildError(),
    );
  }

  /// GIF loader (network / file / asset)
  Widget _buildGif() {
    if (imagePath!.startsWith('http')) {
      // Network GIF: use Image.network for full animation
      return Image.network(
        imagePath!,
        height: height,
        width: width,
        fit: fit,
        color: color,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceHolder();
        },
        errorBuilder: (_, __, ___) => _buildError(),
      );
    } else if (imagePath!.startsWith('file://') || imagePath!.startsWith('/')) {
      return Image.file(
        File(imagePath!),
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: (_, __, ___) => _buildError(),
      );
    } else {
      return Image.asset(
        imagePath!,
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: (_, __, ___) => _buildError(),
      );
    }
  }

  /// Network loader for PNG/JPG
  Widget _buildNetwork() {
    if (imagePath!.endsWith('.gif')) {
      return _buildGif();
    }

    if (imagePath!.endsWith('.svg')) {
      return SvgPicture.network(
        imagePath!,
        height: height,
        width: width,
        fit: BoxFit.contain,
        color: color,
        placeholderBuilder: (_) => _buildPlaceHolder(),
      );
    }

    return CachedNetworkImage(
      imageUrl: imagePath!,
      height: height,
      width: width,
      fit: fit,
      color: color,
      placeholder: (_, __) => _buildPlaceHolder(),
      errorWidget: (_, __, ___) => _buildError(),
    );
  }

  Widget _buildPlaceHolder() {
    return placeHolderWidget ??
        Image.asset(
          placeHolder,
          height: height,
          width: width,
          fit: fit,
          color: color,
          errorBuilder: (_, __, ___) => _buildError(),
        );
  }

  Widget _buildError() {
    return Image.asset(
      AssetConfig.notFound,
      height: height ?? 40,
      width: width,
      fit: fit,
      color: color,
    );
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http')) return ImageType.network;
    if (endsWith('.svg')) return ImageType.svg;
    if (startsWith('file://') || startsWith('/')) return ImageType.file;
    if (endsWith('.gif')) return ImageType.gif;
    if (endsWith('.png') || endsWith('.jpg') || endsWith('.jpeg')) return ImageType.png;
    return ImageType.unknown;
  }
}

enum ImageType { svg, png, network, file, gif, unknown }
