import '../../core/imports/imports.dart';

class CustomPaginationWidget extends StatefulWidget {
  final Function()? loadMore;
  final Function()? onRefresh;
  final ScrollController scrollController;

  final bool? scrollIndicatorShow;

  final Widget child;

  const CustomPaginationWidget({
    super.key,
    this.loadMore,
    required this.child,
    required this.scrollController,
    this.onRefresh,
    this.scrollIndicatorShow = true,
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
      onRefresh: () => widget.onRefresh?.call(),
      notificationPredicate: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification) {
          if (scrollNotification.metrics.maxScrollExtent <= scrollNotification.metrics.pixels) {
            widget.loadMore?.call();
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
              child: widget.child,
            )
          : widget.child,
    );
  }
}
