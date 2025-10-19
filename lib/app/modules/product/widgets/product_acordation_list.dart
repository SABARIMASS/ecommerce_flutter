import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/app_style.dart';
import '../data/product_detail_api_data.dart';

/// Widget to manage and display the accordion list of product tabs.
class ProductAccordionList extends StatefulWidget {
  final List<ProductTab> tabs;
  const ProductAccordionList({super.key, required this.tabs});

  @override
  State<ProductAccordionList> createState() => _ProductAccordionListState();
}

class _ProductAccordionListState extends State<ProductAccordionList> {
  // Holds the ID of the currently expanded tab. Null if none are expanded.
  String? _expandedTabId;

  // Toggle the expansion state, ensuring only one is open at a time.
  void _handleTap(String id) {
    setState(() {
      if (_expandedTabId == id) {
        _expandedTabId = null; // Collapse if already open
      } else {
        _expandedTabId = id; // Expand the new one
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget.tabs.map((tab) {
        // Ensure the tab has a valid ID for state management
        if (tab.id == null || tab.title == null) {
          return const SizedBox.shrink();
        }

        final bool isExpanded = _expandedTabId == tab.id;

        return Column(
          children: [
            // Tap area for the title and icon
            InkWell(
              onTap: () => _handleTap(tab.id!),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Text(
                      tab.title!,
                      style: appFont(
                        fontSize: AppFontSize.small,
                        fontWeight: AppFontWeight.medium,
                        color: AppColors.kPrimaryTextColor,
                      ),
                    ),

                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.kPrimaryTextColor,
                    ),
                  ],
                ),
              ),
            ),
            // Content Panel (Only visible if expanded)
            if (isExpanded)
              Html(
                data: tab.content.toString(),
                style: {
                  "body": Style(
                    fontSize: FontSize.small,
                    fontWeight: AppFontWeight.bold.value,
                  ),
                },
              ),
            // Separator Divider
            Divider(
              height: 1.h,
              color: AppColors.kGreyColor.withValues(alpha: 0.1),
            ),
          ],
        );
      }).toList(),
    );
  }
}
