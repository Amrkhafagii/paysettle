import 'package:flutter/material.dart';

class LazyDataListView extends StatefulWidget {
  const LazyDataListView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.separatorBuilder,
    this.padding,
    this.physics,
    this.onEndReached,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.loadMoreOffset = 160,
  });

  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final int itemCount;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final Future<void> Function()? onEndReached;
  final bool isLoadingMore;
  final bool hasMore;
  final double loadMoreOffset;

  @override
  State<LazyDataListView> createState() => _LazyDataListViewState();
}

class _LazyDataListViewState extends State<LazyDataListView> {
  bool _triggered = false;

  bool _handleNotification(ScrollNotification notification) {
    if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - widget.loadMoreOffset &&
        widget.hasMore &&
        !widget.isLoadingMore &&
        widget.onEndReached != null &&
        !_triggered) {
      _triggered = true;
      widget.onEndReached!().whenComplete(() {
        if (mounted) {
          setState(() {
            _triggered = false;
          });
        } else {
          _triggered = false;
        }
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final separator = widget.separatorBuilder;
    final child = separator == null
        ? ListView.builder(
            padding: widget.padding,
            physics: widget.physics,
            itemBuilder: (context, index) {
              if (widget.isLoadingMore && index == widget.itemCount) {
                return const _LazyLoader();
              }
              return widget.itemBuilder(context, index);
            },
            itemCount: widget.itemCount + (widget.isLoadingMore ? 1 : 0),
          )
        : ListView.separated(
            padding: widget.padding,
            physics: widget.physics,
            itemBuilder: (context, index) {
              if (widget.isLoadingMore && index == widget.itemCount) {
                return const _LazyLoader();
              }
              return widget.itemBuilder(context, index);
            },
            separatorBuilder: (context, index) {
              if (widget.isLoadingMore && index >= widget.itemCount) {
                return const SizedBox.shrink();
              }
              return separator(context, index);
            },
            itemCount: widget.itemCount + (widget.isLoadingMore ? 1 : 0),
          );

    return NotificationListener<ScrollNotification>(
      onNotification: _handleNotification,
      child: child,
    );
  }
}

class _LazyLoader extends StatelessWidget {
  const _LazyLoader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
