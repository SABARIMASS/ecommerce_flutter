import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sephora/shared/app_style.dart';
import '../../core/utils/logger_util.dart';
import '../loader_widgets/app_loader.dart';
import 'page_nation_bottom_widget.dart';

class PaginatedGridView extends StatefulWidget {
  final Future<void> Function()? onRefresh; // Refresh event
  final Function? onPagination; // Pagination triggered
  final bool isPaginationLoading; // To display loading indicator
  final bool paginationOver; // Flag to disable further pagination
  final int itemCount; // Total items in the grid
  final Widget Function(BuildContext, int)
  itemBuilder; // Item builder for the grid
  final double aspectRatio; // Aspect ratio for the grid items
  final double mainAxisSpacing; // Vertical spacing between items
  final double crossAxisSpacing; // Horizontal spacing between items
  final int crossAxisCount; // Number of items per row
  final String?
  paginationErrorMessage; // Error message in case of pagination failure
  final Function? onPaginationRetry; // Retry function for pagination
  final String emptyMessage; // Message to show when the grid is empty
  final Color? backgroundColor;
  final Widget? gridEmptyWidget;
  final bool isLoading; // Flag to show loading widget
  final Widget loadingWidget; // Widget to display when loading
  final EdgeInsetsGeometry? padding;
  const PaginatedGridView({
    super.key,
    this.onRefresh,
    this.onPagination,
    this.isPaginationLoading = false,
    this.paginationOver = true,
    required this.itemCount,
    required this.itemBuilder,
    this.aspectRatio = 1.0,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.crossAxisCount = 2,
    this.paginationErrorMessage,
    this.onPaginationRetry,
    this.emptyMessage = "No Data Found",
    this.backgroundColor,
    this.gridEmptyWidget,
    this.isLoading = false,
    this.padding,
    Widget? loadingWidget,
  }) : loadingWidget = loadingWidget ?? const Center(child: AppLoader());

  @override
  State<PaginatedGridView> createState() => _PaginatedGridViewState();
}

class _PaginatedGridViewState extends State<PaginatedGridView> {
  bool paginationLock = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (!widget.isPaginationLoading &&
            !widget.paginationOver &&
            !paginationLock) {
          if (scrollNotification.metrics.pixels ==
              scrollNotification.metrics.maxScrollExtent) {
            paginationLock = true;

            LoggerUtil.debug("Pagination triggered: Loading more items...");

            if (widget.onPagination != null) {
              widget.onPagination!();
              Future.delayed(const Duration(seconds: 1), () {
                paginationLock = false;
              });
            }
          }
        }
        return false;
      },
      child: Container(
        color: widget.backgroundColor,
        child: widget.isLoading
            ? widget.loadingWidget
            : widget.itemCount == 0
            ? widget.gridEmptyWidget ??
                  Center(
                    child: Text(
                      widget.emptyMessage,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  )
            : widget.onRefresh != null
            ? RefreshIndicator(
                color: AppColors.kPrimaryColor,
                backgroundColor: AppColors.kPrimaryBackgroundColor,
                onRefresh: () async {
                  await Future.delayed(
                    const Duration(milliseconds: 500),
                  ); // Delay of 0.5 seconds
                  await widget.onRefresh!();
                },
                child: gridViewBuilder(),
              )
            : gridViewBuilder(),
      ),
    );
  }

  Widget gridViewBuilder() {
    return GridView.builder(
      shrinkWrap: true,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: widget.crossAxisSpacing,
        mainAxisSpacing: widget.mainAxisSpacing,
        childAspectRatio: widget.aspectRatio,
      ),
      itemCount: widget.itemCount + (widget.isPaginationLoading ? 1 : 0),
      padding:
          widget.padding ??
          EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      itemBuilder: (BuildContext context, int index) {
        if (index == widget.itemCount) {
          return PaginationLoader(
            isLoading: widget.isPaginationLoading,
            showMessage: true,
            errorMessage: widget.paginationErrorMessage,
            onRetry: widget.onPaginationRetry != null
                ? () {
                    widget.onPaginationRetry!();
                  }
                : null,
          );
        }
        return widget.itemBuilder(context, index);
      },
    );
  }
}
