import '../../core/imports/imports.dart';

class CustomPaginationWidget extends StatefulWidget {
  final Function()? loadMore;
  final Function()? onRefresh;
  final ScrollController scrollController;

  final bool? scrollIndicatorShow;
  final bool isLoadingMore;

  final Widget child;

  const CustomPaginationWidget({
    super.key,
    this.loadMore,
    required this.child,
    required this.scrollController,
    this.onRefresh,
    this.scrollIndicatorShow = true,
    this.isLoadingMore = false,
  });

  @override
  State<CustomPaginationWidget> createState() => _CustomPaginationWidgetState();
}

class _CustomPaginationWidgetState extends State<CustomPaginationWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => widget.onRefresh?.call() ?? Future.value(),
      notificationPredicate: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification) {
          if (scrollNotification.metrics.maxScrollExtent <= scrollNotification.metrics.pixels) {
            if (!widget.isLoadingMore) {
              widget.loadMore?.call();
            }
          }
        }
        return true;
      },
      child: widget.scrollIndicatorShow ?? true
          ? RawScrollbar(
              controller: widget.scrollController,
              thumbColor: Theme.of(context).dialogTheme.backgroundColor?.withAlpha(76),
              thumbVisibility: false,
              interactive: true,
              thickness: 4,
              padding: const EdgeInsets.all(5),
              radius: const Radius.circular(10),
              child: _buildContent(),
            )
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        widget.child,
        if (widget.isLoadingMore)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.transparent,
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
