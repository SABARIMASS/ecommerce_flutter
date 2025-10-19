import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/app_style.dart';

class ExpandableHtmlDescription extends StatefulWidget {
  final String title;
  final String description;

  const ExpandableHtmlDescription({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<ExpandableHtmlDescription> createState() =>
      _ExpandableHtmlDescriptionState();
}

class _ExpandableHtmlDescriptionState extends State<ExpandableHtmlDescription> {
  bool isExpanded = true;
  final int maxLines = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: AppFontWeight.semiBold.value,
            fontSize: AppFontSize.small.value,
            color: AppColors.kPrimaryTextColor,
          ),
        ),
        SizedBox(height: 1.h),

        LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedCrossFade(
                  firstChild: _buildHtmlContent(maxLines: maxLines),
                  secondChild: _buildHtmlContent(),
                  crossFadeState: !isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 200),
                ),

                /// "Show more / Show less" action
                InkWell(
                  onTap: () => setState(() => isExpanded = !isExpanded),
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      !isExpanded ? "Show less" : "Show more",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: AppFontSize.extraSmall.value,
                        fontWeight: AppFontWeight.semiBold.value,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildHtmlContent({int? maxLines}) {
    return ClipRect(
      child: Html(
        data: widget.description,
        style: maxLines == null
            ? {
                "body": Style(
                  fontSize: FontSize.small,
                  fontWeight: FontWeight.bold,
                ),
              }
            : {
                "body": Style(
                  fontSize: FontSize.small,
                  maxLines: maxLines,
                  fontWeight: FontWeight.bold,
                  textOverflow: TextOverflow.ellipsis,
                  color: AppColors.kPrimaryTextColor,
                ),
              },
      ),
    );
  }
}
