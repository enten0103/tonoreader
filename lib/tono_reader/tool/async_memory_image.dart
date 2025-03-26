import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AsyncMemoryImage extends ImageProvider<AsyncMemoryImage> {
  final Future<Uint8List> dataFuture;
  final String? cacheKey;

  AsyncMemoryImage(this.dataFuture, {this.cacheKey});

  static final Map<String, Uint8List> _imageCache = {};
  static final Map<String, Future<Uint8List>> _pendingRequests = {};

  /// 清除指定缓存
  static void evictFromCache(String cacheKey) {
    _imageCache.remove(cacheKey);
  }

  /// 清除所有缓存
  static void clearCache() {
    _imageCache.clear();
  }

  @override
  Future<AsyncMemoryImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<AsyncMemoryImage>(this);
  }

  @override
  ImageStreamCompleter loadImage(
    AsyncMemoryImage key,
    ImageDecoderCallback decode,
  ) {
    Future<Codec> codecFuture;

    final cacheKey = key.cacheKey;
    if (cacheKey != null) {
      if (_imageCache.containsKey(cacheKey)) {
        // 从缓存中直接加载
        final cachedData = _imageCache[cacheKey]!;
        codecFuture = _decodeData(cachedData, decode);
      } else {
        // 处理并发请求
        codecFuture = _handlePendingRequest(key, decode, cacheKey);
      }
    } else {
      // 无缓存模式
      codecFuture = key.dataFuture.then<Codec>(
        (data) => _decodeData(data, decode),
      );
    }

    return MultiFrameImageStreamCompleter(
      codec: codecFuture,
      scale: 1.0,
      debugLabel: 'AsyncMemoryImage($cacheKey)',
      informationCollector: () => <DiagnosticsNode>[
        DiagnosticsProperty<ImageProvider>('Image provider', this),
        if (cacheKey != null)
          DiagnosticsProperty<String>('Cache key', cacheKey),
      ],
    );
  }

  Future<Codec> _handlePendingRequest(
    AsyncMemoryImage key,
    ImageDecoderCallback decode,
    String cacheKey,
  ) {
    if (!_pendingRequests.containsKey(cacheKey)) {
      _pendingRequests[cacheKey] = key.dataFuture.then((data) {
        _imageCache[cacheKey] = data;
        _pendingRequests.remove(cacheKey);
        return data;
      });
    }

    return _pendingRequests[cacheKey]!.then<Codec>(
      (data) => _decodeData(data, decode),
    );
  }

  Future<Codec> _decodeData(
    Uint8List data,
    ImageDecoderCallback decode,
  ) async {
    final buffer = await ImmutableBuffer.fromUint8List(data);
    return decode(buffer);
  }
}
