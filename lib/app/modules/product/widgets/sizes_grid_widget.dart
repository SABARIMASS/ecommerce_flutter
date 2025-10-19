import 'package:flutter/material.dart';

class OverlapSelectionRow extends StatefulWidget {
  final List<String> items;
  final Function(String) onItemSelected;
  final double overlap;
  final double itemWidth;

  const OverlapSelectionRow({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.overlap = 15.0, // How much each item overlaps the previous one
    this.itemWidth = 80.0, // Standard width for each item container
  });

  @override
  State<OverlapSelectionRow> createState() => _OverlapSelectionRowState();
}

class _OverlapSelectionRowState extends State<OverlapSelectionRow> {
  // State variable to track the currently selected item
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    // 1. Calculate the total required width for the Stack
    // Total Width = (Number of items * Item Width) - (Number of overlaps * Overlap amount)
    double totalWidth =
        (widget.items.length * widget.itemWidth) -
        ((widget.items.length - 1) * widget.overlap);

    return SizedBox(
      height: 40, // Fixed height for the items
      width: totalWidth,
      child: Stack(
        alignment: Alignment.centerLeft, // Align items from the left
        children: List.generate(widget.items.length, (index) {
          final item = widget.items[index];

          // Calculate the horizontal position for each item
          // Position = index * (Item Width - Overlap amount)
          double leftPosition = index * (widget.itemWidth - widget.overlap);

          // Check if the current item is selected
          bool isSelected = item == _selectedItem;

          return Positioned(
            left: leftPosition,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  // Update the selected item
                  _selectedItem = item;
                });
                // Call the constructor function with the selected value
                widget.onItemSelected(item);
              },
              child: Container(
                width: widget.itemWidth,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  // Apply black border only to the selected item
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.grey.shade300,
                    width: isSelected ? 2.0 : 1.0,
                  ),
                  // Subtle shadow for depth
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 2,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
