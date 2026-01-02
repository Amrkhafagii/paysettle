import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import 'performance_repository.dart';

class FrameMetrics {
  const FrameMetrics({
    required this.totalFrames,
    required this.droppedFrames,
    required this.averageFrameMs,
    required this.worstFrameMs,
    required this.startedAt,
  });

  final int totalFrames;
  final int droppedFrames;
  final double averageFrameMs;
  final double worstFrameMs;
  final DateTime startedAt;

  Map<String, dynamic> toJson() => {
        'startedAt': startedAt.toUtc().toIso8601String(),
        'summary': {
          'frameCount': totalFrames,
          'droppedFrames': droppedFrames,
          'avgFrameTimeMs': averageFrameMs,
          'maxFrameTimeMs': worstFrameMs,
        },
        'samples': [
          {
            'type': 'frame_timing',
            'frameCount': totalFrames,
            'droppedFrames': droppedFrames,
            'avgFrameTimeMs': averageFrameMs,
            'maxFrameTimeMs': worstFrameMs,
          },
        ],
      };
}

class FrameTimingsMonitor {
  FrameTimingsMonitor(this._repository);

  final PerformanceRepository _repository;
  final Logger _logger = Logger('FrameTimingsMonitor');
  final List<FrameTiming> _buffer = <FrameTiming>[];
  late final TimingsCallback _callback = _handleTimings;
  Timer? _submitTimer;
  bool _isRunning = false;
  DateTime _startedAt = DateTime.now().toUtc();
  FrameMetrics _latest = FrameMetrics(
    totalFrames: 0,
    droppedFrames: 0,
    averageFrameMs: 0,
    worstFrameMs: 0,
    startedAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
  );

  FrameMetrics get latest => _latest;

  void start() {
    if (_isRunning) return;
    SchedulerBinding.instance.addTimingsCallback(_callback);
    _submitTimer ??=
        Timer.periodic(const Duration(minutes: 2), (_) => submitMetrics());
    _isRunning = true;
  }

  void stop() {
    if (!_isRunning) return;
    SchedulerBinding.instance.removeTimingsCallback(_callback);
    _submitTimer?.cancel();
    _submitTimer = null;
    _isRunning = false;
  }

  void _handleTimings(List<FrameTiming> timings) {
    _buffer.addAll(timings);
    if (_buffer.isEmpty) {
      return;
    }

    final totalFrames = _buffer.length;
    final dropped = _buffer
        .where((timing) => timing.totalSpan > const Duration(milliseconds: 16))
        .length;
    final avgMs = _buffer
            .map((timing) => timing.totalSpan.inMicroseconds / 1000)
            .reduce((value, element) => value + element) /
        totalFrames;
    final worstMs = _buffer
        .map((timing) => timing.totalSpan.inMicroseconds / 1000)
        .reduce((value, element) => value > element ? value : element);

    _latest = FrameMetrics(
      totalFrames: totalFrames,
      droppedFrames: dropped,
      averageFrameMs: double.parse(avgMs.toStringAsFixed(2)),
      worstFrameMs: double.parse(worstMs.toStringAsFixed(2)),
      startedAt: _startedAt,
    );
  }

  Future<void> submitMetrics() async {
    if (_buffer.isEmpty) {
      return;
    }

    final payload = _latest.toJson()
      ..addAll({
        'platform': defaultTargetPlatform.name,
        'deviceId': PlatformDispatcher.instance.locale.toLanguageTag(),
        'appVersion': const String.fromEnvironment('PAYSETTLE_VERSION',
            defaultValue: 'unknown'),
        'durationMs': DateTime.now().difference(_startedAt).inMilliseconds,
      });

    try {
      await _repository.logSession(payload);
      _buffer.clear();
      _startedAt = DateTime.now().toUtc();
    } catch (error, stack) {
      _logger.warning('Failed to submit frame timings', error, stack);
    }
  }

  void dispose() {
    stop();
  }
}

final frameTimingsMonitorProvider = Provider<FrameTimingsMonitor>((ref) {
  final monitor = FrameTimingsMonitor(ref.watch(performanceRepositoryProvider));
  monitor.start();
  ref.onDispose(monitor.dispose);
  return monitor;
});
